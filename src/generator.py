#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
重构后的主生成器
整合各个模块，实现SOC自动连线功能
"""
import os
from typing import Dict, List, Optional
from .data_structures import Instance
from .config_manager import ConfigManager
from .parser import PyVerilogParser
from .connection_manager import ConnectionManager
from .code_generator import VerilogCodeGenerator
from .logger import get_logger, set_debug_level

logger = get_logger(__name__)


class AutoWireGenerator:
    """重构后的AutoWire生成器"""
    
    def __init__(self, config_file: str, bounding_file: str = 'bounding.yaml', debug: bool = False):
        # 设置调试级别
        set_debug_level(debug)
        self.debug = debug  # 保存调试标志
        
        # 初始化各个组件
        self.config_manager = ConfigManager(config_file, bounding_file)
        self.parser: Optional[PyVerilogParser] = None  # 延迟初始化，需要输出目录
        self.connection_manager: Optional[ConnectionManager] = None  # 需要协议信号后初始化
        self.code_generator: Optional[VerilogCodeGenerator] = None      # 需要顶层模块名后初始化
        
        # 数据存储
        self.module_files: Dict[str, str] = {}  # 模块名 -> 文件路径映射
        self.instances: List[Instance] = []
        
        # 配置文件路径记录（用于中间文件处理）
        self.original_config_file = config_file
        self.current_config_file = config_file
        
    def generate(self, output_path: str) -> bool:
        """生成SOC顶层文件"""
        logger.info("Starting SOC generation with new architecture...")
        
        try:
            # 1. 解析输出路径，为解析器初始化做准备
            output_dir = self._get_output_directory(output_path)
            
            # 2. 初始化解析器（需要输出目录）
            self.parser = PyVerilogParser(debug=self.debug, output_dir=output_dir)
            
            # 3. 加载配置
            if not self._load_configurations():
                return False
                
            # 4. 初始化其余组件
            self._initialize_components()
            
            # 5. 解析阶段
            if not self._parse_phase():
                return False
                
            # 6. 连线阶段
            if not self._connection_phase(output_path):
                return False
                
            # 7. 生成阶段
            if not self._generation_phase(output_path):
                return False
                
            # 8. 清理pyverilog parse生成的中间PLY文件
            if self.parser:
                self.parser.cleanup_ply_files()
                
            logger.info("Generation completed successfully!")
            return True
            
        except Exception as e:
            logger.error(f"Generation failed: {e}")
            return False
            
    def _load_configurations(self) -> bool:
        """加载配置阶段"""
        logger.info("Loading configurations...")
        
        # 加载主配置
        if not self.config_manager.load_config():
            return False
            
        # 加载协议信号（非必需）
        self.config_manager.load_protocol_signals()
        
        return True
        
    def _initialize_components(self):
        """初始化其余组件"""
        # 初始化连线管理器
        protocol_signals = self.config_manager.get_protocol_signals()
        self.connection_manager = ConnectionManager(protocol_signals)
        
        # 初始化代码生成器
        top_module_name = self.config_manager.get_top_module_name()
        self.code_generator = VerilogCodeGenerator(top_module_name)
        
    def _parse_phase(self) -> bool:
        """解析阶段"""
        logger.info("Parsing phase...")
        
        # 确保解析器已经初始化
        if self.parser is None:
            logger.error("Parser not initialized")
            return False
        
        # 1. 解析宏定义
        define_files = self.config_manager.get_define_files()
        if define_files:
            global_defines = self.parser.parse_defines_from_files(define_files)
            logger.info(f"Parsed {len(global_defines)} global defines")
        else:
            logger.info("No define files specified")
            
        # 2. 发现模块
        rtl_files = self.config_manager.get_rtl_files()
        if not rtl_files:
            logger.error("No RTL files specified in configuration")
            return False
            
        self.module_files = self.parser.find_modules_in_files(rtl_files)
        logger.info(f"Found {len(self.module_files)} modules in RTL files")
        
        # 3. 解析实例配置
        instances_config = self.config_manager.get_instances_config()
        for inst_config in instances_config:
            # 确保参数值都是字符串类型
            parameters = {}
            raw_parameters = inst_config.get('parameters', {})
            # 处理YAML中parameters为None的情况
            if raw_parameters is None:
                raw_parameters = {}
            for param_name, param_value in raw_parameters.items():
                parameters[param_name] = str(param_value)  # 转换为字符串
                
            instance = Instance(
                module_name=inst_config['module'],
                instance_name=inst_config['name'],
                parameters=parameters
            )
            self.instances.append(instance)
            logger.debug(f"Created instance: {instance.instance_name} ({instance.module_name})")
            if parameters:
                logger.debug(f"  Parameters: {parameters}")
            
        # 4. 解析实例对应的模块详细信息
        for instance in self.instances:
            module_name = instance.module_name
            if module_name not in self.module_files:
                logger.warning(f"Module {module_name} file not found")
                continue
                
            file_path = self.module_files[module_name]
            
            # 使用pyverilog解析模块
            module_info = self.parser.parse_module_from_file(
                file_path, module_name, instance.parameters
            )
            
            if module_info and module_info.ports:
                instance.ports = module_info.ports
                logger.debug(f"Parsed {len(instance.ports)} ports for {instance.instance_name}")
            else:
                logger.warning(f"No ports found for instance {instance.instance_name}")
                
        return True
        
    def _connection_phase(self, output_path: str) -> bool:
        """连线阶段"""
        logger.info("Connection phase...")
        
        # 设置实例到连线管理器
        if self.connection_manager is None:
            logger.error("Connection manager not initialized")
            return False
        self.connection_manager.set_instances(self.instances)
        
        # 1. 处理协议连线，生成中间连接
        bounding_config = self.config_manager.get_bounding_config()
        generated_connections = self.connection_manager.process_protocol_connections(bounding_config)
        
        # 2. 如果有生成的连接，创建中间配置文件并重新加载
        if generated_connections:
            intermediate_file = self.config_manager.create_intermediate_config(
                generated_connections, output_path
            )
            if intermediate_file:
                # 更新配置管理器使用中间文件
                self.current_config_file = intermediate_file
                self.config_manager.config_file = intermediate_file
                if not self.config_manager.load_config():
                    return False
                    
        # 3. 处理手动连线（包括生成的协议连线）
        connections_config = self.config_manager.get_connections_config()
        self.connection_manager.process_manual_connections(connections_config)
        
        # 4. 自动连线
        self.connection_manager.auto_connect_ports()
        
        return True
        
    def _generation_phase(self, output_path: str) -> bool:
        """生成阶段"""
        logger.info("Code generation phase...")
        
        # 1. 检查组件初始化
        if self.code_generator is None or self.connection_manager is None:
            logger.error("Code generator or connection manager not initialized")
            return False
        
        # 2. 设置数据到代码生成器
        self.code_generator.set_instances(self.instances)
        wire_set = self.connection_manager.get_wire_set()
        self.code_generator.set_wire_set(wire_set)
        
        # 3. 生成顶层端口
        self.code_generator.generate_top_ports()
        
        # 4. 解析输出路径
        output_file = self._resolve_output_path(output_path)
        if not output_file:
            return False
            
        # 5. 生成顶层模块
        self.code_generator.generate_top_module(output_file)
        
        # 6. 清理中间文件（非调试模式）
        self._cleanup_intermediate_files()
        
        return True
        
    def _resolve_output_path(self, output_path: str) -> Optional[str]:
        """解析输出路径"""
        # 判断是否显式指定文件
        if output_path.lower().endswith(('.v', '.sv')) and not os.path.isdir(output_path):
            parent = os.path.dirname(output_path)
            if parent and not os.path.isdir(parent):
                try:
                    os.makedirs(parent, exist_ok=True)
                except Exception as e:
                    logger.error(f"Cannot create parent directory {parent}: {e}")
                    return None
            return output_path
            
        # 按目录处理
        out_dir = output_path
        if not os.path.isdir(out_dir):
            try:
                os.makedirs(out_dir, exist_ok=True)
            except Exception as e:
                logger.error(f"Cannot create output directory {out_dir}: {e}")
                return None
                
        top_name = self.config_manager.get_top_module_name()
        return os.path.join(out_dir, f"{top_name}.v")
        
    def _cleanup_intermediate_files(self):
        """清理中间文件"""
        # 只在非调试模式下清理，并且当前配置文件不是原始文件时
        if (not self.debug and 
            self.current_config_file != self.original_config_file and 
            os.path.exists(self.current_config_file)):
            try:
                os.remove(self.current_config_file)
                logger.info(f"Removed intermediate file: {self.current_config_file}")
            except Exception as e:
                logger.warning(f"Failed to remove intermediate file {self.current_config_file}: {e}")
        elif self.debug and self.current_config_file != self.original_config_file:
            logger.info(f"Debug mode: keeping intermediate file {self.current_config_file}")
                
    def _get_output_directory(self, output_path: str) -> Optional[str]:
        """获取输出目录路径"""
        # 如果是文件路径，返回其父目录
        if output_path.lower().endswith(('.v', '.sv')) and not os.path.isdir(output_path):
            parent = os.path.dirname(output_path)
            if parent:
                return parent
            return '.'  # 当前目录
            
        # 如果是目录路径，直接返回
        return output_path if output_path else '.'

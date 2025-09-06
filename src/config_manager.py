#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
配置管理模块
负责加载和管理YAML配置文件
"""
import os
import yaml
from typing import Dict, List, Optional, Any
from .logger import get_logger

logger = get_logger(__name__)


class ConfigManager:
    """配置管理器"""
    
    def __init__(self, config_file: str, bounding_file: str = 'bounding.yaml'):
        self.config_file = config_file
        self.bounding_file = self._resolve_bounding_file(bounding_file, config_file)
        self.config: Dict[str, Any] = {}
        self.protocol_signals: Dict[str, List[str]] = {}
        
    def load_config(self) -> bool:
        """加载YAML配置文件"""
        try:
            with open(self.config_file, 'r', encoding='utf-8') as f:
                self.config = yaml.safe_load(f)
            logger.info(f"Loaded configuration from {self.config_file}")
            return True
        except Exception as e:
            logger.error(f"Error loading YAML file {self.config_file}: {e}")
            return False
            
    def load_protocol_signals(self) -> bool:
        """加载协议信号定义"""
        try:
            if os.path.exists(self.bounding_file):
                with open(self.bounding_file, 'r', encoding='utf-8') as f:
                    bounding_config = yaml.safe_load(f)
                    self.protocol_signals = bounding_config.get('protocol_signals', {})
                    logger.info(f"Loaded protocol signals from {self.bounding_file}")
                    for protocol, signals in self.protocol_signals.items():
                        logger.debug(f"  {protocol.upper()}: {len(signals)} signals")
                    return True
            else:
                logger.warning(f"Bounding file '{self.bounding_file}' not found")
                logger.info("Search tips: You can place it in (1) the working directory, (2) the same directory as the YAML config, or (3) the script directory.")
                self.protocol_signals = {}
                return False
        except Exception as e:
            logger.error(f"Error loading bounding file {self.bounding_file}: {e}")
            return False
            
    def get_top_module_name(self) -> str:
        """获取顶层模块名"""
        return self.config.get('top_module', 'soc_top')
        
    def get_define_files(self) -> List[str]:
        """获取宏定义文件列表"""
        define_files = self.config.get('define_files', [])
        if isinstance(define_files, str):
            return [define_files]
        elif isinstance(define_files, list):
            return [f for f in define_files if f is not None]
        else:
            return []
            
    def get_rtl_files(self) -> List[str]:
        """获取RTL文件列表"""
        rtl_files = self.config.get('rtl_path', [])
        if isinstance(rtl_files, str):
            return [rtl_files]
        elif isinstance(rtl_files, list):
            return [f for f in rtl_files if f is not None]
        else:
            return []
            
    def get_instances_config(self) -> List[Dict[str, Any]]:
        """获取实例配置"""
        instances_config = self.config.get('instances', [])
        if instances_config is None:
            logger.info("No instances found (instances is empty)")
            return []
        return instances_config
        
    def get_connections_config(self) -> Dict[str, Any]:
        """获取连接配置"""
        connections = self.config.get('connections', {})
        if connections is None:
            logger.debug("No manual connections found (connections is empty)")
            return {}
        return connections
        
    def get_bounding_config(self) -> Dict[str, Any]:
        """获取协议连接配置"""
        bounding_config = self.config.get('bounding_con', {})
        if bounding_config is None:
            logger.debug("No protocol connections found (bounding_con is empty)")
            return {}
        return bounding_config
        
    def get_protocol_signals(self) -> Dict[str, List[str]]:
        """获取协议信号定义"""
        return self.protocol_signals
        
    def get_top_add_config(self) -> List[str]:
        """获取top_add配置"""
        top_add_config = self.config.get('top_add', [])
        if top_add_config is None:
            logger.debug("No top_add signals found (top_add is empty)")
            return []
        elif isinstance(top_add_config, str):
            return [top_add_config]
        elif isinstance(top_add_config, list):
            return [signal for signal in top_add_config if signal is not None]
        else:
            return []
        
    def create_intermediate_config(self, generated_connections: Dict[str, str], 
                                 output_path: Optional[str] = None) -> Optional[str]:
        """创建包含生成连接的中间配置文件"""
        if not generated_connections:
            return None
            
        # 创建中间配置
        intermediate_config = self.config.copy()
        
        # 合并连接
        original_connections = intermediate_config.get('connections', {})
        if original_connections is None:
            original_connections = {}
            
        merged_connections = {}
        merged_connections.update(generated_connections)
        merged_connections.update(original_connections)  # 原有连接优先
        
        # 输出被覆盖的连接信息
        for conn_key in generated_connections:
            if conn_key in original_connections:
                logger.debug(f"Override: {conn_key} -> {original_connections[conn_key]} "
                           f"(was {generated_connections[conn_key]})")
                           
        intermediate_config['connections'] = merged_connections
        
        # 移除bounding_con
        if 'bounding_con' in intermediate_config:
            del intermediate_config['bounding_con']
            
        # 生成中间文件路径
        intermediate_file = self._generate_intermediate_file_path(output_path)
        
        try:
            with open(intermediate_file, 'w', encoding='utf-8') as f:
                yaml.dump(intermediate_config, f, default_flow_style=False, allow_unicode=True)
            logger.info(f"Created intermediate YAML file: {intermediate_file}")
            return intermediate_file
        except Exception as e:
            logger.error(f"Error creating intermediate YAML file: {e}")
            return None
            
    def _resolve_bounding_file(self, bounding_file: str, config_file: str) -> str:
        """解析bounding文件路径"""
        candidates = []
        
        # 绝对路径直接检查
        if os.path.isabs(bounding_file):
            if os.path.exists(bounding_file):
                return bounding_file
            return bounding_file
            
        # 相对路径搜索
        candidates.append(os.path.abspath(bounding_file))  # 当前工作目录
        
        # YAML文件目录
        config_dir = os.path.dirname(os.path.abspath(config_file)) if config_file else ''
        if config_dir:
            candidates.append(os.path.join(config_dir, bounding_file))
            
        # 脚本目录
        script_dir = os.path.dirname(os.path.abspath(__file__))
        candidates.append(os.path.join(script_dir, bounding_file))
        
        for candidate in candidates:
            if os.path.exists(candidate):
                logger.debug(f"Resolved bounding file: {candidate}")
                return candidate
                
        logger.debug(f"Bounding file not found in candidates: {candidates}")
        return bounding_file
        
    def _generate_intermediate_file_path(self, output_path: Optional[str] = None) -> str:
        """生成中间文件路径"""
        if output_path:
            # 如果output_path是文件
            if output_path.lower().endswith(('.v', '.sv')):
                output_dir = os.path.dirname(os.path.abspath(output_path))
            else:
                output_dir = os.path.abspath(output_path)
                
            # 确保输出目录存在
            if not os.path.exists(output_dir):
                try:
                    os.makedirs(output_dir, exist_ok=True)
                except Exception as e:
                    logger.warning(f"Cannot create directory {output_dir}: {e}")
                    # 回退到原始逻辑
                    base_name = os.path.splitext(self.config_file)[0]
                    return f"{base_name}_intermediate.yaml"
                    
            yaml_basename = os.path.splitext(os.path.basename(self.config_file))[0]
            return os.path.join(output_dir, f"{yaml_basename}_intermediate.yaml")
        else:
            # 默认在配置文件同目录
            base_name = os.path.splitext(self.config_file)[0]
            return f"{base_name}_intermediate.yaml"

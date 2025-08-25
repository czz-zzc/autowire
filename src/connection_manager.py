#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
连线管理模块
负责处理各种类型的连线，包括：
1. 手动连线（connections）
2. 协议连线（bounding_con）  
3. 自动连线
"""
import re
from typing import Dict, List, Optional, Set, Tuple
from .data_structures import Instance, Port, WireInfo
from .logger import get_logger

logger = get_logger(__name__)


class ConnectionManager:
    """连线管理器"""
    
    def __init__(self, protocol_signals: Dict[str, List[str]]):
        self.protocol_signals = protocol_signals
        self.wire_set: Dict[str, WireInfo] = {}
        self.instances: List[Instance] = []
        
    def set_instances(self, instances: List[Instance]):
        """设置实例列表"""
        self.instances = instances
        
    def process_manual_connections(self, connections: Dict[str, str]):
        """处理手动连线配置"""
        if not connections:
            logger.info("No manual connections found")
            return
            
        logger.info(f"Processing {len(connections)} manual connections")
        
        for conn_key, conn_value in connections.items():
            # conn_key格式: instance_name.port_name
            if '.' not in conn_key:
                logger.warning(f"Invalid connection key format: {conn_key}")
                continue
                
            instance_name, port_name = conn_key.split('.', 1)
            
            # 查找对应的实例和端口
            target_port = self._find_port(instance_name, port_name)
            if not target_port:
                logger.warning(f"Port {conn_key} not found")
                continue
                
            # 处理连接
            self._process_single_connection(target_port, conn_value, conn_key)
            
    def process_protocol_connections(self, bounding_config: Dict) -> Dict[str, str]:
        """处理协议连线配置，返回生成的连线"""
        if not bounding_config:
            logger.info("No protocol connections found")
            return {}
            
        logger.info("Processing protocol connections...")
        generated_connections = {}
        
        # 处理不同的协议配置格式
        if isinstance(bounding_config, list):
            # 列表格式：[{protocol: mappings}, ...]
            for bounding_item in bounding_config:
                if isinstance(bounding_item, dict):
                    for protocol, mappings in bounding_item.items():
                        protocol = protocol.lower()
                        self._process_protocol_mappings(
                            protocol, mappings, generated_connections
                        )
        elif isinstance(bounding_config, dict):
            # 字典格式：{protocol: mappings, ...}
            for protocol, mappings in bounding_config.items():
                protocol = protocol.lower()
                self._process_protocol_mappings(
                    protocol, mappings, generated_connections
                )
                
        logger.info(f"Generated {len(generated_connections)} protocol connections")
        return generated_connections
        
    def auto_connect_ports(self):
        """自动连接未连接的端口"""
        logger.info("Starting auto-connection of unconnected ports")
        
        connected_count = 0
        total_count = 0
        
        for instance in self.instances:
            for port in instance.ports:
                total_count += 1
                
                # 跳过已连接的端口
                if port.is_connected:
                    connected_count += 1
                    continue
                
                wire_name = port.name
                
                # 检查wire_set中是否已存在该线
                if wire_name not in self.wire_set:
                    self.wire_set[wire_name] = WireInfo(name=wire_name)
                
                wire_info = self.wire_set[wire_name]
                
                if port.direction == 'input':
                    if not wire_info.has_input:
                        wire_info.has_input = True
                        wire_info.input_width = port.width
                        wire_info.input_width_value = port.width_value
                        port.connect_wire = wire_name
                        port.is_connected = True
                        connected_count += 1
                    else:
                        # 检查位宽一致性
                        if wire_info.input_width_value != port.width_value:
                            logger.warning(f"Input width mismatch for {wire_name}: "
                                         f"{wire_info.input_width_value} vs {port.width_value}")
                        port.connect_wire = wire_name
                        port.is_connected = True
                        connected_count += 1
                        
                elif port.direction == 'output':
                    if not wire_info.has_output:
                        wire_info.has_output = True
                        wire_info.output_width = port.width
                        wire_info.output_width_value = port.width_value
                        port.connect_wire = wire_name
                        port.is_connected = True
                        connected_count += 1
                    else:
                        logger.error(f"Multiple outputs trying to drive wire {wire_name}")
                        logger.error(f"  Conflicting port: {instance.instance_name}.{port.name}")
        
        logger.info(f"Auto-connection completed: {connected_count}/{total_count} ports connected")
        logger.info(f"Total wires in wire_set: {len(self.wire_set)}")
        
    def get_wire_set(self) -> Dict[str, WireInfo]:
        """获取所有线信息"""
        return self.wire_set
        
    def _find_port(self, instance_name: str, port_name: str) -> Optional[Port]:
        """查找指定的端口"""
        for instance in self.instances:
            if instance.instance_name == instance_name:
                for port in instance.ports:
                    if port.name == port_name:
                        return port
                break
        return None
        
    def _process_single_connection(self, target_port: Port, conn_value: str, conn_key: str):
        """处理单个连接"""
        # 标记端口为已连接
        target_port.is_connected = True
        
        # 处理连接值
        if conn_value is None:
            conn_value_str = ""
        else:
            conn_value_str = str(conn_value).strip()
        
        # 判断连接类型
        connection_type = self._classify_connection(conn_value_str)
        
        if connection_type == 'constant' or connection_type == 'floating':
            if connection_type == 'floating':
                target_port.connect_wire = " "
                logger.debug(f"Set floating connection: {conn_key} -> open(unused)")
            else:
                target_port.connect_wire = conn_value_str
                logger.debug(f"Set constant connection: {conn_key} -> '{conn_value_str}'")
                
        elif connection_type == 'concatenation':
            target_port.connect_wire = conn_value_str
            self._process_concatenation_connection(conn_value_str, target_port)
            logger.debug(f"Set concatenation connection: {conn_key} -> {conn_value_str}")
            
        elif connection_type == 'bit_select':
            target_port.connect_wire = conn_value_str
            self._process_bit_select_connection(conn_value_str, target_port)
            logger.debug(f"Set bit-select connection: {conn_key} -> {conn_value_str}")
            
        else:  # normal signal
            target_port.connect_wire = conn_value_str
            self._process_normal_connection(conn_value_str, target_port)
            logger.debug(f"Set wire connection: {conn_key} -> {conn_value_str}")
            
    def _classify_connection(self, conn_value: str) -> str:
        """分类连接类型"""
        if not conn_value or conn_value.strip() == "":
            return 'floating'
            
        # 判断是否为拼接格式 {signal1, signal2, ...}
        if conn_value.startswith('{') and conn_value.endswith('}'):
            return 'concatenation'
            
        # 判断是否为位选择格式 signal[bit] 或 signal[msb:lsb]
        if ('[' in conn_value and ']' in conn_value and 
            not conn_value.startswith('{') and not conn_value.endswith('}') and
            not conn_value.isdigit() and "'" not in conn_value):
            return 'bit_select'
            
        # 判断是否为常值
        if conn_value.isdigit() or "'" in conn_value:
            return 'constant'
            
        return 'normal'
        
    def _process_concatenation_connection(self, conn_value: str, target_port: Port):
        """处理拼接连接"""
        concat_content = conn_value.strip('{}')
        signals = [s.strip() for s in concat_content.split(',')]
        
        for signal in signals:
            # 跳过常数
            if signal.isdigit() or "'" in signal:
                continue
            
            # 提取信号名
            wire_name = signal.split('[')[0].strip() if '[' in signal else signal.strip()
            
            if not wire_name:
                continue
                
            self._update_wire_info(wire_name, target_port)
            
    def _process_bit_select_connection(self, conn_value: str, target_port: Port):
        """处理位选择连接"""
        wire_name = conn_value.split('[')[0].strip()
        if wire_name:
            self._update_wire_info(wire_name, target_port)
            
    def _process_normal_connection(self, conn_value: str, target_port: Port):
        """处理普通信号连接"""
        wire_name = conn_value
        self._update_wire_info(wire_name, target_port)
        
    def _update_wire_info(self, wire_name: str, target_port: Port):
        """更新线信息"""
        if wire_name not in self.wire_set:
            self.wire_set[wire_name] = WireInfo(name=wire_name)
        
        wire_info = self.wire_set[wire_name]
        
        if target_port.direction == 'input':
            if wire_info.has_input:
                if wire_info.input_width_value != target_port.width_value:
                    logger.warning(f"Input width mismatch for {wire_name}: "
                                 f"{wire_info.input_width_value} vs {target_port.width_value}")
            else:
                wire_info.has_input = True
                wire_info.input_width = target_port.width
                wire_info.input_width_value = target_port.width_value
                
        elif target_port.direction == 'output':
            if wire_info.has_output:
                logger.error(f"Multiple outputs driving wire {wire_name}")
            else:
                wire_info.has_output = True
                wire_info.output_width = target_port.width
                wire_info.output_width_value = target_port.width_value
                
    def _process_protocol_mappings(self, protocol: str, mappings: Dict[str, str], 
                                  generated_connections: Dict[str, str]):
        """处理特定协议的映射"""
        if protocol not in self.protocol_signals:
            logger.warning(f"Unsupported protocol: {protocol}")
            return
            
        signal_list = self.protocol_signals[protocol]
        logger.debug(f"Using {protocol.upper()} protocol signals ({len(signal_list)} signals)")
        
        for source_pattern, target_pattern in mappings.items():
            logger.debug(f"Processing mapping: {source_pattern} -> {target_pattern}")
            
            # 解析source_pattern (如 u_cpu.a_*)
            if '.' not in source_pattern:
                logger.warning(f"Invalid source pattern format: {source_pattern}")
                continue
                
            instance_name, port_prefix = source_pattern.split('.', 1)
            
            # 找到对应的实例
            target_instance = None
            for instance in self.instances:
                if instance.instance_name == instance_name:
                    target_instance = instance
                    break
                    
            if not target_instance:
                logger.warning(f"Instance {instance_name} not found")
                continue
                
            # 处理通配符匹配
            if '*' in port_prefix:
                matched_ports = self._match_wildcard_ports(
                    port_prefix, target_pattern, target_instance.ports, signal_list
                )
                
                for port, target_name in matched_ports:
                    source_conn = f"{instance_name}.{port.name}"
                    generated_connections[source_conn] = target_name
                    logger.debug(f"Generated: {source_conn} -> {target_name}")
                    
    def _match_wildcard_ports(self, source_pattern: str, target_pattern: str, 
                             ports: List[Port], signal_list: List[str]) -> List[Tuple[Port, str]]:
        """通用通配符匹配"""
        matched_ports = []
        
        # 将模式转换为正则表达式
        source_regex = self._wildcard_to_regex(source_pattern)
        
        for port in ports:
            match = re.match(source_regex, port.name, re.IGNORECASE)
            if match:
                # 检查匹配的部分是否包含协议信号
                if self._contains_protocol_signal(port.name, signal_list):
                    # 生成目标信号名
                    captured_parts = list(match.groups())
                    target_name = self._generate_target_name(target_pattern, captured_parts, port.name)
                    matched_ports.append((port, target_name))
                    
        return matched_ports
        
    def _wildcard_to_regex(self, pattern: str) -> str:
        """将通配符模式转换为正则表达式"""
        escaped = re.escape(pattern).replace(r'\*', '(.*?)')
        return f"^{escaped}$"
        
    def _contains_protocol_signal(self, port_name: str, signal_list: List[str]) -> bool:
        """检查端口名是否包含协议信号"""
        port_lower = port_name.lower()
        for signal in signal_list:
            if signal.lower() in port_lower:
                return True
        return False
        
    def _generate_target_name(self, target_pattern: str, captured_parts: List[str], 
                             original_name: str) -> str:
        """根据目标模式生成目标信号名"""
        if '*' not in target_pattern:
            return target_pattern.lower()
            
        result = target_pattern
        for part in captured_parts:
            result = result.replace('*', part.lower(), 1)
            
        return result

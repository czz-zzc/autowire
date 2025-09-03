#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Verilog代码生成模块
负责生成格式化的Verilog顶层模块
"""
import os
import datetime
from typing import Dict, List, Tuple
from .data_structures import Instance, Port, WireInfo
from .logger import get_logger

logger = get_logger(__name__)


class VerilogCodeGenerator:
    """Verilog代码生成器"""
    
    def __init__(self, top_module_name: str = "soc_top"):
        self.top_module_name = top_module_name
        self.instances: List[Instance] = []
        self.wire_set: Dict[str, WireInfo] = {}
        self.top_ports: List[Port] = []
        
    def set_instances(self, instances: List[Instance]):
        """设置实例列表"""
        self.instances = instances
        
    def set_wire_set(self, wire_set: Dict[str, WireInfo]):
        """设置线信息"""
        self.wire_set = wire_set
        
    def generate_top_ports(self):
        """按照实例和端口定义顺序生成顶层端口"""
        logger.info("Generating top-level ports in instance and port definition order")
        
        added_ports = set()
        
        # 按照实例定义顺序遍历端口
        for instance in self.instances:
            logger.debug(f"Processing instance {instance.instance_name} for top ports...")
            
            for port in instance.ports:
                wire_name = port.connect_wire if port.connect_wire else port.name
                
                # 跳过常值、悬空和已添加的端口
                if (not wire_name or wire_name.strip() == "" or 
                    wire_name in added_ports or
                    wire_name.isdigit() or "'" in wire_name):
                    continue
                    
                if wire_name in self.wire_set:
                    wire_info = self.wire_set[wire_name]
                    
                    # 只有输入端，需要从顶层输入
                    if not wire_info.has_output and wire_info.has_input:
                        top_port = Port(
                            name=wire_name,
                            direction="input",
                            width=wire_info.input_width,
                            width_value=wire_info.input_width_value,
                            is_array=wire_info.is_array,
                            array_size=wire_info.array_size,
                            source_instance=wire_info.source_instance if wire_info.source_instance else instance.instance_name
                        )
                        self.top_ports.append(top_port)
                        added_ports.add(wire_name)
                        logger.debug(f"Added top input port: {wire_name} from {instance.instance_name}, array: {wire_info.is_array}")
                        
                    # 只有输出端，需要输出到顶层
                    elif not wire_info.has_input and wire_info.has_output:
                        top_port = Port(
                            name=wire_name,
                            direction="output", 
                            width=wire_info.output_width,
                            width_value=wire_info.output_width_value,
                            is_array=wire_info.is_array,
                            array_size=wire_info.array_size,
                            source_instance=wire_info.source_instance if wire_info.source_instance else instance.instance_name
                        )
                        self.top_ports.append(top_port)
                        added_ports.add(wire_name)
                        logger.debug(f"Added top output port: {wire_name} from {instance.instance_name}, array: {wire_info.is_array}")
                        
                        
        # 处理剩余的wire_set中未处理的项
        remaining_wires = []
        for wire_name, wire_info in self.wire_set.items():
            if wire_name in added_ports:
                continue
                
            if not wire_info.has_output and wire_info.has_input:
                top_port = Port(
                    name=wire_name,
                    direction="input",
                    width=wire_info.input_width,
                    width_value=wire_info.input_width_value,
                    is_array=wire_info.is_array,
                    array_size=wire_info.array_size
                )
                remaining_wires.append(top_port)
                logger.debug(f"Added remaining top input port: {wire_name}, array: {wire_info.is_array}")
                
            elif not wire_info.has_input and wire_info.has_output:
                top_port = Port(
                    name=wire_name,
                    direction="output",
                    width=wire_info.output_width,
                    width_value=wire_info.output_width_value,
                    is_array=wire_info.is_array,
                    array_size=wire_info.array_size
                )
                remaining_wires.append(top_port)
                logger.debug(f"Added remaining top output port: {wire_name}, array: {wire_info.is_array}")
                
        self.top_ports.extend(remaining_wires)
        logger.info(f"Generated {len(self.top_ports)} top-level ports")
        
    def generate_top_module(self, output_file: str):
        """生成顶层模块文件"""
        logger.info(f"Generating top module to {output_file}")
        
        # 文件头注释
        file_header = self._generate_file_header(output_file)
        
        lines = []
        lines.append(f"module {self.top_module_name}(")
        
        # 生成端口列表
        if self.top_ports:
            port_lines = self._generate_aligned_port_list()
            lines.extend(port_lines)
            
        lines.append(");")
        lines.append("")
        
        # 生成内部信号声明
        wire_lines = self._generate_aligned_wire_declarations()
        if wire_lines:
            lines.extend(wire_lines)
            lines.append("")
            
        # 生成模块例化
        instance_lines = self._generate_aligned_instances()
        lines.extend(instance_lines)
        
        lines.append("endmodule")
        
        # 写入文件
        try:
            with open(output_file, 'w', encoding='utf-8') as f:
                f.write('\n'.join(file_header + lines))
            logger.info(f"Successfully generated {output_file}")
        except Exception as e:
            logger.error(f"Error writing output file {output_file}: {e}")
            raise
            
    def _generate_file_header(self, output_file: str) -> List[str]:
        """生成文件头注释"""
        header = []
        header.append('// -----------------------------------------------------------------------------')
        header.append(f'// File      : {os.path.basename(output_file)}')
        header.append('// Brief     : Auto-generated by autowire.py v2.0')
        header.append('// Author    : czz')
        header.append(f'// Date      : {datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")}')
        header.append('// -----------------------------------------------------------------------------')
        header.append('')
        return header
        
    def _generate_aligned_port_list(self) -> List[str]:
        """生成对齐的端口列表"""
        # 计算对齐宽度
        max_direction_width = max(len(port.direction) for port in self.top_ports)
        max_width_expr_width = 0
        
        for port in self.top_ports:
            if port.width and port.width != "0":
                width_expr_len = len(f"[{port.width}]")
                max_width_expr_width = max(max_width_expr_width, width_expr_len)
                
        port_lines = []
        current_instance = None
        
        for i, port in enumerate(self.top_ports):
            # 添加实例注释
            if port.source_instance and port.source_instance != current_instance:
                if current_instance is not None:
                    port_lines.append("")
                port_lines.append(f"    // {port.source_instance} ports")
                current_instance = port.source_instance
                
            # 格式化端口声明
            direction = port.direction.ljust(max_direction_width)
            
            # 处理位宽
            width_part = ""
            if port.width and port.width != "0" and port.width != "0:0":
                width_part = f"[{port.width}]".ljust(max_width_expr_width)
            else:
                width_part = "".ljust(max_width_expr_width)
            
            # 处理数组维度
            array_part = ""
            if hasattr(port, 'is_array') and port.is_array and hasattr(port, 'array_size') and port.array_size:
                array_part = f" {port.array_size}"
            
            port_decl = f"    {direction}  {width_part}  {port.name}{array_part}"

            if i < len(self.top_ports) - 1:
                port_decl += ","
                
            port_lines.append(port_decl)
            
        return port_lines
        
    def _generate_aligned_wire_declarations(self) -> List[str]:
        """生成对齐的内部信号声明"""
        internal_wires = []
        
        for wire_name, wire_info in self.wire_set.items():
            if wire_info.has_input and wire_info.has_output:
                # 检查位宽一致性
                if wire_info.input_width_value != wire_info.output_width_value:
                    max_width = max(wire_info.input_width_value, wire_info.output_width_value)
                    logger.warning(f"Width mismatch for wire {wire_name}: "
                                 f"input={wire_info.input_width_value}, "
                                 f"output={wire_info.output_width_value}, using max={max_width}")
                    # 使用较宽的位宽表达式
                    if wire_info.input_width_value > wire_info.output_width_value:
                        width_expr = wire_info.input_width
                    else:
                        width_expr = wire_info.output_width
                else:
                    width_expr = wire_info.output_width
                    
                internal_wires.append((wire_name, width_expr))
                
        if not internal_wires:
            return []
            
        # 计算对齐宽度 - 需要考虑数组维度
        max_width_len = max(len(f"[{width}]" if width and width != "0" else "") 
                           for _, width in internal_wires)
        
        # 计算带数组维度的总长度，用于信号名对齐
        max_total_len = 0
        for wire_name, width_expr in internal_wires:
            wire_info = self.wire_set[wire_name]
            total_name_len = len(wire_name)
            if wire_info.is_array and wire_info.array_size:
                total_name_len += len(f" {wire_info.array_size}")
            max_total_len = max(max_total_len, total_name_len)
        
        wire_lines = []
        for wire_name, width_expr in sorted(internal_wires):
            wire_info = self.wire_set[wire_name]  # 获取完整的wire信息
            
            if width_expr and width_expr != "0":
                width_part = f"[{width_expr}]".ljust(max_width_len)
            else:
                width_part = "".ljust(max_width_len)
            
            # 构建信号名部分（包含数组维度）
            signal_part = wire_name
            if wire_info.is_array and wire_info.array_size:
                signal_part += f" {wire_info.array_size}"
            
            # 对齐信号名部分
            signal_part_aligned = signal_part.ljust(max_total_len)
            
            # 构建完整的wire声明
            wire_decl = f"wire  {width_part}  {signal_part_aligned};"
            wire_lines.append(wire_decl)
            
        return wire_lines
        
    def _generate_aligned_instances(self) -> List[str]:
        """生成对齐的模块例化"""
        # 计算全局对齐宽度
        alignment = self._calculate_instance_alignment()
        
        instance_lines = []
        for instance in self.instances:
            # 添加实例注释
            instance_lines.append(f"// Instance: {instance.instance_name} ({instance.module_name})")
            
            # 生成模块声明和参数
            module_lines = self._generate_module_declaration(instance, alignment)
            instance_lines.extend(module_lines)
            
            # 生成端口连接
            port_lines = self._generate_port_connections(instance, alignment)
            instance_lines.extend(port_lines)
            
            instance_lines.append(");")
            instance_lines.append("")
            
        return instance_lines
        
    def _calculate_instance_alignment(self) -> Dict[str, int]:
        """计算实例对齐宽度"""
        global_max_port_name_len = 0
        global_max_connection_len = 0
        global_max_direction_len = 0
        
        for instance in self.instances:
            if not instance.ports:
                continue
                
            instance_max_port_name_len = max(len(port.name) for port in instance.ports)
            instance_max_connection_len = 0
            
            for port in instance.ports:
                connection = port.connect_wire if port.connect_wire else port.name
                adjusted_connection = self._adjust_connection_width(port, connection)
                instance_max_connection_len = max(instance_max_connection_len, 
                                                len(adjusted_connection))
                                                
            instance_max_direction_len = max(len(port.direction) for port in instance.ports)
            
            global_max_port_name_len = max(global_max_port_name_len, instance_max_port_name_len)
            global_max_connection_len = max(global_max_connection_len, instance_max_connection_len)
            global_max_direction_len = max(global_max_direction_len, instance_max_direction_len)
            
        # 计算全局连接行长度
        global_max_conn_line_len = 0
        if global_max_port_name_len > 0:
            global_max_conn_line_len = len(f"    .{' ' * global_max_port_name_len} "
                                         f"({' ' * global_max_connection_len}),")
                                         
        return {
            'port_name_len': global_max_port_name_len,
            'connection_len': global_max_connection_len,
            'direction_len': global_max_direction_len,
            'conn_line_len': global_max_conn_line_len
        }
        
    def _generate_module_declaration(self, instance: Instance, alignment: Dict[str, int]) -> List[str]:
        """生成模块声明和参数"""
        lines = []
        
        if instance.parameters:
            lines.append(f"{instance.module_name} #(")
            # 参数对齐
            max_param_name_len = max(len(param_name) for param_name in instance.parameters.keys())
            max_param_value_len = max(len(str(param_value)) for param_value in instance.parameters.values())
            param_items = list(instance.parameters.items())
            for i, (param_name, param_value) in enumerate(param_items):
                param_name_aligned = param_name.ljust(max_param_name_len)
                param_value_aligned = str(param_value).ljust(max_param_value_len)
                param_line = f"    .{param_name_aligned}({param_value_aligned})"
                if i < len(param_items) - 1:  # 不是最后一个参数
                    param_line += ","
                lines.append(param_line)
            lines.append(f") {instance.instance_name} (")
        else:
            lines.append(f"{instance.module_name} {instance.instance_name} (")
            
        return lines
        
    def _generate_port_connections(self, instance: Instance, alignment: Dict[str, int]) -> List[str]:
        """生成端口连接"""
        if not instance.ports:
            return []
            
        port_connections = []
        for i, port in enumerate(instance.ports):
            connection = port.connect_wire if port.connect_wire else port.name
            connection = self._adjust_connection_width(port, connection)
            
            port_name_aligned = port.name.ljust(alignment['port_name_len'])
            connection_aligned = connection.ljust(alignment['connection_len'])
            
            # 生成注释
            direction_aligned = port.direction.ljust(alignment['direction_len'])
            width_info = f"[{port.width}]" if port.width and port.width != "0" and port.width != "0:0" else ""
            array_info = f" {port.array_size}" if port.is_array and port.array_size else ""
            comment = f"// {direction_aligned}"
            if width_info:
                comment += f" {width_info}"
            if array_info:
                comment += array_info
                
            conn_line = f"    .{port_name_aligned} ({connection_aligned})"
            if i < len(instance.ports) - 1:
                conn_line += ","
                
            conn_line = conn_line.ljust(alignment['conn_line_len'] + 4) + comment
            port_connections.append(conn_line)
            
        return port_connections
        
    def _adjust_connection_width(self, port: Port, connection: str) -> str:
        """根据端口位宽调整连接信号的位宽"""
        # 跳过常数、悬空连接
        if (not connection or connection.strip() == "" or 
            connection.isdigit() or "'" in connection):
            return connection
            
        # 如果已包含位选择，不调整
        if '[' in connection and ']' in connection:
            return connection
            
        # 检查wire_set中的信息
        if connection not in self.wire_set:
            return connection
            
        wire_info = self.wire_set[connection]
        port_width = port.width_value
        
        # 确定连接信号的实际位宽
        connection_width = 0
        if wire_info.has_output and wire_info.has_input:
            connection_width = max(wire_info.output_width_value, wire_info.input_width_value)
        elif wire_info.has_output:
            connection_width = wire_info.output_width_value
        elif wire_info.has_input:
            connection_width = wire_info.input_width_value
            
        # 如果端口位宽小于连接信号位宽，进行位选择
        if connection_width > port_width > 0:
            if port_width == 1:
                adjusted_connection = f"{connection}[0]"
            else:
                adjusted_connection = f"{connection}[{port_width-1}:0]"
                
            logger.debug(f"Width adjustment: {port.direction} port {port.name}({port_width}bit) -> "
                        f"{adjusted_connection} from {connection}({connection_width}bit)")
            return adjusted_connection
            
        # 位宽不匹配警告
        elif connection_width < port_width and connection_width > 0:
            logger.warning(f"Connection signal '{connection}'({connection_width}bit) is narrower "
                         f"than {port.direction} port '{port.name}'({port_width}bit)")
                         
        return connection

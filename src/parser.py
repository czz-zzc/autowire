#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
基于pyverilog的Verilog解析器 (重构版本)
主要功能：
1. 使用文件合并机制处理宏定义
2. 解析模块端口信息
3. 解析参数定义
"""
import os
import re
import tempfile
from typing import Dict, List, Optional
from pyverilog.vparser.parser import parse
from pyverilog.vparser.ast import (
    Source, ModuleDef, Parameter, Ioport, Decl, 
    Input, Output, Inout, Localparam
)
from pyverilog.ast_code_generator.codegen import ASTCodeGenerator

from .data_structures import ModuleInfo, Port, Parameter as ParamInfo
from .logger import get_logger

logger = get_logger(__name__)


class PyVerilogParser:
    """基于pyverilog的Verilog解析器 (简化版本)"""
    
    def __init__(self, debug=False, output_dir=None):
        self.debug = debug
        self.define_files: List[str] = []
        self.output_dir = output_dir  # 输出目录，用于存放临时文件
        self.generated_files = []  # 追踪生成的PLY文件
        
    def cleanup_ply_files(self):
        """清理PLY生成的文件"""
        ply_files = ['parser.out', 'parsetab.py']
        for filename in ply_files:
            if os.path.exists(filename):
                try:
                    os.remove(filename)
                    logger.debug(f"Removed PLY file: {filename}")
                except Exception as e:
                    logger.warning(f"Failed to remove PLY file {filename}: {e}")
                    
        # 如果在输出目录也生成了，也清理
        if self.output_dir:
            for filename in ply_files:
                filepath = os.path.join(self.output_dir, filename)
                if os.path.exists(filepath):
                    try:
                        os.remove(filepath)
                        logger.debug(f"Removed PLY file: {filepath}")
                    except Exception as e:
                        logger.warning(f"Failed to remove PLY file {filepath}: {e}")
        
    def parse_defines_from_files(self, define_files: List[str]) -> Dict[str, str]:
        """存储宏定义文件列表"""
        self.define_files = [f for f in define_files if f and os.path.exists(f)]
        logger.info(f"Registered {len(self.define_files)} define files")
        return {}
    
    def parse_module_from_file(self, file_path: str, module_name: str, 
                             instance_params: Optional[Dict[str, str]] = None) -> Optional[ModuleInfo]:
        """通过合并define文件和RTL文件解析指定模块"""
        if not os.path.exists(file_path):
            logger.error(f"File not found: {file_path}")
            return None
            
        try:
            # 合并所有内容
            combined_content = self._create_combined_content(file_path)
            
            # 解析AST
            module_info = self._parse_combined_content(combined_content, module_name, file_path, instance_params)
            
            if module_info:
                logger.info(f"Successfully parsed module {module_name} with {len(module_info.ports)} ports")
            
            return module_info
                
        except Exception as e:
            logger.error(f"Error parsing module {module_name}: {e}")
            if self.debug:
                import traceback
                logger.debug(f"Traceback: {traceback.format_exc()}")
            return None
    
    def find_modules_in_files(self, rtl_files: List[str]) -> Dict[str, str]:
        """查找文件中的所有模块，返回模块名->文件路径的映射"""
        module_files = {}
        
        for rtl_file in rtl_files:
            if not rtl_file or not os.path.exists(rtl_file):
                continue
                
            try:
                modules = self._extract_modules_by_regex(rtl_file)
                for module_name in modules:
                    module_files[module_name] = rtl_file
            except Exception as e:
                logger.error(f"Error parsing {rtl_file}: {e}")
                
        return module_files
    
    def _create_combined_content(self, file_path: str) -> str:
        """创建合并的文件内容，展开include文件"""
        combined_content = ""
        
        # 添加define文件内容并展开其中的include
        for define_file in self.define_files:
            try:
                content = self._expand_includes(define_file)
                combined_content += content + '\n'
            except Exception as e:
                logger.warning(f"Error reading define file {define_file}: {e}")
        
        # 添加RTL文件内容并进行端口格式标准化，同时展开include
        try:
            rtl_content = self._expand_includes(file_path)
            
            # 注释掉imports语句
            rtl_content = self._comment_out_imports(rtl_content)
            
            # 移除模块实现代码，只保留端口声明
            rtl_content = self._remove_module_implementation(rtl_content)
            # 标准化端口声明格式
            rtl_content = self._normalize_port_declarations(rtl_content)

            combined_content += rtl_content
        except Exception as e:
            logger.error(f"Error processing RTL file {file_path}: {e}")
            
        return combined_content
    
    def _expand_includes(self, file_path: str, processed_files: Optional[set] = None) -> str:
        """处理include文件，将include指令注释掉"""
        if not os.path.exists(file_path):
            logger.warning(f"Include file not found: {file_path}")
            return f"// Include file not found: {file_path}\n"
            
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
        except Exception as e:
            logger.warning(f"Error reading file {file_path}: {e}")
            return f"// Error reading file: {file_path}\n"
        
        # 查找并注释掉include指令
        lines = content.split('\n')
        processed_lines = []
        
        for line in lines:
            # 匹配 `include "filename" 或 `include <filename>
            include_match = re.match(r'\s*`include\s+["\<]([^"\>]+)["\>]', line)
            if include_match:
                include_file = include_match.group(1)
                # 将include指令注释掉
                processed_lines.append(f"// {line.strip()} // Commented out - already included via yaml")
            else:
                processed_lines.append(line)
        
        return '\n'.join(processed_lines)
    
    def _comment_out_imports(self, content: str) -> str:
        """将SystemVerilog imports语句注释掉"""
        lines = content.split('\n')
        processed_lines = []
        
        for line in lines:
            # 匹配 imports 语句
            # 支持各种格式：imports pkg::*; 或 import pkg::item;
            import_match = re.match(r'\s*import\s+.*?;', line)
            if import_match:
                # 将import语句注释掉
                processed_lines.append(f"// {line.strip()} // Commented out - SystemVerilog import not supported by pyverilog")
            else:
                processed_lines.append(line)
        
        return '\n'.join(processed_lines)
    
    def _normalize_port_declarations(self, content: str) -> str:
        """标准化端口声明格式
        专门处理无位宽的二维数组端口声明:
        将 input        csr_desc_enable             [DMA_NUM_DESC-1:0],
        转换为 input    [DMA_NUM_DESC-1:0]  csr_desc_enable,
        
        支持两种模式:
        1. input/output/inout + 空格 + 信号名 + 空格(可多个) + [数组维度]
        2. input/output/inout + 空格 + reg/wire + 空格 + 信号名 + 空格(可多个) + [数组维度]
        """
        lines = content.split('\n')
        normalized_lines = []
        
        for line in lines:
            # 处理无位宽的二维数组端口声明
            # 模式1: input/output/inout + 空格 + 信号名 + 空格(可多个) + [数组维度]
            pattern1 = r'^(\s*)(input|output|inout)(\s+)(\w+)(\s*)(\[[^\]]+\])(\s*[,;]?\s*)(.*?)$'
            # 模式2: input/output/inout + 空格 + reg/wire + 空格 + 信号名 + 空格(可多个) + [数组维度]
            pattern2 = r'^(\s*)(input|output|inout)(\s+)(reg|wire)(\s+)(\w+)(\s*)(\[[^\]]+\])(\s*[,;]?\s*)(.*?)$'
            
            match1 = re.match(pattern1, line)
            match2 = re.match(pattern2, line)
            
            if match2:
                # 检查是否已经有位宽信息（即是否为 port_type [width] signal_name 格式）
                pre_check_pattern = r'^(\s*)(input|output|inout)(\s+)(reg|wire)?(\s*)(\[[^\]]+\])(\s+)(\w+)'
                if not re.match(pre_check_pattern, line):
                    # 这是无位宽的端口声明（模式2），需要标准化
                    indent = match2.group(1)
                    port_type = match2.group(2)
                    reg_wire = match2.group(4)
                    signal_name = match2.group(6)
                    array_part = match2.group(8)  # [DMA_NUM_DESC-1:0] 或 [0:1] 等数组维度
                    comma_semicolon = match2.group(9).rstrip()
                    comment = match2.group(10)
                    
                    # 标准化格式: port_type reg/wire [array_part] signal_name
                    normalized_line = f"{indent}{port_type} {reg_wire} {array_part:<20} {signal_name}"
                    if comma_semicolon:
                        normalized_line += comma_semicolon
                    if comment:
                        normalized_line += comment
                    
                    normalized_lines.append(normalized_line)
                    continue
            elif match1:
                # 检查是否已经有位宽信息（即是否为 port_type [width] signal_name 格式）
                pre_check_pattern = r'^(\s*)(input|output|inout)(\s+)(\[[^\]]+\])(\s+)(\w+)'
                # 同时检查是否包含reg/wire关键字，避免错误匹配
                if not re.match(pre_check_pattern, line) and not re.search(r'\b(reg|wire)\b', line):
                    # 这是无位宽的端口声明（模式1），需要标准化
                    indent = match1.group(1)
                    port_type = match1.group(2)
                    signal_name = match1.group(4)
                    array_part = match1.group(6)  # [DMA_NUM_DESC-1:0] 或 [0:1] 等数组维度
                    comma_semicolon = match1.group(7).rstrip()
                    comment = match1.group(8)
                    
                    # 标准化格式: port_type [array_part] signal_name
                    normalized_line = f"{indent}{port_type:<8} {array_part:<20} {signal_name}"
                    if comma_semicolon:
                        normalized_line += comma_semicolon
                    if comment:
                        normalized_line += comment
                    
                    normalized_lines.append(normalized_line)
                    continue
            
            # 其他情况保持原样
            normalized_lines.append(line)
        
        result = '\n'.join(normalized_lines)
        
        # 统计处理的端口数量
        processed_ports = 0
        for line in lines:
            # 检查模式1和模式2的匹配情况
            pattern1 = r'^(\s*)(input|output|inout)(\s+)(\w+)(\s*)(\[[^\]]+\])(\s*[,;]?\s*)'
            pattern2 = r'^(\s*)(input|output|inout)(\s+)(reg|wire)(\s+)(\w+)(\s*)(\[[^\]]+\])(\s*[,;]?\s*)'
            pre_check_pattern = r'^(\s*)(input|output|inout)(\s+)(reg|wire)?(\s*)(\[[^\]]+\])(\s+)(\w+)'
            
            # 检查模式2
            if re.match(pattern2, line) and not re.match(pre_check_pattern, line):
                processed_ports += 1
            # 检查模式1（排除包含reg/wire的情况）
            elif re.match(pattern1, line) and not re.match(pre_check_pattern, line) and not re.search(r'\b(reg|wire)\b', line):
                processed_ports += 1
        
        if processed_ports > 0:
            logger.debug(f"Port normalization completed for {processed_ports} array port declarations")
        
        return result
    
    def _remove_module_implementation(self, content: str) -> str:
        """移除模块实现代码，只保留模块声明、端口信息和参数定义
        
        处理流程：
        1. 识别module声明开始
        2. 保留参数定义和端口声明部分
        3. 移除模块实现部分（从第一个非端口声明的语句开始到endmodule前）
        4. 保留endmodule语句
        """
        lines = content.split('\n')
        processed_lines = []
        
        inside_module = False
        module_name = ""
        ports_section_ended = False
        paren_count = 0  # 追踪括号层级
        found_semicolon = False  # 是否找到端口列表结束的分号
        in_multi_line_statement = False  # 标记是否在多行语句中
        
        for line_num, line in enumerate(lines):
            original_line = line
            stripped_line = line.strip()
            
            # 检测module声明开始
            module_match = re.match(r'\s*module\s+(\w+)', stripped_line)
            if module_match and not inside_module:
                inside_module = True
                module_name = module_match.group(1)
                ports_section_ended = False
                paren_count = 0
                found_semicolon = False
                in_multi_line_statement = False
                processed_lines.append(original_line)
                logger.debug(f"Found module start: {module_name}")
                continue
            
            # 如果不在模块内部，保留所有行（包括注释和空行）
            if not inside_module:
                processed_lines.append(original_line)
                continue
            
            # 如果在模块内部
            if inside_module:
                # 检测endmodule
                if re.match(r'\s*endmodule', stripped_line):
                    processed_lines.append(original_line)
                    inside_module = False
                    logger.debug(f"Module {module_name} processing completed")
                    continue
                
                # 处理空行和注释行
                if not stripped_line or stripped_line.startswith('//') or stripped_line.startswith('/*'):
                    # 如果端口部分还没结束，保留注释和空行
                    if not ports_section_ended:
                        processed_lines.append(original_line)
                    # 如果端口部分已结束，跳过所有注释和空行
                    continue
                
                # 如果端口部分还没结束，需要判断是否到达端口声明结束
                if not ports_section_ended:
                    # 统计括号层级
                    paren_count += line.count('(') - line.count(')')
                    
                    # 检查是否在多行语句中（parameter/localparam/端口声明）
                    if stripped_line.startswith(('parameter', 'localparam', 'input', 'output', 'inout')):
                        in_multi_line_statement = True
                    
                    # 检查是否有分号（语句结束标志）
                    if ';' in line:
                        # 如果是parameter/localparam/端口声明的结束
                        if in_multi_line_statement:
                            processed_lines.append(original_line)
                            in_multi_line_statement = False
                            
                            # 只有在端口列表的分号且括号平衡时才标记found_semicolon
                            if paren_count <= 0:
                                found_semicolon = True
                                
                                # 检查下一行是否是端口声明或参数声明
                                next_line_is_port = False
                                if line_num + 1 < len(lines):
                                    next_stripped = lines[line_num + 1].strip()
                                    if (next_stripped.startswith(('input', 'output', 'inout', 'parameter', 'localparam')) or
                                        not next_stripped or next_stripped.startswith('//')):
                                        next_line_is_port = True
                                
                                if not next_line_is_port:
                                    ports_section_ended = True
                                    logger.debug(f"Ports section ended for module {module_name}, removing implementation")
                            continue
                        elif paren_count <= 0:
                            # 端口列表的结束分号
                            found_semicolon = True
                            processed_lines.append(original_line)
                            
                            # 检查下一行是否是端口声明或参数声明
                            next_line_is_port = False
                            if line_num + 1 < len(lines):
                                next_stripped = lines[line_num + 1].strip()
                                if (next_stripped.startswith(('input', 'output', 'inout', 'parameter', 'localparam')) or
                                    not next_stripped or next_stripped.startswith('//')):
                                    next_line_is_port = True
                            
                            if not next_line_is_port:
                                ports_section_ended = True
                                logger.debug(f"Ports section ended for module {module_name}, removing implementation")
                            continue
                        else:
                            # 括号未平衡，继续处理
                            processed_lines.append(original_line)
                            continue
                    
                    # 如果在多行语句中，或者括号未平衡，或者还没找到分号，继续保留
                    if in_multi_line_statement or paren_count > 0 or not found_semicolon:
                        processed_lines.append(original_line)
                        continue
                    
                    # 检查是否是参数或端口声明行的开始
                    if stripped_line.startswith(('parameter', 'localparam', 'input', 'output', 'inout')):
                        processed_lines.append(original_line)
                        in_multi_line_statement = True
                        continue
                    
                    # 如果找到了分号但括号计数异常，可能是复杂的端口声明
                    if found_semicolon and paren_count <= 0:
                        # 额外检查：如果这行看起来像端口声明，保留它
                        if re.match(r'\s*(input|output|inout|parameter|localparam)\s+', stripped_line):
                            processed_lines.append(original_line)
                            continue
                        else:
                            ports_section_ended = True
                            logger.debug(f"Ports section ended for module {module_name}, removing implementation")
                
                # 如果端口部分已结束，直接跳过所有实现代码（除了endmodule）
                if ports_section_ended:
                    # 直接跳过所有实现代码
                    continue
                else:
                    # 还在端口声明部分
                    processed_lines.append(original_line)
        
        result = '\n'.join(processed_lines)
        
        # 统计处理的模块数量
        removed_modules = content.count('module ') if content.count('module ') > 0 else 0
        if removed_modules > 0:
            logger.debug(f"Module implementation removal completed for {removed_modules} modules")
        
        return result
    
    def _parse_combined_content(self, combined_content: str, module_name: str, 
                              file_path: str, instance_params: Optional[Dict[str, str]]) -> Optional[ModuleInfo]:
        """解析合并的内容"""
        # 创建临时文件 - 优先放在输出目录下
        if self.output_dir and os.path.isdir(self.output_dir):
            # 在输出目录下创建临时文件
            temp_filename = f"temp_{module_name}_{os.getpid()}.v"
            tmp_file_path = os.path.join(self.output_dir, temp_filename)
            
            try:
                with open(tmp_file_path, 'w', encoding='utf-8') as f:
                    f.write(combined_content)
                temp_file_created = True
            except Exception as e:
                logger.warning(f"Failed to create temp file in output dir: {e}, using system temp")
                temp_file_created = False
        else:
            temp_file_created = False
            
        # 如果无法在输出目录创建，则使用系统临时文件
        if not temp_file_created:
            with tempfile.NamedTemporaryFile(mode='w', suffix='.v', delete=False, encoding='utf-8') as tmp_file:
                tmp_file.write(combined_content)
                tmp_file_path = tmp_file.name
            
        try:
            # 解析AST
            ast_tree, _ = parse([tmp_file_path])
            if ast_tree is None:
                logger.warning(f"Failed to parse combined file for {module_name}")
                return None
            
            # 查找模块
            module_ast = self._find_module_in_ast(ast_tree, module_name)
            if module_ast is None:
                all_modules = self._list_modules_in_ast(ast_tree)
                logger.warning(f"Module {module_name} not found. Available: {all_modules}")
                return None
                
            # 解析模块信息
            return self._parse_module_ast(module_ast, file_path, instance_params)
            
        finally:
            # 清理临时文件 - 仅在非调试模式下删除
            if not self.debug:
                try:
                    os.unlink(tmp_file_path)
                except:
                    pass
            else:
                logger.debug(f"Debug mode: temporary file preserved at {tmp_file_path}")
    
    def _find_module_in_ast(self, ast_tree, module_name: str):
        """在AST中查找指定的模块"""
        def find_recursive(node):
            if isinstance(node, ModuleDef) and node.name == module_name:
                return node
            if hasattr(node, 'children'):
                for child in node.children():
                    result = find_recursive(child)
                    if result:
                        return result
            return None
        return find_recursive(ast_tree)
    
    def _list_modules_in_ast(self, ast_tree) -> List[str]:
        """列出AST中的所有模块名"""
        modules = []
        def find_recursive(node):
            if isinstance(node, ModuleDef):
                modules.append(node.name)
            if hasattr(node, 'children'):
                for child in node.children():
                    find_recursive(child)
        find_recursive(ast_tree)
        return modules
    
    def _parse_module_ast(self, module_ast: ModuleDef, file_path: str, 
                         instance_params: Optional[Dict[str, str]] = None) -> ModuleInfo:
        """解析模块AST"""
        module_info = ModuleInfo(name=module_ast.name, file_path=file_path)
        
        # 解析参数：先解析paramlist，再解析模块内部的parameter声明
        if module_ast.paramlist:
            module_info.parameters = self._parse_parameter_list(module_ast.paramlist)
        else:
            module_info.parameters = {}
            
        # 解析模块内部的parameter声明
        internal_params = self._parse_internal_parameters(module_ast)
        module_info.parameters.update(internal_params)
            
        # 解析端口 - 传递整个模块AST
        if module_ast.portlist:
            module_info.ports = self._parse_port_list(
                module_ast, module_info.parameters, instance_params
            )
            
        return module_info
    
    def _parse_parameter_list(self, param_list) -> Dict[str, ParamInfo]:
        """解析参数列表"""
        parameters = {}
        if not param_list:
            return parameters
            
        for param_item in param_list.children():
            if isinstance(param_item, Parameter):
                # 直接的Parameter节点
                param_value = self._ast_to_string(param_item.value) if param_item.value else ""
                parameters[param_item.name] = ParamInfo(
                    name=param_item.name, value=param_value, default_value=param_value
                )
            elif isinstance(param_item, Decl):
                # Parameter包装在Decl中（这是更常见的情况）
                for child in param_item.children():
                    if isinstance(child, Parameter):
                        param_value = self._ast_to_string(child.value) if child.value else ""
                        parameters[child.name] = ParamInfo(
                            name=child.name, value=param_value, default_value=param_value
                        )
        return parameters
    
    def _parse_internal_parameters(self, module_ast: ModuleDef) -> Dict[str, ParamInfo]:
        """解析模块内部的parameter声明"""
        parameters = {}
        
        if not hasattr(module_ast, 'items') or not module_ast.items:
            return parameters
            
        # 遍历模块的items寻找parameter声明
        for item in module_ast.items:
            if isinstance(item, Parameter):
                # 直接的Parameter节点
                param_value = self._ast_to_string(item.value) if item.value else ""
                parameters[item.name] = ParamInfo(
                    name=item.name, value=param_value, default_value=param_value
                )
            elif isinstance(item, Decl):
                # Decl节点可能包含Localparam
                if hasattr(item, 'children'):
                    for child in item.children():
                        if isinstance(child, Parameter):
                            param_value = self._ast_to_string(child.value) if child.value else ""
                            parameters[child.name] = ParamInfo(
                                name=child.name, value=param_value, default_value=param_value
                            )
                        elif isinstance(child, Localparam):
                            # 处理localparam
                            param_value = self._ast_to_string(child.value) if child.value else ""
                            parameters[child.name] = ParamInfo(
                                name=child.name, value=param_value, default_value=param_value
                            )
            elif hasattr(item, 'children'):
                # 检查其他节点中的Parameter和Localparam
                for child in item.children():
                    if isinstance(child, Parameter):
                        param_value = self._ast_to_string(child.value) if child.value else ""
                        parameters[child.name] = ParamInfo(
                            name=child.name, value=param_value, default_value=param_value
                        )
        
        return parameters
    
    def _parse_port_list(self, module_ast: ModuleDef, module_params: Dict[str, ParamInfo],
                        instance_params: Optional[Dict[str, str]] = None) -> List[Port]:
        """解析端口列表 - 支持ANSI-C和传统Verilog两种端口声明风格"""
        ports = []
        
        if not module_ast.portlist:
            return ports
        
        # 首先尝试ANSI-C风格：端口信息直接在portlist中
        ansi_style_ports = []
        port_names_only = []
        
        for port_item in module_ast.portlist.children():
            if isinstance(port_item, Ioport) and port_item.first:
                # ANSI-C风格：端口有完整的方向和位宽信息
                port_decl = port_item.first
                if hasattr(port_decl, 'name') and isinstance(port_decl, (Input, Output, Inout)):
                    # 获取位宽
                    width_expr = "0"
                    if hasattr(port_decl, 'width') and port_decl.width:
                        width_expr = self._parse_width_expression(
                            port_decl.width, module_params, instance_params
                        )
                    
                    # 检查是否为数组端口
                    is_array = False
                    array_size = ""
                    if hasattr(port_decl, 'dimensions') and port_decl.dimensions:
                        is_array = True
                        array_size = self._parse_array_dimensions(port_decl.dimensions, module_params, instance_params)
                    
                    port = Port(
                        name=port_decl.name,
                        direction=port_decl.__class__.__name__.lower(),
                        width=width_expr,
                        width_value=self._calculate_width_value(width_expr),
                        is_array=is_array,
                        array_size=array_size
                    )
                    ansi_style_ports.append(port)
            else:
                # 传统风格：尝试获取端口名 
                # 忽略类型检查，因为可能是不同的AST节点类型
                if hasattr(port_item, 'name') and getattr(port_item, 'name', None):  # type: ignore
                    port_names_only.append(getattr(port_item, 'name'))  # type: ignore
        
        # 如果找到ANSI-C风格的端口，直接返回
        if ansi_style_ports:
            return ansi_style_ports
        
        # 否则使用传统风格：从items中查找端口声明
        if port_names_only and hasattr(module_ast, 'items') and module_ast.items:
            port_names_set = set(port_names_only)
            
            # items是一个tuple，直接遍历
            for item in module_ast.items:
                if isinstance(item, Decl):
                    for decl_item in item.children():
                        if isinstance(decl_item, (Input, Output, Inout)) and decl_item.name in port_names_set:
                            # 获取位宽
                            width_expr = "0"
                            if hasattr(decl_item, 'width') and decl_item.width:
                                width_expr = self._parse_width_expression(
                                    decl_item.width, module_params, instance_params
                                )
                            
                            # 检查是否为数组端口
                            is_array = False
                            array_size = ""
                            if hasattr(decl_item, 'dimensions') and decl_item.dimensions:
                                is_array = True
                                array_size = self._parse_array_dimensions(decl_item.dimensions, module_params, instance_params)
                            
                            port = Port(
                                name=decl_item.name,
                                direction=decl_item.__class__.__name__.lower(),
                                width=width_expr,
                                width_value=self._calculate_width_value(width_expr),
                                is_array=is_array,
                                array_size=array_size
                            )
                            ports.append(port)
        
        return ports
    
    def _parse_width_expression(self, width_ast, module_params: Dict[str, ParamInfo],
                               instance_params: Optional[Dict[str, str]] = None) -> str:
        """解析位宽表达式"""
        if width_ast is None:
            return "0"
            
        width_str = self._ast_to_string(width_ast)
        
        # 参数替换 - 使用递归解析处理参数依赖，同时考虑实例参数覆盖
        if module_params:
            # 使用递归解析处理参数依赖关系，同时传递实例参数
            width_str = self._resolve_parameter_dependencies(width_str, module_params, instance_params)
        
        # 对于没有模块参数的情况，仍需要处理实例参数替换
        elif instance_params:
            for param_name, param_value in instance_params.items():
                pattern = rf'\b{re.escape(param_name)}\b'
                width_str = re.sub(pattern, str(param_value), width_str)
        
        # 移除外层方括号
        if width_str.startswith('[') and width_str.endswith(']'):
            width_str = width_str[1:-1]
        
        # 计算位宽表达式中的数学运算
        width_str = self._simplify_width_expression(width_str)
            
        return width_str
    
    def _parse_array_dimensions(self, dimensions_ast, module_params: Dict[str, ParamInfo],
                               instance_params: Optional[Dict[str, str]] = None) -> str:
        """解析数组维度表达式"""
        if dimensions_ast is None:
            return ""
        
        # 将数组维度AST转换为字符串
        dimensions_str = self._ast_to_string(dimensions_ast)
        
        # 参数替换 - 使用递归解析处理参数依赖，同时考虑实例参数覆盖
        if module_params:
            dimensions_str = self._resolve_parameter_dependencies(dimensions_str, module_params, instance_params)
        
        # 对于没有模块参数的情况，仍需要处理实例参数替换
        elif instance_params:
            for param_name, param_value in instance_params.items():
                dimensions_str = re.sub(r'\b' + param_name + r'\b', param_value, dimensions_str)
        
        # 化简数组维度表达式
        dimensions_str = self._simplify_array_dimensions(dimensions_str)
        
        return dimensions_str
       
    def _simplify_array_dimensions(self, dimensions_expr: str) -> str:
        """简化数组维度表达式，保持方括号格式"""
        if not dimensions_expr:
            return ""
            
        # 如果有多个维度，分别处理
        # 这里先处理简单情况，假设只有一个维度 [msb:lsb]
        dimensions_expr = dimensions_expr.strip()
        
        # 检查是否为 [expression] 格式
        if dimensions_expr.startswith('[') and dimensions_expr.endswith(']'):
            inner_expr = dimensions_expr[1:-1]  # 移除外层方括号
            
            # 处理 msb:lsb 格式
            if ':' in inner_expr:
                parts = inner_expr.split(':')
                if len(parts) == 2:
                    try:
                        msb_val = self._eval_expression(parts[0].strip())
                        lsb_val = self._eval_expression(parts[1].strip())
                        return f"[{msb_val}:{lsb_val}]"
                    except:
                        return dimensions_expr
            else:
                # 单个表达式，尝试计算
                try:
                    result = self._eval_expression(inner_expr)
                    return f"[{result}]"
                except:
                    return dimensions_expr
        
        return dimensions_expr
       
    def _simplify_width_expression(self, width_expr: str) -> str:
        """简化位宽表达式，计算其中的数学运算"""
        if not width_expr or width_expr == "0":
            return "0"
            
        # 先尝试处理整个表达式（包括条件表达式）
        try:
            if '?' in width_expr and ':' in width_expr:
                # 检查是否为条件表达式 (condition ? true_val : false_val)
                # 而不是位宽范围 [msb:lsb]
                if not (width_expr.count(':') == 1 and '?' not in width_expr.split(':')[0]):
                    # 这是条件表达式，尝试计算整个表达式
                    result = self._eval_expression(width_expr)
                    return str(result)
        except:
            pass
            
        # 处理常规情况
        if ':' in width_expr and '?' not in width_expr:
            # 处理 [msb:lsb] 格式
            parts = width_expr.split(':')
            if len(parts) == 2:
                try:
                    msb_val = self._eval_expression(parts[0].strip())
                    lsb_val = self._eval_expression(parts[1].strip())
                    return f"{msb_val}:{lsb_val}"
                except:
                    return width_expr
        else:
            # 单个表达式，尝试计算
            try:
                result = self._eval_expression(width_expr)
                return str(result)
            except:
                return width_expr
                
        return width_expr
    
    def _resolve_parameter_dependencies(self, expr: str, parameters: Dict[str, ParamInfo], 
                                       instance_params: Optional[Dict[str, str]] = None,
                                       resolved_cache: Optional[Dict[str, str]] = None) -> str:
        """递归解析参数依赖关系，确保依赖参数先被计算"""
        if resolved_cache is None:
            resolved_cache = {}
        
        # 如果表达式已经解析过，直接返回缓存结果
        if expr in resolved_cache:
            return resolved_cache[expr]
        
        # 检查表达式中是否包含参数引用
        result_expr = expr
        for param_name, param_info in parameters.items():
            if param_name in result_expr:
                # 首先检查是否有实例参数覆盖
                if instance_params and param_name in instance_params:
                    # 使用实例参数值
                    pattern = rf'\b{re.escape(param_name)}\b'
                    result_expr = re.sub(pattern, instance_params[param_name], result_expr)
                    if self.debug:
                        logger.debug(f"Parameter override: {param_name} = {instance_params[param_name]}")
                else:
                    # 递归解析依赖的参数
                    if param_name not in resolved_cache:
                        # 先解析参数值本身的依赖
                        resolved_param = self._resolve_parameter_dependencies(
                            param_info.value, parameters, instance_params, resolved_cache)
                        
                        # 尝试简化解析后的参数值
                        try:
                            simplified_param = self._simplify_width_expression(resolved_param)
                            resolved_cache[param_name] = simplified_param
                        except:
                            resolved_cache[param_name] = resolved_param
                    
                    # 替换参数引用 - 使用边界匹配避免部分替换
                    pattern = rf'\b{re.escape(param_name)}\b'
                    result_expr = re.sub(pattern, resolved_cache[param_name], result_expr)
        
        # 缓存结果
        resolved_cache[expr] = result_expr
        return result_expr

    def _calculate_width_value(self, width_expr: str) -> int:
        """计算位宽数值 - 复用简化表达式的逻辑"""
        if not width_expr or width_expr == "0":
            return 1
            
        # 先简化表达式，然后计算位宽值
        simplified = self._simplify_width_expression(width_expr)
        
        try:
            if ':' in simplified:
                parts = simplified.split(':')
                if len(parts) == 2:
                    msb = int(parts[0].strip())
                    lsb = int(parts[1].strip())
                    return abs(msb - lsb) + 1
            else:
                return int(simplified) + 1
        except:
            pass
        return 1
    
    def _eval_expression(self, expr: str) -> int:
        """安全计算表达式，支持条件表达式"""
        expr = expr.strip()
        
        # 处理条件表达式 (condition)? value1 : value2
        if '?' in expr and ':' in expr:
            try:
                return self._eval_conditional_expression(expr)
            except:
                pass
        
        try:
            # 只允许安全的字符
            if all(c in '0123456789+-*/(). ' for c in expr):
                # 修复：替换前导零避免八进制解析
                # 将类似 "07" -> "7", "01" -> "1" 的模式替换
                expr_fixed = re.sub(r'\b0+(\d+)', r'\1', expr)
                # 特殊处理单独的 "0" 不被替换掉
                if expr_fixed == '':
                    expr_fixed = '0'
                return int(eval(expr_fixed))
            # 直接转换整数，同样处理前导零
            expr_fixed = re.sub(r'^0+(\d+)$', r'\1', expr)
            if expr_fixed == '':
                expr_fixed = '0'
            return int(expr_fixed)
        except:
            return 0
    
    def _eval_conditional_expression(self, expr: str) -> int:
        """计算条件表达式 (condition)? value1 : value2"""
        expr = expr.strip()
        
        # 找到最外层的 ? 和 :
        question_pos = expr.find('?')
        if question_pos == -1:
            return self._eval_expression(expr)
        
        # 提取条件部分
        condition_str = expr[:question_pos].strip()
        remaining = expr[question_pos + 1:].strip()
        
        # 找到对应的冒号（需要考虑嵌套）
        paren_count = 0
        colon_pos = -1
        
        for i, c in enumerate(remaining):
            if c == '(':
                paren_count += 1
            elif c == ')':
                paren_count -= 1
            elif c == ':' and paren_count == 0:
                colon_pos = i
                break
        
        if colon_pos == -1:
            raise ValueError(f"Invalid conditional expression: {expr}")
        
        true_value_str = remaining[:colon_pos].strip()
        false_value_str = remaining[colon_pos + 1:].strip()
        
        # 计算条件
        condition_result = self._eval_condition(condition_str)
        
        # 根据条件返回相应的值
        if condition_result:
            return self._eval_expression(true_value_str)
        else:
            return self._eval_expression(false_value_str)
    
    def _eval_condition(self, condition_str: str) -> bool:
        """计算条件表达式"""
        condition_str = condition_str.strip()
        
        # 移除外层括号
        if condition_str.startswith('(') and condition_str.endswith(')'):
            condition_str = condition_str[1:-1].strip()
        
        # 处理比较运算符
        for op in ['==', '!=', '<=', '>=', '<', '>']:
            if op in condition_str:
                parts = condition_str.split(op, 1)
                if len(parts) == 2:
                    left = self._eval_expression(parts[0].strip())
                    right = self._eval_expression(parts[1].strip())
                    
                    if op == '==':
                        return left == right
                    elif op == '!=':
                        return left != right
                    elif op == '<=':
                        return left <= right
                    elif op == '>=':
                        return left >= right
                    elif op == '<':
                        return left < right
                    elif op == '>':
                        return left > right
        
        # 如果没有比较运算符，尝试将表达式作为数值计算
        try:
            return self._eval_expression(condition_str) != 0
        except:
            return False
    
    def _ast_to_string(self, ast_node) -> str:
        """将AST节点转换为字符串"""
        if ast_node is None:
            return ""
        try:
            codegen = ASTCodeGenerator()
            return codegen.visit(ast_node)
        except:
            return str(ast_node)
    
    def _extract_modules_by_regex(self, rtl_file: str) -> List[str]:
        """使用正则表达式从文件中提取模块名"""
        try:
            with open(rtl_file, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # 移除注释
            content = re.sub(r'//.*?$', '', content, flags=re.MULTILINE)
            content = re.sub(r'/\*.*?\*/', '', content, flags=re.DOTALL)
            
            # 查找模块定义 - 简单匹配module关键字后的第一个标识符
            return re.findall(r'module\s+(\w+)', content)
        except Exception as e:
            logger.error(f"Error reading file {rtl_file}: {e}")
            return []

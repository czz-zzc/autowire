#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Verilog SOC Integration Script
根据YAML配置文件自动生成SOC顶层连线
"""
import os
import re
import yaml
import argparse
from typing import Dict, List, Tuple, Optional, Any
from dataclasses import dataclass, field

import os
import re
import yaml
import argparse
from typing import Dict, List, Tuple, Optional, Any
from dataclasses import dataclass, field

# 协议信号定义将从外部bounding.yaml文件加载
PROTOCOL_SIGNALS = {}

# 全局调试标志和函数
_DEBUG_MODE = False

def set_debug_mode(debug: bool):
    """设置全局调试模式"""
    global _DEBUG_MODE
    _DEBUG_MODE = debug

def debug_print(message: str):
    """全局调试打印函数"""
    if _DEBUG_MODE:
        print(message)


@dataclass
class WireInfo:
    """线信息类"""
    name: str
    has_input: bool = False    # 是否有输入端口连接
    has_output: bool = False   # 是否有输出端口连接
    input_width: str = ""      # 输入端口位宽
    output_width: str = ""     # 输出端口位宽
    input_width_value: int = 0 # 输入端口位宽数值
    output_width_value: int = 0 # 输出端口位宽数值


@dataclass
class Port:
    """端口信息类"""
    name: str
    direction: str  # input/output/inout
    width: str      # 位宽表达式
    width_value: int = 0  # 实际位宽值
    is_array: bool = False
    array_size: str = ""
    connect_wire: str = ""     # 连接的线名称（可能是常值或悬空）
    is_connected: bool = False  # 是否已被连接的标签
    source_instance: str = ""   # 来源实例名称


@dataclass 
class Parameter:
    """参数信息类"""
    name: str
    value: str
    default_value: str = ""


@dataclass
class ModuleInfo:
    """模块信息类"""
    name: str
    file_path: str


@dataclass
class Instance:
    """例化信息类"""
    module_name: str
    instance_name: str
    parameters: Dict[str, str] = field(default_factory=dict)
    ports: List[Port] = field(default_factory=list)


class VerilogParser:
    """Verilog解析器"""
    
    def __init__(self, debug=False):
        self.defines = {}  # 当前生效的define定义（全局+文件局部）
        self.parameters = {}  # 存储parameter定义
        set_debug_mode(debug)  # 设置全局调试模式
        
    def set_defines_context(self, global_defines: Dict[str, str], file_defines: Dict[str, str]):
        """设置当前解析上下文的define集合"""
        self.defines = {}
        # 先添加全局defines
        self.defines.update(global_defines)
        # 再添加文件局部defines，会覆盖同名的全局define
        self.defines.update(file_defines)
        debug_print(f"  Set defines context: {len(global_defines)} global + {len(file_defines)} local = {len(self.defines)} total")
        
    def parse_defines(self, define_file: str) -> Dict[str, str]:
        """解析define文件，只解析module和endmodule之外的内容"""
        defines = {}
        if define_file is None:
            print("Warning: Define file is None")
            return defines
        if not os.path.exists(define_file):
            print(f"Warning: Define file {define_file} not found")
            return defines
            
        try:
            with open(define_file, 'r', encoding='utf-8') as f:
                content = f.read()
                
            # 移除注释
            content = self._remove_comments(content)
            
            # 提取module外部的内容
            external_content = self._extract_external_content(define_file,content)
            
            # 处理条件编译
            lines = external_content.split('\n')
            defines = self._process_conditional_defines(lines)
                
        except Exception as e:
            print(f"Error parsing define file {define_file}: {e}")
            
        return defines

    def _extract_external_content(self, define_file: str, content: str) -> str:
        """提取module和endmodule之外的内容"""
        lines = content.split('\n')
        external_lines = []
        inside_module = False
        module_depth = 0
        
        for line in lines:
            stripped_line = line.strip()
            
            # 检查是否进入module
            if re.match(r'^\s*module\s+\w+', stripped_line):
                inside_module = True
                module_depth += 1
                continue
                
            # 检查是否退出module
            if stripped_line == 'endmodule':
                module_depth -= 1
                if module_depth == 0:
                    inside_module = False
                continue
                
            # 如果不在module内部，保留这一行
            if not inside_module:
                external_lines.append(line)
        
        external_content = '\n'.join(external_lines)
        #打印文件名及提取的信息
        debug_print(f"Extracted external content for define parsing from {define_file}:")
        for i, line in enumerate(external_lines[:100], 1):  # 只显示前10行
            if line.strip():
                debug_print(f"  Line {i}: {line.strip()}")
        
        return external_content
    
    def _process_conditional_defines(self, lines: List[str]) -> Dict[str, str]:
        """处理条件编译指令"""
        defines = {}
        defined_symbols = set()
        condition_stack = []
        current_condition = True
        
        for line_num, line in enumerate(lines, 1):
            line = line.strip()
            if not line or line.startswith('//'):
                continue
                
            # 移除行内注释
            if '//' in line:
                line = line[:line.index('//')].strip()
            
            # 处理条件编译
            if line.startswith('`ifndef'):
                symbol = re.match(r'`ifndef\s+(\w+)', line)
                if symbol:
                    condition_stack.append(current_condition)
                    current_condition = current_condition and (symbol.group(1) not in defined_symbols)
            elif line.startswith('`ifdef'):
                symbol = re.match(r'`ifdef\s+(\w+)', line)
                if symbol:
                    condition_stack.append(current_condition)
                    current_condition = current_condition and (symbol.group(1) in defined_symbols)
            elif line.startswith('`else') and condition_stack:
                parent = condition_stack[-1]
                current_condition = parent and (not current_condition)
            elif line.startswith('`endif') and condition_stack:
                current_condition = condition_stack.pop()
            elif line.startswith('`define') and current_condition:
                # 处理define定义
                match = re.match(r'`define\s+(\w+)(?:\s+(.+))?$', line)
                if match:
                    name = match.group(1)
                    value = match.group(2).strip() if match.group(2) else "1"
                    defines[name] = value
                    defined_symbols.add(name)
                    debug_print(f"  Line {line_num}: define found")
                else:
                    print(f"Warning: Invalid define format at line {line_num}: {line}")
                    
        return defines
    
    def find_module_names(self, file_path: str) -> List[str]:
        """从RTL文件中提取所有模块名称"""
        module_names = []
        if not os.path.exists(file_path):
            print(f"Error: RTL file {file_path} not found")
            return module_names
            
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
        except Exception as e:
            print(f"Error reading file {file_path}: {e}")
            return module_names
            
        # 移除注释
        content = self._remove_comments(content)
        
        # 查找所有模块定义
        module_pattern = r'module\s+(\w+)\s*(?:#.*?)?\s*\('
        matches = re.findall(module_pattern, content, re.DOTALL)
        
        for module_name in matches:
            module_names.append(module_name)
            debug_print(f"Found module: {module_name} in {file_path}")
            
        return module_names
    
    def _remove_comments(self, content: str) -> str:
        """移除Verilog注释"""
        # 移除单行注释
        content = re.sub(r'//.*?$', '', content, flags=re.MULTILINE)
        # 移除多行注释
        content = re.sub(r'/\*.*?\*/', '', content, flags=re.DOTALL)
        return content
    
    def parse_module_with_instance_params(self, file_path: str, module_name: str, instance: 'Instance') -> Optional[ModuleInfo]:
        """根据实例参数解析特定模块的端口信息，并将端口信息存储到实例中"""
        if not os.path.exists(file_path):
            print(f"Error: Module file {file_path} not found")
            return None
            
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
        except Exception as e:
            print(f"Error reading file {file_path}: {e}")
            return None
            
        # 移除注释
        content = self._remove_comments(content)
        
        # 查找指定模块的定义
        module_pattern = rf'module\s+{re.escape(module_name)}\s*(?:#\((.*?)\))?\s*\((.*?)\);'
        match = re.search(module_pattern, content, re.DOTALL)
        
        if not match:
            print(f"Error: Module {module_name} not found in {file_path}")
            return None
            
        param_section = match.group(1) if match.group(1) else ""
        port_section = match.group(2)
        
        module_info = ModuleInfo(name=module_name, file_path=file_path)
        
        # 解析模块默认参数
        default_params = {}
        if param_section:
            parameters = self._parse_parameters(param_section)
            for param in parameters:
                default_params[param.name] = param.default_value
        
        # 合并实例参数，实例参数优先级更高
        effective_params = {}
        effective_params.update(default_params)
        if instance.parameters:
            effective_params.update(instance.parameters)
        
        # 使用有效参数解析端口，并存储到实例中
        if port_section:
            instance.ports = self._parse_ports_with_params(port_section, content, effective_params)
            
        return module_info
    
    def _parse_ports_with_params(self, port_section: str, full_content: str, params: Dict[str, str]) -> List[Port]:
        """使用参数信息解析模块端口，支持条件编译"""
        ports = []
        
        # 使用已经解析好的全局defines，不需要重复解析
        # 在parse_modules阶段已经解析了所有define文件和RTL文件中的defines
        
        # 处理端口声明中的条件编译
        processed_port_section = self._process_conditional_compilation(port_section, self.defines)
        
        # 检查是否为内联式声明（端口列表中包含 input/output/inout 关键字）
        has_inline_declarations = bool(re.search(r'\b(input|output|inout)\b', processed_port_section))
        
        if has_inline_declarations:
            # 内联式声明：直接从端口列表解析
            ports = self._parse_inline_port_declarations(processed_port_section, params)
        else:
            # 分离式声明：提取端口名，然后在模块内容中查找声明
            port_names = [p.strip() for p in processed_port_section.split(',') if p.strip()]
            port_names = [name for name in port_names if name and not name.startswith('//')]
            
            for port_name in port_names:
                port = self._find_port_declaration(port_name, full_content, params)
                if port:
                    ports.append(port)
                    
        return ports
    
    def _parse_inline_port_declarations(self, port_section: str, params: Dict[str, str]) -> List[Port]:
        """解析内联式端口声明"""
        ports = []
        
        # 分割端口声明，注意处理跨行的声明
        port_declarations = []
        current_decl = ""
        
        for line in port_section.split('\n'):
            line = line.strip()
            if not line or line.startswith('//'):
                continue
            current_decl += " " + line
            
            # 如果行以逗号结尾，说明一个端口声明完成
            if line.endswith(',') or line.endswith(')'):
                current_decl = current_decl.strip()
                if current_decl.endswith(','):
                    current_decl = current_decl[:-1].strip()
                if current_decl.endswith(')'):
                    current_decl = current_decl[:-1].strip()
                
                if current_decl and re.search(r'\b(input|output|inout)\b', current_decl):
                    port_declarations.append(current_decl)
                current_decl = ""
        
        # 如果最后还有未处理的声明
        if current_decl.strip():
            current_decl = current_decl.strip()
            if re.search(r'\b(input|output|inout)\b', current_decl):
                port_declarations.append(current_decl)
        
        # 解析每个端口声明
        for decl in port_declarations:
            port = self._parse_single_inline_port(decl, params)
            if port:
                ports.append(port)
        
        return ports
    
    def _parse_single_inline_port(self, declaration: str, params: Dict[str, str]) -> Optional[Port]:
        """解析单个内联端口声明"""
        decl = declaration.strip()
        
        # 匹配内联端口声明模式: input/output/inout [width] port_name
        port_pattern = r'(input|output|inout)\s*(?:\[([^\]]+)\])?\s*(\w+)'
        match = re.search(port_pattern, decl)
        
        if not match:
            debug_print(f"Warning: Cannot parse inline port declaration: {decl}")
            return None
            
        direction = match.group(1)
        width_expr = match.group(2) if match.group(2) else "0"
        name = match.group(3)
        
        # 使用参数信息计算位宽
        resolved_width = self._resolve_width_with_params(width_expr, params)
        
        port = Port(
            name=name,
            direction=direction,
            width=resolved_width,
            width_value=self._calculate_width_value(resolved_width)
        )
        
        debug_print(f"Found inline port {name}: {direction} [{width_expr}]")
        return port
    
    def _find_port_declaration(self, port_name: str, full_content: str, params: Dict[str, str]) -> Optional[Port]:
        """在模块内容中查找指定端口的声明，支持两种Verilog端口声明方式"""
        # 方式1：分离式声明 - input/output/inout [width] port_name;
        # 修改正则表达式以支持位宽后没有空格的情况，如: output [7:0]port_name;
        port_pattern1 = rf'(input|output|inout)\s*(?:\[([^\]]+)\])?\s*{re.escape(port_name)}\s*;'
        match1 = re.search(port_pattern1, full_content)
        
        if match1:
            direction = match1.group(1)
            width_expr = match1.group(2) if match1.group(2) else "0"
            
            # 使用参数信息计算位宽
            resolved_width = self._resolve_width_with_params(width_expr, params)
            
            port = Port(
                name=port_name,
                direction=direction,
                width=resolved_width,
                width_value=self._calculate_width_value(resolved_width)
            )
            
            debug_print(f"Found port {port_name} using separated declaration: {direction} [{width_expr}]")
            return port
        
        # 方式2：内联式声明 - 在端口列表中直接声明
        # 查找模块声明中的端口列表部分
        module_pattern = r'module\s+\w+\s*(?:#\([^)]*\))?\s*\((.*?)\);'
        module_match = re.search(module_pattern, full_content, re.DOTALL)
        
        if module_match:
            port_section = module_match.group(1)
            # 在端口列表中查找内联声明
            # 修改正则表达式以支持位宽后没有空格的情况
            inline_pattern = rf'(input|output|inout)\s*(?:\[([^\]]+)\])?\s*{re.escape(port_name)}'
            inline_match = re.search(inline_pattern, port_section)
            
            if inline_match:
                direction = inline_match.group(1)
                width_expr = inline_match.group(2) if inline_match.group(2) else "0"
                
                # 使用参数信息计算位宽
                resolved_width = self._resolve_width_with_params(width_expr, params)
                
                port = Port(
                    name=port_name,
                    direction=direction,
                    width=resolved_width,
                    width_value=self._calculate_width_value(resolved_width)
                )
                
                debug_print(f"Found port {port_name} using inline declaration: {direction} [{width_expr}]")
                return port
        
        print(f"Warning: Cannot find port declaration for: {port_name}")
        return None
    
    def _process_conditional_compilation(self, content: str, defines: Dict[str, str]) -> str:
        """处理条件编译指令，返回处理后的内容"""
        lines = content.split('\n')
        processed_lines = []
        conditional_stack = []  # 堆栈用于跟踪条件编译的嵌套
        current_condition = True  # 当前是否应该包含内容
        
        for line in lines:
            original_line = line
            line = line.strip()
            
            # 处理条件编译指令
            if line.startswith('`ifdef'):
                # `ifdef SYMBOL
                match = re.match(r'`ifdef\s+(\w+)', line)
                if match:
                    symbol = match.group(1)
                    conditional_stack.append(current_condition)
                    current_condition = current_condition and (symbol in defines)
                    debug_print(f"  ifdef {symbol}: {symbol in defines}, current_condition: {current_condition}")
                continue
                
            elif line.startswith('`ifndef'):
                # `ifndef SYMBOL
                match = re.match(r'`ifndef\s+(\w+)', line)
                if match:
                    symbol = match.group(1)
                    conditional_stack.append(current_condition)
                    current_condition = current_condition and (symbol not in defines)
                    debug_print(f"  ifndef {symbol}: {symbol not in defines}, current_condition: {current_condition}")
                continue
                
            elif line.startswith('`else'):
                # `else - 反转当前条件
                if conditional_stack:
                    parent_condition = conditional_stack[-1]
                    current_condition = parent_condition and (not current_condition or not parent_condition)
                    debug_print(f"  else: current_condition: {current_condition}")
                continue
                
            elif line.startswith('`endif'):
                # `endif - 恢复上一级条件
                if conditional_stack:
                    current_condition = conditional_stack.pop()
                    debug_print(f"  endif: current_condition: {current_condition}")
                continue
            
            # 如果当前条件为真，保留这一行
            if current_condition:
                processed_lines.append(original_line)
            else:
                debug_print(f"  Skipped line due to conditional: {original_line.strip()}")
        
        return '\n'.join(processed_lines)
    
    def _parse_single_port_with_params(self, declaration: str, full_content: str, params: Dict[str, str]) -> Optional[Port]:
        """使用参数信息解析单个端口声明"""
        # 清理声明
        decl = declaration.strip()
        
        # 匹配端口声明模式
        # 支持: input/output/inout [width] name
        port_pattern = r'(input|output|inout)\s*(?:\[([^\]]+)\])?\s*(\w+)'
        match = re.search(port_pattern, decl)
        
        if not match:
            print(f"Warning: Cannot parse port declaration: {decl}")
            print(f"  Raw declaration: '{declaration}'")
            return None
            
        direction = match.group(1)
        width_expr = match.group(2) if match.group(2) else "0"
        name = match.group(3)
        
        # 使用参数信息计算位宽
        resolved_width = self._resolve_width_with_params(width_expr, params)
        
        port = Port(
            name=name,
            direction=direction,
            width=resolved_width,
            width_value=self._calculate_width_value(resolved_width)
        )
        
        return port
    
    def _resolve_width_with_params(self, width_expr: str, params: Dict[str, str]) -> str:
        """使用参数信息解析位宽表达式并返回简化后的表达式"""
        if not width_expr or width_expr == "0":
            return "0"
            
        resolved_expr = width_expr
        original_expr = width_expr
        
        # 替换参数值
        for param_name, param_value in params.items():
            resolved_expr = resolved_expr.replace(param_name, str(param_value))
        
        # 递归替换define值，直到没有更多的define引用
        max_iterations = 10  # 防止无限递归
        iteration = 0
        while '`' in resolved_expr and iteration < max_iterations:
            old_expr = resolved_expr
            for define_name, define_value in self.defines.items():
                resolved_expr = resolved_expr.replace(f'`{define_name}', define_value)
            
            # 如果这一轮没有任何替换，说明有未知的define，退出循环
            if old_expr == resolved_expr:
                break
            iteration += 1
        
        # 如果仍然包含未解析的define，返回原始表达式
        if '`' in resolved_expr:
            debug_print(f"Unresolved defines in: '{original_expr}' -> '{resolved_expr}'")
            debug_print(f"Available defines: {list(self.defines.keys())[:10]}...")  # 只显示前10个
            print(f"Warning: Unresolved defines in width expression: {resolved_expr}")
            return width_expr
        
        debug_print(f"Successfully resolved: '{original_expr}' -> '{resolved_expr}' (took {iteration} iterations)")
        
        # 尝试简化表达式
        return self._simplify_expression(resolved_expr)
    
    def _simplify_expression(self, expr: str) -> str:
        """简化数学表达式，支持范围格式[msb:lsb]"""
        if not expr or expr == "0":
            return "0"
        
        try:
            if ':' in expr:
                # 处理 [msb:lsb] 格式
                parts = expr.split(':')
                if len(parts) == 2:
                    msb = self._eval_safe(parts[0].strip())
                    lsb = self._eval_safe(parts[1].strip())
                    return f"{msb}:{lsb}"
            else:
                # 处理单个表达式
                return str(self._eval_safe(expr))
        except:
            pass
        return expr
    
    def _eval_safe(self, expr: str) -> int:
        """安全计算数学表达式"""
        expr = expr.strip()
        
        # 替换剩余的define值
        for define_name, define_value in self.defines.items():
            expr = expr.replace(f'`{define_name}', define_value)
            
        # 安全的表达式求值（只允许数字、+、-、*、/、()）
        allowed_chars = set('0123456789+-*/(). ')
        if all(c in allowed_chars for c in expr):
            try:
                return int(eval(expr))
            except:
                pass
                
        # 尝试直接转换为数字
        try:
            return int(expr)
        except:
            return 0
    
    def _parse_parameters(self, param_section: str) -> List[Parameter]:
        """解析模块参数"""
        parameters = []
        
        # 匹配parameter定义
        param_pattern = r'parameter\s+(?:\w+\s+)?(\w+)\s*=\s*([^,\)]+)'
        matches = re.findall(param_pattern, param_section)
        
        for name, value in matches:
            param = Parameter(name=name, value=value.strip(), default_value=value.strip())
            parameters.append(param)
            
        return parameters
    
    def _calculate_width_value(self, width_expr: str) -> int:
        """计算位宽表达式的数值"""
        if not width_expr or width_expr == "0":
            return 1
            
        # 如果包含未解析的define，返回1作为默认值
        if '`' in width_expr:
            return 1
            
        try:
            if ':' in width_expr:
                # [msb:lsb] 格式
                parts = width_expr.split(':')
                if len(parts) == 2:
                    msb = self._eval_safe(parts[0].strip())
                    lsb = self._eval_safe(parts[1].strip())
                    return abs(msb - lsb) + 1
            else:
                # [width-1:0] 或 [width] 格式
                return self._eval_safe(width_expr) + 1
        except Exception as e:
            print(f"Warning: Cannot calculate width for '{width_expr}': {e}")
            return 1
            
        return 1


class VerilogGenerator:
    """SOC顶层生成器"""
    
    def __init__(self, yaml_file: str, debug=False, bounding_file: str = 'bounding.yaml'):
        self.yaml_file = yaml_file
        self.config = {}
        self.parser = VerilogParser(debug)
        set_debug_mode(debug)  # 设置全局调试模式
        self.global_defines = {}  # 全局define，来自YAML指定的define文件
        self.file_defines = {}    # 每个文件的局部define {file_path: {define_name: value}}
        self.module_files = {}  # 存储模块名到文件路径的映射
        self.modules = {}  # 存储解析的模块信息
        self.instances = []  # 存储例化信息
        self.connections = {}  # 存储连线信息
        self.top_ports = []  # 顶层端口
        self.wire_set = {}  # 存储所有线的信息 {wire_name: WireInfo}
        self.protocol_signals = {}  # 从bounding文件加载的协议信号
        # 解析bounding文件路径(支持多目录搜索)
        self.bounding_file = self._resolve_bounding_file(bounding_file, yaml_file)
        self.load_protocol_signals()

    def _resolve_bounding_file(self, bounding_file: str, yaml_file: str) -> str:
        """尝试解析 bounding 文件的实际路径。
        搜索顺序:
          1. 如果传入绝对路径且存在 -> 使用
          2. 当前工作目录下的相对路径
          3. YAML 配置文件所在目录
          4. 脚本所在目录
        返回找到的第一个存在的路径；否则返回原始传入值(后续读取时报错提醒)。
        """
        candidates = []
        # 绝对路径直接检查
        if os.path.isabs(bounding_file):
            if os.path.exists(bounding_file):
                return bounding_file
            return bounding_file  # 保留给后续提示
        # 相对路径: 当前工作目录
        candidates.append(os.path.abspath(bounding_file))
        # YAML 文件目录
        yaml_dir = os.path.dirname(os.path.abspath(yaml_file)) if yaml_file else ''
        if yaml_dir:
            candidates.append(os.path.join(yaml_dir, bounding_file))
        # 脚本目录
        script_dir = os.path.dirname(os.path.abspath(__file__))
        candidates.append(os.path.join(script_dir, bounding_file))
        for c in candidates:
            if os.path.exists(c):
                debug_print(f"Resolved bounding file: {c}")
                return c
        # 全都没找到, 返回原始名字, 让后续 load 给出建议
        debug_print(f"Bounding file not found in candidates: {candidates}")
        return bounding_file
        
    def load_protocol_signals(self):
        """从bounding.yaml文件加载协议信号定义"""
        try:
            if os.path.exists(self.bounding_file):
                with open(self.bounding_file, 'r', encoding='utf-8') as f:
                    bounding_config = yaml.safe_load(f)
                    self.protocol_signals = bounding_config.get('protocol_signals', {})
                    debug_print(f"Loaded protocol signals from {self.bounding_file}")
                    for protocol, signals in self.protocol_signals.items():
                        debug_print(f"  {protocol.upper()}: {len(signals)} signals")
            else:
                print(f"Warning: Bounding file '{self.bounding_file}' not found, using empty protocol signals.")
                print("  Search tips: 可以放在 (1) 运行目录, (2) YAML 配置同目录, (3) 脚本目录. 也可用 -b 指定绝对路径.")
                print("  示例模板: protocol_signals:\n    ahb: [haddr,hwrite,htrans,hsize,hrdata,hready]")
                self.protocol_signals = {}
        except Exception as e:
            print(f"Error loading bounding file {self.bounding_file}: {e}")
            self.protocol_signals = {}
        
    def load_config(self):
        """加载YAML配置文件"""
        try:
            with open(self.yaml_file, 'r', encoding='utf-8') as f:
                self.config = yaml.safe_load(f)
        except Exception as e:
            print(f"Error loading YAML file {self.yaml_file}: {e}")
            return False
            
        print(f"Loaded configuration from {self.yaml_file}")
        return True
    
    def parse_modules(self):
        print("start parsing modules")
        """解析所有模块名称和文件映射"""
        # 1. 解析全局define文件
        if 'define_files' in self.config:
            define_files = self.config['define_files']
            # 支持单个文件（字符串）或多个文件（列表）
            if isinstance(define_files, list):
                # 处理列表格式
                for define_file in define_files:
                    if define_file is not None:
                        file_defines = self.parser.parse_defines(define_file)
                        self.global_defines.update(file_defines)
                        debug_print(f"  Parsed define file: {define_file}, found {len(file_defines)} defines")
                    else:
                        debug_print("  Skipping None define file")
            else:
                # 处理单个文件格式（向后兼容）
                self.global_defines = self.parser.parse_defines(define_files)
                debug_print(f"  Parsed single define file: {define_files}, found {len(self.global_defines)} defines")
            
            for name, value in self.global_defines.items():
                debug_print(f"  Global define {name} = {value}")
        else:
            print("Warning: No define_files specified in config")
        
        # 2. 解析RTL文件，获取模块名称和每个文件的局部define
        rtl_files = []
        if 'rtl_path' in self.config:
            if isinstance(self.config['rtl_path'], list):
                rtl_files = self.config['rtl_path']
            else:
                rtl_files = [self.config['rtl_path']]
        
        # 扫描每个RTL文件，分别记录其局部define
        for rtl_file in rtl_files:
            if rtl_file is not None and os.path.exists(rtl_file):
                # 解析该文件的局部define
                file_defines = self.parser.parse_defines(rtl_file)
                self.file_defines[rtl_file] = file_defines
                if file_defines:
                    debug_print(f"Found local defines in {rtl_file}:")
                    for name, value in file_defines.items():
                        debug_print(f"  Local define {name} = {value}")
                
                # 解析模块名称
                module_names = self.parser.find_module_names(rtl_file)
                for module_name in module_names:
                    self.module_files[module_name] = rtl_file
                    debug_print(f"Mapped module {module_name} -> {rtl_file}")
        
        debug_print(f"Global defines: {self.global_defines}")
        debug_print(f"File-specific defines: {self.file_defines}")
    
    def parse_instance_modules(self):
        print("start parsing instance modules")
        """根据实例配置解析具体的模块信息"""
        for instance in self.instances:
            module_name = instance.module_name
            if module_name not in self.module_files:
                print(f"Warning: Module {module_name} file not found")
                continue
                
            file_path = self.module_files[module_name]
            
            # 设置当前文件的define上下文（全局 + 当前文件局部）
            file_defines = self.file_defines.get(file_path, {})
            self.parser.set_defines_context(self.global_defines, file_defines)
            
            # 使用实例参数解析模块，端口信息会存储到实例中
            module_info = self.parser.parse_module_with_instance_params(
                file_path, module_name, instance
            )
            
            if module_info:
                self.modules[module_name] = module_info
                debug_print(f"Parsed module: {module_name} with instance parameters, found {len(instance.ports)} ports")
    
    def parse_instances(self):
        """解析例化信息"""
        if 'instances' not in self.config:
            return
        
        instances_config = self.config['instances']
        if instances_config is None:
            print("No instances found (instances is empty)")
            return

        for inst_config in instances_config:
            instance = Instance(
                module_name=inst_config['module'],
                instance_name=inst_config['name'],
                parameters=inst_config.get('parameters', {}),
            )
            self.instances.append(instance)
            debug_print(f"Added instance: {instance.instance_name} ({instance.module_name})")
    
    def parse_connections(self):
        """解析连线信息，处理connection的信号"""
        if 'connections' not in self.config:
            return
            
        connections_config = self.config['connections']
        if connections_config is None:
            debug_print("No manual connections found (connections is empty)")
            return
        print(f"Parsing {len(connections_config)} manual connections")
        
        # 遍历每个连接配置
        for conn_key, conn_value in connections_config.items():
            # conn_key格式: instance_name.port_name
            if '.' not in conn_key:
                print(f"Warning: Invalid connection key format: {conn_key}")
                continue
                
            instance_name, port_name = conn_key.split('.', 1)
            
            # 查找对应的实例和端口
            target_instance = None
            target_port = None
            
            for instance in self.instances:
                if instance.instance_name == instance_name:
                    target_instance = instance
                    
                    # 对于子模块，正常查找端口
                    for port in instance.ports:
                        if port.name == port_name:
                            target_port = port
                            break
                    break
            
            if not target_instance or not target_port:
                print(f"Warning: Port {conn_key} not found")
                continue
                
            # 标记端口为已连接
            target_port.is_connected = True
            
            # 处理连接值，统一转换为字符串
            if conn_value is None:
                conn_value_str = ""
            else:
                conn_value_str = str(conn_value).strip()
            
            # 判断是否为拼接格式 {signal1, signal2, ...}
            is_concatenation = (conn_value_str.startswith('{') and conn_value_str.endswith('}'))
            # 判断是否为位选择格式 signal[bit] 或 signal[msb:lsb]
            is_truncated = ('[' in conn_value_str and ']' in conn_value_str and 
                           not conn_value_str.startswith('{') and not conn_value_str.endswith('}') and
                           not conn_value_str.isdigit() and "'" not in conn_value_str)
            # 判断悬空，空值或空字符串都视为悬空
            is_floating = (conn_value_str == "" or conn_value is None)
            # 判断是否为常值输入,如1/0/32'b0/4'h0/8'hff等都是（排除拼接和位选择格式）
            is_constant = (not is_concatenation and not is_truncated and not is_floating and 
                          (conn_value_str.isdigit() or "'" in conn_value_str))
            
            if is_constant or is_floating:
                # 若是常值或悬空连接，不用将port存入wire_set,只需要标记is_connected;并将connect_wire记录
                if is_floating:
                    target_port.connect_wire = " "
                    debug_print(f"Set floating connection: {conn_key} -> open(unused)")
                else:
                    target_port.connect_wire = conn_value_str
                    debug_print(f"Set constant connection: {conn_key} -> '{conn_value_str}'")
            elif is_concatenation:
                # 处理拼接连接格式 {6'b0,irq[0],uart_irq}
                target_port.connect_wire = conn_value_str
                print(f"Set concatenation connection: {conn_key} -> {conn_value_str}")
                # 解析拼接内容，提取信号名
                concat_content = conn_value_str.strip('{}')
                signals = [s.strip() for s in concat_content.split(',')]
                
                debug_print(f"Processing concatenation: {conn_key} -> {conn_value_str}")
                
                for signal in signals:
                    # 跳过常数（如 6'b0, 4'hf 等）
                    if signal.isdigit() or "'" in signal:
                        debug_print(f"  Skipping constant: {signal}")
                        continue
                    
                    # 提取信号名（去除位选择部分）
                    # 如 irq[0] -> irq, uart_irq -> uart_irq
                    if '[' in signal and ']' in signal:
                        wire_name = signal.split('[')[0].strip()
                    else:
                        wire_name = signal.strip()
                    
                    if not wire_name:
                        print(f"Warning: Skipping empty wire name in concatenation: {conn_value_str}")
                        continue
                    
                    # 在wire_set中记录信号
                    if wire_name not in self.wire_set:
                        self.wire_set[wire_name] = WireInfo(name=wire_name)
                    
                    wire_info = self.wire_set[wire_name]
                    
                    # 对于拼接中的信号，根据端口方向记录（位宽暂时不计算）
                    if target_port.direction == 'input':
                        wire_info.has_input = True  # 拼接中的信号作为输入到此端口
                        debug_print(f"  Added concatenation signal: {wire_name} as input (in concat)")
                    else:
                        wire_info.has_output = True  # 拼接中的信号作为输出到此端口
                        debug_print(f"  Added concatenation signal: {wire_name} as output (in concat)")

                debug_print(f"Set concatenation connection: {conn_key} -> {conn_value_str}")
            elif is_truncated:
                # 处理位选择格式 如 irq[1] 或 irq[1:0]
                target_port.connect_wire = conn_value_str
                
                # 提取信号名（去除位选择部分）
                wire_name = conn_value_str.split('[')[0].strip()
                
                debug_print(f"Processing truncated/bit-selection: {conn_key} -> {conn_value_str}")
                
                if not wire_name:
                    print(f"Warning: Invalid truncated format: {conn_value_str}")
                else:
                    # 在wire_set中记录信号
                    if wire_name not in self.wire_set:
                        self.wire_set[wire_name] = WireInfo(name=wire_name)
                    
                    wire_info = self.wire_set[wire_name]
                    
                    # 根据端口方向记录
                    if target_port.direction == 'input':
                        wire_info.has_input = True
                        debug_print(f"  Added truncated signal: {wire_name} as input")
                    else:
                        wire_info.has_output = True
                        debug_print(f"  Added truncated signal: {wire_name} as output")

                debug_print(f"Set truncated connection: {conn_key} -> {conn_value_str}")
            else:
                # 普通信号连接，根据conn_value创建wire_set
                wire_name = conn_value_str

                target_port.connect_wire = wire_name
                
                # 在wire_set中记录
                if wire_name not in self.wire_set:
                    self.wire_set[wire_name] = WireInfo(name=wire_name)
                
                wire_info = self.wire_set[wire_name]
                
                # 根据端口方向设置wire信息
                if target_port.direction == 'input':
                    if wire_info.has_input:
                        # 检查位宽一致性
                        if wire_info.input_width_value != target_port.width_value:
                            print(f"Warning: Input width mismatch for {wire_name}: {wire_info.input_width_value} vs {target_port.width_value}")
                    else:
                        wire_info.has_input = True
                        wire_info.input_width = target_port.width
                        wire_info.input_width_value = target_port.width_value
                        
                elif target_port.direction == 'output':
                    if wire_info.has_output:
                        print(f"Error: Multiple outputs driving wire {wire_name}")
                    else:
                        wire_info.has_output = True
                        wire_info.output_width = target_port.width
                        wire_info.output_width_value = target_port.width_value
                
                debug_print(f"Set wire connection: {conn_key} -> {wire_name}")
        
        # 保存原始连接配置（用于兼容性）
        self.connections = connections_config   
    
    def generate_connections(self):
        """遍历每个子模块的port，处理自动连线"""
        print("Start auto-connecting unconnected ports")
        
        for instance in self.instances:
            for port in instance.ports:
                # 跳过已连接的端口
                if port.is_connected:
                    continue
                
                wire_name = port.name
                
                # 检查wire_set中是否已存在该线
                if wire_name not in self.wire_set:
                    # 不存在，创建新的wire
                    self.wire_set[wire_name] = WireInfo(name=wire_name)
                
                wire_info = self.wire_set[wire_name]
                
                if port.direction == 'input':
                    if not wire_info.has_input:
                        # 输入端未被占用，加入并标记
                        wire_info.has_input = True
                        wire_info.input_width = port.width
                        wire_info.input_width_value = port.width_value
                        port.connect_wire = wire_name
                        port.is_connected = True
                        #print(f"Auto-connected input: {instance.instance_name}.{port.name} -> {wire_name}")
                    else:
                        # 输入端已被占用，检查位宽一致性
                        if wire_info.input_width_value != port.width_value:
                            print(f"Warning: Input width mismatch for {wire_name}: {wire_info.input_width_value} vs {port.width_value}")
                        port.connect_wire = wire_name
                        port.is_connected = True
                        #print(f"Auto-connected input (shared): {instance.instance_name}.{port.name} -> {wire_name}")
                        
                elif port.direction == 'output':
                    if not wire_info.has_output:
                        # 输出端未被占用，加入并标记
                        wire_info.has_output = True
                        wire_info.output_width = port.width
                        wire_info.output_width_value = port.width_value
                        port.connect_wire = wire_name
                        port.is_connected = True
                        #print(f"Auto-connected output: {instance.instance_name}.{port.name} -> {wire_name}")
                    else:
                        # 输出端已被占用，报错
                        print(f"Error: Multiple outputs trying to drive wire {wire_name}")
                        print(f"  Conflicting port: {instance.instance_name}.{port.name}")
        
        # 统计连接情况
        connected_count = sum(1 for instance in self.instances 
                            for port in instance.ports 
                            if port.is_connected)
        total_count = sum(len(instance.ports) for instance in self.instances)
        
        debug_print(f"Auto-connection completed: {connected_count}/{total_count} ports connected")
        debug_print(f"Total wires in wire_set: {len(self.wire_set)}")
    
    def generate_top_ports(self):
        """按照instance和端口定义顺序将wire_set中输入输出缺失的项作为顶层端口"""
        print("Generating top-level ports from wire_set in instance and port definition order")
        
        # 用于跟踪已添加的端口，避免重复
        added_ports = set()
        
        # 按照instance定义顺序遍历每个实例的端口
        for instance in self.instances:
            debug_print(f"Processing instance {instance.instance_name} for top ports...")
            
            for port in instance.ports:
                # 获取端口连接的wire名称
                wire_name = port.connect_wire if port.connect_wire else port.name
                
                # 跳过常值连接、悬空连接和已添加的端口
                if not wire_name or wire_name.strip() == "" or wire_name in added_ports:
                    continue
                if wire_name.isdigit() or "'" in wire_name:  # 常值连接
                    continue
                
                # 检查wire_set中的信息
                if wire_name in self.wire_set:
                    wire_info = self.wire_set[wire_name]
                    
                    # 如果wire没有输出端（只有输入端），说明信号需要从顶层输入到内部
                    if not wire_info.has_output and wire_info.has_input:
                        width = wire_info.input_width
                        top_port = Port(
                            name=wire_name,
                            direction="input",
                            width=width,
                            width_value=wire_info.input_width_value,
                            connect_wire="",
                            is_connected=False,
                            source_instance=instance.instance_name
                        )
                        self.top_ports.append(top_port)
                        added_ports.add(wire_name)
                        debug_print(f"  Added top input port: {wire_name} (width: {width}) from {instance.instance_name}.{port.name}")
                        
                    # 如果wire没有输入端（只有输出端），说明信号需要从内部输出到顶层
                    elif not wire_info.has_input and wire_info.has_output:
                        width = wire_info.output_width
                        top_port = Port(
                            name=wire_name,
                            direction="output",
                            width=width,
                            width_value=wire_info.output_width_value,
                            connect_wire="",
                            is_connected=False,
                            source_instance=instance.instance_name
                        )
                        self.top_ports.append(top_port)
                        added_ports.add(wire_name)
                        debug_print(f"  Added top output port: {wire_name} (width: {width}) from {instance.instance_name}.{port.name}")
        
        # 处理剩余的wire_set中未处理的项（保证完整性）
        remaining_wires = []
        for wire_name, wire_info in self.wire_set.items():
            if wire_name in added_ports:
                continue
                
            # 如果wire没有输出端（只有输入端），说明信号需要从顶层输入到内部
            if not wire_info.has_output and wire_info.has_input:
                width = wire_info.input_width
                top_port = Port(
                    name=wire_name,
                    direction="input",
                    width=width,
                    width_value=wire_info.input_width_value,
                    connect_wire="",
                    is_connected=False
                )
                remaining_wires.append(top_port)
                debug_print(f"  Added remaining top input port: {wire_name} (width: {width})")
                
            # 如果wire没有输入端（只有输出端），说明信号需要从内部输出到顶层
            elif not wire_info.has_input and wire_info.has_output:
                width = wire_info.output_width
                top_port = Port(
                    name=wire_name,
                    direction="output",
                    width=width,
                    width_value=wire_info.output_width_value,
                    connect_wire="",
                    is_connected=False
                )
                remaining_wires.append(top_port)
                debug_print(f"  Added remaining top output port: {wire_name} (width: {width})")
        
        # 将剩余的端口添加到列表末尾
        self.top_ports.extend(remaining_wires)
        
        print(f"Generated {len(self.top_ports)} top-level ports in instance and port definition order")
    
    def generate_top_module(self, output_file: str):
        """生成顶层模块文件，带对齐格式和文件头"""
        import datetime
        import os
        top_name = self.config.get('top_module', 'soc_top')

        # 文件头注释
        file_header = []
        file_header.append('// -----------------------------------------------------------------------------')
        file_header.append(f'// File      : {os.path.basename(output_file)}')
        file_header.append('// Brief     : Auto-generated by autowire.py')
        file_header.append('// Author    : czz')
        file_header.append(f'// Date      : {datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")}')
        file_header.append('// -----------------------------------------------------------------------------')
        file_header.append('')

        lines = []
        lines.append(f"module {top_name}(")

        # 生成对齐的端口列表
        if self.top_ports:
            port_lines = self._generate_aligned_port_list()
            lines.extend(port_lines)

        lines.append(")")
        lines.append("")

        # 生成对齐的内部信号声明
        wire_lines = self._generate_aligned_wire_declarations()
        if wire_lines:
            lines.extend(wire_lines)
            lines.append("")

        # 生成对齐的模块例化
        instance_lines = self._generate_aligned_instances()
        lines.extend(instance_lines)

        lines.append("endmodule")

        # 写入文件
        try:
            with open(output_file, 'w', encoding='utf-8') as f:
                f.write('\n'.join(file_header + lines))
            print(f"Generated aligned top module: {output_file}")
        except Exception as e:
            print(f"Error writing output file {output_file}: {e}")
    
    def _generate_aligned_port_list(self) -> List[str]:
        """生成对齐的端口列表"""
        # 计算对齐所需的最大宽度
        max_direction_width = max(len(port.direction) for port in self.top_ports)
        max_width_expr_width = 0
        
        # 计算最大位宽表达式宽度
        for port in self.top_ports:
            if port.width and port.width != "0":
                width_expr_len = len(f"[{port.width}]")
                max_width_expr_width = max(max_width_expr_width, width_expr_len)
        
        port_lines = []
        current_instance = None
        
        for i, port in enumerate(self.top_ports):
            # 检查是否需要添加 instance 注释
            if port.source_instance and port.source_instance != current_instance:
                if current_instance is not None:  # 不是第一个 instance
                    port_lines.append("")  # 在不同 instance 之间添加空行
                port_lines.append(f"    // {port.source_instance} ports")
                current_instance = port.source_instance
            
            # 方向部分对齐
            direction = port.direction.ljust(max_direction_width)
            
            # 位宽部分对齐
            if port.width and port.width != "0":
                width_part = f"[{port.width}]".ljust(max_width_expr_width)
                port_decl = f"    {direction}  {width_part}  {port.name}"
            else:
                # 没有位宽的端口，用空格填充位宽部分
                width_part = "".ljust(max_width_expr_width)
                port_decl = f"    {direction}  {width_part}  {port.name}"
            
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
                    print(f"Warning: Width mismatch for wire {wire_name}: input={wire_info.input_width_value}, output={wire_info.output_width_value}, using max={max_width}")
                    # 使用最大的位宽表达式
                    if wire_info.input_width_value > wire_info.output_width_value:
                        width_expr = wire_info.input_width
                    else:
                        width_expr = wire_info.output_width
                else:
                    # 位宽一致，使用输出端的位宽表达式
                    width_expr = wire_info.output_width
                
                internal_wires.append((wire_name, width_expr))
        
        if not internal_wires:
            return []
        
        # 计算最大位宽表达式长度和最大线名长度
        max_width_len = max(len(f"[{width}]" if width and width != "0" else "") for _, width in internal_wires)
        max_wire_name_len = max(len(wire_name) for wire_name, _ in internal_wires)
        
        wire_lines = []
        for wire_name, width_expr in sorted(internal_wires):
            if width_expr and width_expr != "0":
                width_part = f"[{width_expr}]".ljust(max_width_len)
                wire_name_part = wire_name.ljust(max_wire_name_len)
                wire_decl = f"wire  {width_part}  {wire_name_part};"
            else:
                width_part = "".ljust(max_width_len)
                wire_name_part = wire_name.ljust(max_wire_name_len)
                wire_decl = f"wire  {width_part}  {wire_name_part};"
            wire_lines.append(wire_decl)
        
        return wire_lines
    
    def _generate_aligned_instances(self) -> List[str]:
        """生成对齐的模块例化"""
        # 计算全局对齐宽度
        alignment = self._calculate_instance_alignment()
        
        instance_lines = []
        for instance in self.instances:
            if instance.module_name not in self.modules:
                continue
            
            # 添加instance注释
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
        """计算实例对齐所需的宽度"""
        global_max_port_name_len = 0
        global_max_connection_len = 0
        global_max_direction_len = 0
        
        # 遍历所有实例计算全局最大值
        for instance in self.instances:
            if instance.module_name not in self.modules or not instance.ports:
                continue
                
            instance_max_port_name_len = max(len(port.name) for port in instance.ports)
            # 计算调整位宽后的连接信号长度
            instance_max_connection_len = 0
            for port in instance.ports:
                connection = port.connect_wire if port.connect_wire else port.name
                adjusted_connection = self._adjust_connection_width(port, connection)
                instance_max_connection_len = max(instance_max_connection_len, len(adjusted_connection))
            
            instance_max_direction_len = max(len(port.direction) for port in instance.ports)
            
            global_max_port_name_len = max(global_max_port_name_len, instance_max_port_name_len)
            global_max_connection_len = max(global_max_connection_len, instance_max_connection_len)
            global_max_direction_len = max(global_max_direction_len, instance_max_direction_len)
        
        # 计算全局连接行长度
        global_max_conn_line_len = 0
        if global_max_port_name_len > 0:
            global_max_conn_line_len = len(f"    .{' ' * global_max_port_name_len} ({' ' * global_max_connection_len}),")
        
        return {
            'port_name_len': global_max_port_name_len,
            'connection_len': global_max_connection_len,
            'direction_len': global_max_direction_len,
            'conn_line_len': global_max_conn_line_len
        }
    
    def _generate_module_declaration(self, instance: Instance, alignment: Dict[str, int]) -> List[str]:
        """生成模块声明和参数部分"""
        lines = []
        
        if instance.parameters:
            lines.append(f"{instance.module_name} #(")
            # 计算参数对齐宽度
            max_param_name_len = max(len(param_name) for param_name in instance.parameters.keys()) if instance.parameters else 0
            for param_name, param_value in instance.parameters.items():
                param_name_aligned = param_name.ljust(max_param_name_len)
                lines.append(f"    .{param_name_aligned}({param_value})")
            lines.append(f") {instance.instance_name} (")
        else:
            lines.append(f"{instance.module_name} {instance.instance_name} (")
        
        return lines
    
    def _generate_port_connections(self, instance: Instance, alignment: Dict[str, int]) -> List[str]:
        """生成端口连接部分"""
        if not instance.ports:
            return []
        
        port_connections = []
        for i, port in enumerate(instance.ports):
            # 使用connect_wire直接连接
            connection = port.connect_wire if port.connect_wire else port.name
            
            # 处理位宽不匹配的情况
            connection = self._adjust_connection_width(port, connection)
            
            port_name_aligned = port.name.ljust(alignment['port_name_len'])
            connection_aligned = connection.ljust(alignment['connection_len'])
            
            # 生成对齐的端口注释信息
            direction_aligned = port.direction.ljust(alignment['direction_len'])
            width_info = f"[{port.width}]" if port.width and port.width != "0" else ""
            comment = f"// {direction_aligned}"
            if width_info:
                comment += f" {width_info}"
            
            conn_line = f"    .{port_name_aligned} ({connection_aligned})"
            if i < len(instance.ports) - 1:
                conn_line += ","
            
            # 添加注释，使用全局动态计算的对齐宽度
            conn_line = conn_line.ljust(alignment['conn_line_len'] + 4) + comment
                
            port_connections.append(conn_line)
        
        return port_connections
    
    def _adjust_connection_width(self, port: Port, connection: str) -> str:
        """根据端口位宽调整连接信号的位宽"""
        # 跳过常数连接、悬空连接
        if not connection or connection.strip() == "" or connection.isdigit() or "'" in connection:
            return connection
        
        # 如果连接信号已经包含位选择，不再调整
        if '[' in connection and ']' in connection:
            return connection
        
        # 检查连接信号是否在wire_set中
        if connection not in self.wire_set:
            return connection
        
        wire_info = self.wire_set[connection]
        port_width = port.width_value
        
        # 确定连接信号的实际位宽，使用最大值
        connection_width = 0
        if wire_info.has_output and wire_info.has_input:
            # 如果既有输入又有输出，使用最大位宽
            connection_width = max(wire_info.output_width_value, wire_info.input_width_value)
        elif wire_info.has_output:
            connection_width = wire_info.output_width_value
        elif wire_info.has_input:
            connection_width = wire_info.input_width_value
        
        # 统一处理：如果端口位宽小于连接信号位宽，进行位选择
        if connection_width > port_width > 0:
            if port_width == 1:
                adjusted_connection = f"{connection}[0]"
            else:
                adjusted_connection = f"{connection}[{port_width-1}:0]"
            
            debug_print(f"  Width adjustment: {port.direction} port {port.name}({port_width}bit) -> {adjusted_connection} from {connection}({connection_width}bit)")
            return adjusted_connection
        
        # 位宽不匹配的警告
        elif connection_width < port_width and connection_width > 0:
            print(f"Warning: Connection signal '{connection}'({connection_width}bit) is narrower than {port.direction} port '{port.name}'({port_width}bit)")
            #打印该wire的位宽信息
            if connection in self.wire_set:
                wire_info = self.wire_set[connection]
                print(f"  Wire '{connection}' info: {wire_info}")
        return connection
    

    def parse_bounding(self):
        """解析bounding_con配置，生成中间YAML文件"""
        if 'bounding_con' not in self.config:
            print("No bounding_con found in configuration")
            return None
            
        print("Processing bounding_con configurations...")
        
        generated_connections = {}
        
        # 处理bounding_con配置
        bounding_config = self.config['bounding_con']
        if bounding_config is None:
            print("bounding_con is empty")
            return None
        
        # 处理不同的YAML结构格式
        if isinstance(bounding_config, list):
            # 如果是列表格式：[{protocol: mappings}, ...]
            for bounding_item in bounding_config:
                if isinstance(bounding_item, dict):
                    for protocol, mappings in bounding_item.items():
                        protocol = protocol.lower()
                        print(f"Processing {protocol.upper()} protocol mappings...")
                        self._process_protocol_mappings(protocol, mappings, generated_connections)
        elif isinstance(bounding_config, dict):
            # 如果是字典格式：{protocol: mappings, ...}
            for protocol, mappings in bounding_config.items():
                protocol = protocol.lower()
                print(f"Processing {protocol.upper()} protocol mappings...")
                self._process_protocol_mappings(protocol, mappings, generated_connections)
        
        return generated_connections

    def _process_protocol_mappings(self, protocol: str, mappings: Dict[str, str], generated_connections: Dict[str, str]):
        """处理特定协议的映射"""
        
        for source_pattern, target_pattern in mappings.items():
            print(f"  Processing mapping: {source_pattern} -> {target_pattern}")
            
            # 解析source_pattern (如 u_cpu.a_*)
            if '.' not in source_pattern:
                print(f"Warning: Invalid source pattern format: {source_pattern}")
                continue
                
            instance_name, port_prefix = source_pattern.split('.', 1)
            
            # 找到对应的实例
            target_instance = None
            for instance in self.instances:
                if instance.instance_name == instance_name:
                    target_instance = instance
                    break
            
            if not target_instance:
                print(f"Warning: Instance {instance_name} not found")
                continue
            
            # 获取协议信号列表
            if protocol in self.protocol_signals:
                signal_list = self.protocol_signals[protocol]
                debug_print(f"    Using {protocol.upper()} protocol signals ({len(signal_list)} signals)")
            else:
                print(f"Warning: Unsupported protocol: {protocol}")
                continue
            
            # 处理通配符匹配（支持前缀、后缀和中间通配符）
            if '*' in port_prefix:
                matched_ports = self._match_wildcard_ports(port_prefix, target_pattern, target_instance.ports, signal_list)
                
                # 生成连接，统一使用小写信号名
                for port, target_name in matched_ports:
                    source_conn = f"{instance_name}.{port.name}"
                    generated_connections[source_conn] = target_name
                    debug_print(f"    Generated: {source_conn} -> {target_name}")

    def _match_wildcard_ports(self, source_pattern: str, target_pattern: str, ports: List[Port], signal_list: List[str]) -> List[Tuple[Port, str]]:
        """通用通配符匹配函数，支持前缀、后缀和中间通配符"""
        matched_ports = []
        
        # 将模式转换为正则表达式
        source_regex = self._wildcard_to_regex(source_pattern)
        
        for port in ports:
            match = re.match(source_regex, port.name, re.IGNORECASE)
            if match:
                # 检查匹配的部分是否包含协议信号
                captured_parts = match.groups()  # 获取通配符匹配的部分
                
                # 检查是否包含协议信号
                if self._contains_protocol_signal(port.name, signal_list):
                    # 生成目标信号名
                    target_name = self._generate_target_name(target_pattern, captured_parts, port.name)
                    matched_ports.append((port, target_name))
        
        return matched_ports
    
    def _wildcard_to_regex(self, pattern: str) -> str:
        """将通配符模式转换为正则表达式"""
        # 转义特殊字符，但保留 *
        escaped = re.escape(pattern).replace(r'\*', '(.*?)')
        return f"^{escaped}$"
    
    def _contains_protocol_signal(self, port_name: str, signal_list: List[str]) -> bool:
        """检查端口名是否包含协议信号"""
        port_lower = port_name.lower()
        for signal in signal_list:
            if signal.lower() in port_lower:
                return True
        return False
    
    def _generate_target_name(self, target_pattern: str, captured_parts: List[str], original_name: str) -> str:
        """根据目标模式和捕获的部分生成目标信号名"""
        if '*' not in target_pattern:
            return target_pattern.lower()
        
        # 处理目标模式中的通配符
        result = target_pattern
        for i, part in enumerate(captured_parts):
            # 第一次遇到*时替换
            result = result.replace('*', part.lower(), 1)
        
        return result


    def create_intermediate_yaml(self, generated_connections: Dict[str, str]) -> str:
        """创建包含生成的连接的中间YAML文件"""
        if not generated_connections:
            return None
            
        # 创建中间配置
        intermediate_config = self.config.copy()
        
        # 获取原有的connections
        original_connections = intermediate_config.get('connections', {})
        if original_connections is None:
            original_connections = {}
        
        # 合并连接：原有连接优先，不被生成的连接覆盖
        merged_connections = {}
        
        # 先添加生成的连接
        merged_connections.update(generated_connections)
        
        # 然后添加原有的连接，这会覆盖冲突的生成连接
        merged_connections.update(original_connections)
        
        # 输出被覆盖的连接信息
        for conn_key in generated_connections:
            if conn_key in original_connections:
                debug_print(f"    Override: {conn_key} -> {original_connections[conn_key]} (was {generated_connections[conn_key]})")
        
        intermediate_config['connections'] = merged_connections
        
        # 移除bounding_con，因为已经处理过了
        if 'bounding_con' in intermediate_config:
            del intermediate_config['bounding_con']
        
        # 生成中间文件名
        base_name = os.path.splitext(self.yaml_file)[0]
        intermediate_file = f"{base_name}_intermediate.yaml"
        
        try:
            with open(intermediate_file, 'w', encoding='utf-8') as f:
                yaml.dump(intermediate_config, f, default_flow_style=False, allow_unicode=True)
            print(f"Created intermediate YAML file: {intermediate_file}")
            return intermediate_file
        except Exception as e:
            print(f"Error creating intermediate YAML file: {e}")
            return None

    def _resolve_output_path(self, output_path: str) -> Optional[str]:
        """解析输出参数, 返回最终输出文件路径
        规则:
          - 如果 output_path 以 .v/.sv 结尾 -> 视为文件路径, 自动创建父目录
          - 否则视为目录, 目录不存在则创建, 文件名 = <top_module>.v (默认 soc_top)
        失败返回 None
        """
        output_file = output_path
        # 判断是否显式指定文件
        is_explicit_file = output_file.lower().endswith(('.v', '.sv')) and not os.path.isdir(output_file)
        if is_explicit_file:
            parent = os.path.dirname(output_file)
            if parent and not os.path.isdir(parent):
                try:
                    os.makedirs(parent, exist_ok=True)
                except Exception as e:
                    print(f"Error: cannot create parent directory {parent}: {e}")
                    return None
            return output_file
        # 其余情况按目录处理
        out_dir = output_file
        if not os.path.isdir(out_dir):
            try:
                os.makedirs(out_dir, exist_ok=True)
            except Exception as e:
                print(f"Error: cannot create output directory {out_dir}: {e}")
                return None
        top_name = self.config.get('top_module', 'soc_top')
        return os.path.join(out_dir, f"{top_name}.v")
    
    def _apply_generated_connections(self, generated_connections: Dict[str, str], original_yaml_file: str) -> Tuple[bool, Optional[str]]:
        """处理 bounding 生成的连接并重载配置。
        步骤:
          1. 若无生成连接, 直接返回 (True, None)。
          2. 生成中间 YAML (create_intermediate_yaml)。
          3. 若生成成功则替换 self.yaml_file 并重新 load_config。
        返回: (成功标志, 中间文件路径或None)
        """
        if not generated_connections:
            return True, None
        intermediate_yaml = self.create_intermediate_yaml(generated_connections)
        if not intermediate_yaml:
            # 未能生成文件, 继续后续流程(视为非致命)也可选择返回 False, 这里保持 True
            return True, None
        # 重新加载中间配置
        self.yaml_file = intermediate_yaml
        if not self.load_config():
            return False, None
        # 记录中间文件路径（如果生成了）
        intermediate_yaml_file = intermediate_yaml if self.yaml_file != original_yaml_file else None
        return True, intermediate_yaml_file
    

    def generate(self, output_path: str):
        """生成SOC顶层文件
        output_path: 可能是目录(推荐) 或 直接的 .v/.sv 文件
        如果是目录, 使用配置里的 top_module 作为文件名; 无 top_module 则 soc_top
        """
        print("Starting SOC generation...")
        
        # 记录原始的YAML文件路径
        original_yaml_file = self.yaml_file
        
        # 1. 加载配置
        if not self.load_config():
            return False
        
        # 2. 解析模块名称和文件映射
        self.parse_modules()
        
        # 3. 解析例化
        self.parse_instances()
        
        # 4. 根据实例参数解析模块详细信息
        self.parse_instance_modules()
        
        # 5. 处理bounding_con，生成中间YAML
        generated_connections = self.parse_bounding()
        success, intermediate_yaml_file = self._apply_generated_connections(generated_connections, original_yaml_file)
        if not success:
            return False
        
        # 6. 解析连线
        self.parse_connections()
        
        # 7. 生成自动连线
        self.generate_connections()
        
        # 8. 生成顶层端口
        self.generate_top_ports()
        
        # 9. 解析输出路径 
        output_file = self._resolve_output_path(output_path)
        if not output_file:
            return False
        
        # 10. 生成顶层模块
        self.generate_top_module(output_file)
        
        # 11. 如果在非调试模式下且存在中间文件，则删除中间文件
        if not _DEBUG_MODE and intermediate_yaml_file and os.path.exists(intermediate_yaml_file):
            try:
                os.remove(intermediate_yaml_file)
                print(f"Removed intermediate file: {intermediate_yaml_file}")
            except Exception as e:
                print(f"Warning: Failed to remove intermediate file {intermediate_yaml_file}: {e}")
        
        print("Generation completed!")
        return True


def main():
    """主函数"""
    parser = argparse.ArgumentParser(description='Verilog SOC Integration Script')
    parser.add_argument('-i', '--input', default='vcn.yaml', 
                       help='Input YAML configuration file')
    parser.add_argument('-o', '--output', default='.',
                       help='Output directory (file name = <top_module>.v). If a .v/.sv file path is given, use it directly.')
    parser.add_argument('-b', '--bounding', default='bounding.yaml',
                       help='Protocol signals definition file')
    parser.add_argument('-d', '--debug', action='store_true',
                       help='Enable debug output')
    
    args = parser.parse_args()
    
    # 创建生成器并运行
    generator = VerilogGenerator(args.input, args.debug, args.bounding)
    generator.generate(args.output)


if __name__ == '__main__':
    main()

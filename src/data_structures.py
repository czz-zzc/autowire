#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
数据结构定义模块
包含端口、实例、线信息等核心数据类
"""
from dataclasses import dataclass, field
from typing import Dict, List, Optional


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
    parameters: Dict[str, Parameter] = field(default_factory=dict)
    ports: List[Port] = field(default_factory=list)


@dataclass
class Instance:
    """例化信息类"""
    module_name: str
    instance_name: str
    parameters: Dict[str, str] = field(default_factory=dict)
    ports: List[Port] = field(default_factory=list)


@dataclass
class WireInfo:
    """线信息类"""
    name: str
    has_input: bool = False    # 是否有输入端口连接
    has_output: bool = False   # 是否有输出端口连接
    is_inout: bool = False     # 是否为双向端口（inout）
    input_width: str = ""      # 输入端口位宽
    output_width: str = ""     # 输出端口位宽
    input_width_value: int = 0 # 输入端口位宽数值
    output_width_value: int = 0 # 输出端口位宽数值
    is_array: bool = False     # 是否为数组信号
    array_size: str = ""       # 数组维度表达式
    source_instance: str = ""  # 来源实例名称（用于数组信息）


@dataclass
class DefineInfo:
    """宏定义信息类"""
    name: str
    value: str
    file_path: str = ""
    is_parametric: bool = False  # 是否是带参数的宏定义
    parameters: List[str] = field(default_factory=list)  # 宏参数列表

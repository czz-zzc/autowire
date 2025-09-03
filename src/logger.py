#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
日志模块
提供统一的日志管理
"""
import logging
import sys
from typing import Optional


def get_logger(name: str, level: int = logging.INFO, 
              log_file: Optional[str] = None) -> logging.Logger:
    """获取配置好的日志器"""
    logger = logging.getLogger(name)
    
    if logger.handlers:
        return logger
        
    logger.setLevel(level)
    
    # 创建格式器
    formatter = logging.Formatter(
        '%(asctime)s - %(levelname)-7s - %(name)-22s - %(message)s',
        datefmt='%Y-%m-%d %H:%M:%S'
    )
    
    # 控制台处理器
    console_handler = logging.StreamHandler(sys.stdout)
    console_handler.setLevel(level)
    console_handler.setFormatter(formatter)
    logger.addHandler(console_handler)
    
    # 文件处理器（如果指定）
    if log_file:
        try:
            file_handler = logging.FileHandler(log_file, encoding='utf-8')
            file_handler.setLevel(level)
            file_handler.setFormatter(formatter)
            logger.addHandler(file_handler)
        except Exception as e:
            logger.warning(f"Cannot create log file {log_file}: {e}")
    
    return logger


def set_debug_level(debug: bool = False):
    """设置全局调试级别"""
    level = logging.DEBUG if debug else logging.INFO
    
    # 设置根logger级别
    root_logger = logging.getLogger()
    root_logger.setLevel(level)
    
    # 设置所有已存在的logger级别
    for logger_name in logging.Logger.manager.loggerDict:
        logger = logging.getLogger(logger_name)
        logger.setLevel(level)
        # 同时更新所有处理器的级别
        for handler in logger.handlers:
            handler.setLevel(level)


def configure_file_logging(log_file: str):
    """为所有logger配置文件输出"""
    # 创建文件格式器
    formatter = logging.Formatter(
        '%(asctime)s - %(levelname)-7s - %(name)-22s - %(message)s',
        datefmt='%Y-%m-%d %H:%M:%S'
    )
    
    # 创建文件处理器
    try:
        file_handler = logging.FileHandler(log_file, encoding='utf-8')
        file_handler.setLevel(logging.DEBUG)
        file_handler.setFormatter(formatter)
        
        # 只为根logger添加文件处理器，这样所有子logger的日志都会传播到根logger
        # 避免重复记录
        root_logger = logging.getLogger()
        root_logger.addHandler(file_handler)
        
        # 确保所有logger都传播到根logger（默认是True，但确保一下）
        for logger_name in logging.Logger.manager.loggerDict:
            logger = logging.getLogger(logger_name)
            logger.propagate = True
            
    except Exception as e:
        print(f"Warning: Cannot create log file {log_file}: {e}")

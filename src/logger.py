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
    logging.getLogger().setLevel(level)

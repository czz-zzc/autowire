#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
AutoWire v2.0 - 重构版本主入口
基于pyverilog的Verilog SOC自动连线工具
"""
import argparse
import sys
import os

# 将src目录添加到路径，以便导入模块
sys.path.insert(0, os.path.join(os.path.dirname(__file__), 'src'))

from src.generator import AutoWireGenerator
from src.logger import get_logger

logger = get_logger(__name__)


def main():
    """主函数"""
    parser = argparse.ArgumentParser(
        description='AutoWire v2.0 - Verilog SOC Integration Tool (Refactored)',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  python autowire_v2.py -i vcn.yaml -o output/
  python autowire_v2.py -i vcn.yaml -o output/soc_top.v -d
  python autowire_v2.py -i vcn.yaml -b custom_bounding.yaml -o output/ -d
        """
    )
    
    parser.add_argument('-i', '--input', default='vcn.yaml', 
                       help='Input YAML configuration file (default: vcn.yaml)')
    parser.add_argument('-o', '--output', default='.',
                       help='Output directory or .v/.sv file path (default: .)')
    parser.add_argument('-b', '--bounding', default='bounding.yaml',
                       help='Protocol signals definition file (default: bounding.yaml)')
    parser.add_argument('-d', '--debug', action='store_true',
                       help='Enable debug output')
    parser.add_argument('--version', action='version', version='AutoWire v2.0.0')
    
    args = parser.parse_args()
    
    # 检查输入文件是否存在
    if not os.path.exists(args.input):
        logger.error(f"Input configuration file not found: {args.input}")
        return False
        
    # 创建生成器并运行
    try:
        generator = AutoWireGenerator(args.input, args.bounding, args.debug)
        success = generator.generate(args.output)
        
        if success:
            logger.info("AutoWire v2.0 completed successfully!")
            return True
        else:
            logger.error("AutoWire v2.0 failed!")
            return False
            
    except Exception as e:
        logger.error(f"Unexpected error: {e}")
        if args.debug:
            import traceback
            logger.error(traceback.format_exc())
        return False


if __name__ == '__main__':
    success = main()
    sys.exit(0 if success else 1)

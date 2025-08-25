# AutoWire v2.0

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python](https://img.shields.io/badge/python-3.7%2B-blue.svg)](https://www.python.org/)

AutoWire v2.0 是一个基于 [PyVerilog](https://github.com/PyHDI/Pyverilog) 的 Verilog SOC 自动连线工具。它能够自动解析 Verilog 模块，根据配置文件进行协议信号匹配和端口连线，最终生成顶层集成模块。

## 特性

- 🔧 **智能连线**: 支持基于协议信号的自动连线（AHB、AXI、APB等）
- 📝 **灵活配置**: 使用 YAML 配置文件进行模块定义和连线配置
- 🎯 **精确解析**: 基于 PyVerilog 进行准确的 Verilog 语法解析
- 🔄 **增量生成**: 支持中间配置文件生成，便于调试和验证
- 📊 **详细日志**: 提供完整的解析和连线过程日志
- 🛠️ **参数化支持**: 支持模块参数化实例

## 安装要求

- Python 3.7+
- PyVerilog
- PyYAML

```bash
pip install pyverilog pyyaml
```

## 快速开始

### 1. 基本用法

```bash
python autowire.py -i vcn.yaml -o output/
```

### 2. 配置文件示例

创建一个 YAML 配置文件（例如 `test.yaml`）：

```yaml
# 顶层模块名称
top_module: add_top

# 宏定义文件（可选）
define_files: 
  - ./rtl/DWC_pcie_dm_cc_constants.v
  - ./rtl/cxpl_defs.vh
  - ./rtl/radm_defs.vh

# RTL 模块文件
rtl_path:
  - ./rtl/DWC_pcie_dm.v
  - ./rtl/DW_axi_x2x.v

# 模块实例化
instances:
  - module: DWC_pcie_dm
    name: u_DWC_pcie_dm
  - module: DW_axi_x2x
    name: u_DW_axi_x2x
    parameters:
      DATA_WIDTH: 64
      ADDR_WIDTH: 32

# 手动连线（可选）
connections:
  u_cpu.clk: sys_clk
  u_uart.rst_n: sys_rst_n

# 协议信号连线（可选）
bounding_con:
  - ahb:
      u_cpu.a_*: cpu_ahbm_*
      u_uart.*_ahb: uart_ahb_*
  - axi:
      u_dma.m_*: dma_axi_*
```

### 3. 协议信号定义

创建协议信号定义文件 `bounding.yaml`：

```yaml
protocol_signals:
  ahb:
    - haddr
    - hwdata
    - hrdata
    - hwrite
    - htrans
    - hsize
    - hburst
    - hready
    - hresp
    - hsel
    - hready_out
  
  axi:
    # AW channel
    - awaddr
    - awlen
    - awsize
    - awburst
    - awlock
    - awcache
    - awprot
    - awvalid
    - awready
    - awid
    - awuser
    # W channel  
    - wdata
    - wstrb
    - wlast
    - wvalid
    - wready
    # R channel
    - rdata
    - rresp
    - rlast
    - rvalid
    - rready
    - rid
    # B channel
    - bresp
    - bvalid
    - bready
    - bid
    # AR channel
    - araddr
    - arlen
    - arsize
    - arburst
    - arlock
    - arcache
    - arprot
    - arvalid
    - arready
    - arid
```

## 工作原理

AutoWire v2.0 采用模块化架构，主要包含以下组件：

### 核心模块

1. **Generator (`generator.py`)**: 主控制器，协调各模块工作流程
2. **Config Manager (`config_manager.py`)**: 配置文件加载和管理
3. **Parser (`parser.py`)**: 基于 PyVerilog 的 Verilog 代码解析
4. **Connection Manager (`connection_manager.py`)**: 连线逻辑处理
5. **Code Generator (`code_generator.py`)**: 顶层模块代码生成

### 工作流程

1. **配置加载**: 解析 YAML 配置文件和协议信号定义
2. **模块解析**: 使用 PyVerilog 解析 RTL 文件，提取端口和参数信息
3. **连线处理**: 
   - 处理协议信号连线（基于模式匹配）
   - 处理手动连线配置
   - 执行自动连线（同名信号匹配）
4. **代码生成**: 生成顶层模块 Verilog 代码

### 数据结构

- `Port`: 端口信息（名称、方向、位宽等）
- `Instance`: 实例信息（模块名、实例名、参数等）
- `WireInfo`: 线网信息（输入输出连接状态）
- `ModuleInfo`: 模块信息（端口列表、参数列表等）

## 命令行选项

```
usage: autowire.py [-h] [-i INPUT] [-o OUTPUT] [-b BOUNDING] [-d] [--version]

AutoWire v2.0 - Verilog SOC Integration Tool (Refactored)

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Input YAML configuration file (default: vcn.yaml)
  -o OUTPUT, --output OUTPUT
                        Output directory or .v/.sv file path (default: .)
  -b BOUNDING, --bounding BOUNDING
                        Protocol signals definition file (default: bounding.yaml)
  -d, --debug           Enable debug output
  --version             show program version number and exit
```

## 使用示例

### 示例 1: 基本 SOC 集成

```bash

# 指定配置文件和输出目录
python autowire.py -i soc_config.yaml -b bounding.yaml -o build/

# 指定配置文件、bounding信号、输出目录
python autowire.py -i soc_config.yaml -b bounding.yaml -o build/

# 指定输出文件
python autowire.py -i soc_config.yaml -b bounding.yaml -o build/soc_top.v

# 开启调试模式
python autowire.py -i soc_config.yaml -b bounding.yaml -o build/soc_top.v -d
```

### 示例 2: 自定义协议信号

```bash
# 使用自定义协议信号定义文件
python autowire.py -i config.yaml -b custom_protocols.yaml -o output/
```

## 配置文件详解

### 主配置文件结构

```yaml
# 必需: 顶层模块名
top_module: soc_top

# 可选: 宏定义文件
define_files:
  - ./includes/defines.vh
  - ./includes/parameters.vh

# 必需: RTL 文件列表
rtl_path:
  - ./rtl/cpu_core.v
  - ./rtl/uart_controller.v
  - ./rtl/memory_controller.sv

# 必需: 实例化配置
instances:
  - module: cpu_core        # 模块名
    name: u_cpu            # 实例名
    parameters:            # 可选: 参数覆盖
      CACHE_SIZE: 1024
      DATA_WIDTH: 32

# 可选: 手动连线
connections:
  u_cpu.clk: sys_clk                    # 简单连线
  u_cpu.irq: "{7'b0, uart_irq}"         # 拼接信号
  u_uart.enable: 1'b1                   # 常数连接

# 可选: 协议信号连线
bounding_con:
  - ahb:
      u_cpu.ahb_*: cpu_ahb_*            # 通配符匹配
  - axi:
      u_dma.m_axi_*: dma_*
```

### 协议信号定义文件

协议信号定义文件用于定义标准总线协议的信号列表，支持的协议包括：

- **AHB**: ARM Advanced High-performance Bus
- **AXI**: ARM Advanced eXtensible Interface  
- **APB**: ARM Advanced Peripheral Bus

## 高级功能

### 通配符连线

支持使用通配符进行批量连线：

```yaml
bounding_con:
  - ahb:
      u_master.ahb_*: master_ahb_*      # 匹配所有 ahb_ 开头的端口
      u_slave.*_ahb: slave_ahb_*        # 匹配所有 _ahb 结尾的端口
```

### 参数化实例

支持为实例指定参数：

```yaml
instances:
  - module: memory_controller
    name: u_memory
    parameters:
      ADDR_WIDTH: 32
      DATA_WIDTH: 64
      CACHE_LINES: 256
```

### 信号拼接

支持复杂的信号连接表达式：

```yaml
connections:
  u_cpu.interrupt: "{irq_timer, irq_uart, 6'b0}"
  u_mux.select: "2'b01"
  u_module.data_out:                    # 悬空连接
```

## 输出文件

AutoWire 会生成标准的 Verilog 顶层模块文件，包含：

1. **模块声明**: 包含所有外部端口
2. **线网声明**: 内部连接线声明
3. **实例化**: 所有子模块的实例化代码
4. **注释**: 自动生成的时间戳和工具信息

生成的代码示例：

```verilog
// -----------------------------------------------------------------------------
// File      : soc_top.v
// Brief     : Auto-generated by autowire.py v2.0
// Author    : AutoWire
// Date      : 2025-08-24 21:35:09
// -----------------------------------------------------------------------------

module soc_top(
    // External ports
    input          clk,
    input          rst_n,
    output  [31:0] data_out
);

// Internal wires
wire  [15:0]  cpu_addr;
wire  [31:0]  cpu_data;
wire          cpu_valid;

// Instance: u_cpu (cpu_core)
cpu_core u_cpu (
    .clk        (clk        ),
    .rst_n      (rst_n      ),
    .addr       (cpu_addr   ),
    .data       (cpu_data   ),
    .valid      (cpu_valid  )
);

// Instance: u_memory (memory_controller)
memory_controller #(
    .ADDR_WIDTH(16),
    .DATA_WIDTH(32)
) u_memory (
    .clk        (clk        ),
    .rst_n      (rst_n      ),
    .addr       (cpu_addr   ),
    .data       (cpu_data   ),
    .valid      (cpu_valid  ),
    .data_out   (data_out   )
);

endmodule
```

## 故障排除

### 常见问题

1. **找不到模块定义**
   - 检查 `rtl_path` 中的文件路径是否正确
   - 确认模块名与文件中定义的模块名一致

2. **协议信号不匹配**
   - 检查 `bounding.yaml` 中的协议信号定义
   - 验证端口名称是否包含协议信号名

3. **解析错误**
   - 使用 `-d` 选项开启调试模式查看详细日志
   - 检查 Verilog 语法是否正确

### 调试模式

使用 `-d` 选项可以查看详细的执行过程：

```bash
python autowire.py -i config.yaml -o output/ -d
```

调试模式下会显示：
- 文件解析过程
- 端口匹配详情
- 连线生成信息
- 中间配置文件路径

## 项目结构

```
autowire-master/
├── autowire.py              # 主入口脚本
├── bounding.yaml           # 协议信号定义
├── test.yaml              # 示例配置文件
├── vcn.yaml               # 另一个配置文件示例
├── LICENSE                # MIT 许可证
├── src/                   # 核心源代码
│   ├── __init__.py
│   ├── generator.py       # 主生成器
│   ├── config_manager.py  # 配置管理
│   ├── parser.py          # Verilog解析器
│   ├── connection_manager.py  # 连线管理
│   ├── code_generator.py  # 代码生成
│   ├── data_structures.py # 数据结构定义
│   └── logger.py          # 日志管理
├── rtl/                   # RTL 文件目录
└── test_output_v2/        # 输出示例
```

## 贡献

欢迎提交 Issue 和 Pull Request！

## 许可证

本项目基于 MIT 许可证开源。详见 [LICENSE](LICENSE) 文件。

## 更新日志

### v2.0.0 (重构版本)
- 完全重构代码架构，提高可维护性
- 优化协议信号匹配算法
- 增强错误处理和日志输出
- 支持更灵活的配置选项
- 改进代码生成质量

---

**技术支持**: 如有问题请提交 GitHub Issue

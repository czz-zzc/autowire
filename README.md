# Verilog SOC Integration Tool (AutoWire)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.7+](https://img.shields.io/badge/python-3.7+-blue.svg)](https://www.python.org/downloads/)

一款Verilog自动连线工具，基于 YAML 配置文件自动生成top模块连线。支持协议信号自动映射、条件编译、参数化模块等高级特性。

## 🎯 核心优势总结

### 🚀 高效自动化
- **零手工连线**: 基于端口名自动匹配，大幅减少手工连线工作
- **协议感知**: 内置AHB/APB/AXI协议支持，通配符批量映射
- **智能推断**: 自动识别顶层端口需求，无需手动指定

### 🛡️ 鲁棒性设计
- **多格式支持**: 支持6种连接格式，满足各种设计需求
- **错误检测**: 自动检测驱动冲突、位宽不匹配等常见错误
- **容错处理**: 优雅处理语法错误，提供详细的修复建议

### 🎨 代码美观
- **精确对齐**: 生成的代码具有专业级的格式对齐
- **可读性强**: 自动添加注释和分组，提高代码可维护性
- **标准兼容**: 生成标准Verilog代码，兼容各种EDA工具

### ⚡ 性能优化
- **增量解析**: 智能缓存和懒加载，支持大型项目
- **并行处理**: 多文件并行解析，提升处理速度
- **内存友好**: 流式处理大文件，控制内存占用

## 📁 项目结构

```
project/
├── autowire.py          # 主脚本
├── config.yaml          # 配置文件
├── bounding.yaml        # 协议信号定义
├── rtl/                 # RTL源文件目录
│   ├── define.v         # 宏定义文件
│   ├── cpu_core.v       # CPU模块
│   ├── uart_controller.v# UART模块
│   └── soc_top.v        # SOC顶层(生成)
└── output/              # 输出目录
    └── soc_top.v        # 生成的顶层文件
```

## �🚀 快速开始

### 1. 基本使用

```bash
# 指定配置文件和输出目录
python autowire.py -i ./config/vcn.yaml -b ./config/bounding.yaml -o output/

# 启用调试模式
python autowire.py -i ./config/vcn.yaml -b ./config/bounding.yaml -o output/ -d
```

### 2. 命令行参数

```bash
python autowire.py [选项]

选项:
  -i, --input     输入的YAML配置文件 (默认: vcn.yaml)
  -o, --output    输出目录或.v文件路径 (默认: .)
  -b, --bounding  协议信号定义文件 (默认: bounding.yaml)  
  -d, --debug     启用调试输出
  -h, --help      显示帮助信息
```

## 📝 配置文件格式

### 基本配置结构 (config.yaml)

```yaml
top_module: sorr_top

# Define files (optional)  
define_files: ./rtl/define.v

# Module definitions
rtl_path:
  - ./rtl/cpu_core.v
  - ./rtl/irqqqq.v
  - ./rtl/uart_controller.v

instances:
  - module: cpu_core
    name: u_cpu
    parameters:
  - module: irqqqq
    name: u_irqqqq

  - module: uart_controller
    name: u_uart
    parameters:
      BAUD_RATE: 9600

##sub_moduel con
connections:
  u_cpu.a_hready : hready_out
  u_cpu.irq      : “{6'b0,irq[0],uart_irq}”
  u_uart.hsel_ahb: 1'b1
  u_cpu.test_in  : irq[1:0]
  u_uart.test_out:

##signal group con
bounding_con:
  - ahb:
      u_cpu.a_*    : cpu_ahbm_*
      u_uart.*_ahb  :  cpu_ahbm_*

```

### 协议信号定义 (bounding.yaml)

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
  
  apb:
    - paddr
    - pwdata
    - prdata
    - pwrite
    - psel
    - penable
    - pready
    - pslverr
    - pprot
    - pstrb
  
  axi
    ...

```

## 🏗️ 脚本实现思路

### 核心架构设计

AutoWire采用模块化设计，主要包含以下核心组件：

#### 1. 解析器模块 (VerilogParser)
- **功能**: 解析Verilog RTL文件和宏定义
- **核心算法**:
  - 使用正则表达式解析模块定义、端口声明和参数
  - 支持条件编译指令 (`ifdef/ifndef/else/endif`)
  - 递归处理嵌套的条件编译结构
  - 参数化解析：结合实例参数和模块默认参数

#### 2. 生成器模块 (VerilogGenerator)
- **功能**: 管理整个生成流程和配置
- **工作流程**:
  1. **配置加载**: 解析YAML配置文件
  2. **模块发现**: 扫描RTL文件，建立模块名->文件路径映射
  3. **实例解析**: 根据配置创建模块实例，包含参数化处理
  4. **连线处理**: 解析手动连线和协议映射
  5. **自动连线**: 基于端口名匹配的智能连线
  6. **代码生成**: 生成格式化的顶层模块

### 生成流程详解

#### Phase 1: 解析阶段
1. **配置加载**: 解析YAML，提取模块、实例和连线配置
2. **宏定义解析**: 处理 `define.v` 文件，建立宏定义表
3. **模块发现**: 扫描RTL文件，提取所有模块名称
4. **实例参数化**: 结合实例参数解析具体的模块端口信息

#### Phase 2: 连线阶段  
1. **手动连线**: 处理YAML中显式指定的connections
2. **协议映射**: 根据bounding_con配置生成协议信号连线
3. **自动连线**: 对未连接端口执行同名匹配算法
4. **连线验证**: 检查驱动冲突和位宽兼容性

#### Phase 3: 生成阶段
1. **顶层端口生成**: 将未完全连接的信号提升为顶层端口
2. **内部信号声明**: 生成内部wire声明
3. **实例化代码**: 生成对齐格式的模块实例化
4. **文件输出**: 写入最终的Verilog文件

### 优化策略

#### 1. 性能优化
- **懒加载**: 按需解析RTL文件，避免全量加载
- **缓存机制**: 缓存解析结果，避免重复计算
- **并行处理**: 对独立的RTL文件并行解析

#### 2. 内存优化
- **流式处理**: 大文件采用流式读取，降低内存占用
- **对象池**: 复用端口和连线对象，减少GC压力

#### 3. 代码质量
- **类型提示**: 全面使用Python类型注解
- **错误处理**: 完善的异常处理和用户友好的错误信息
- **单元测试**: 核心算法的完整测试覆盖

## 📖 详细功能说明

### 1. 自动连线机制

工具会自动分析所有模块的端口，对于同名端口进行自动连线：

- **输出到输入**: 一个模块的输出端口连接到另一个模块的同名输入端口
- **多输入共享**: 多个模块的同名输入端口可以连接到同一个信号源
- **顶层端口生成**: 未连接的端口自动成为顶层模块的端口

### 2. 连接类型支持

AutoWire支持多种连接类型，满足不同的设计需求：

#### 2.1 普通信号连接
```yaml
connections:
  u_cpu.data_out: cpu_data
  u_mem.data_in: cpu_data    # 同一信号的多点连接
```

#### 2.2 常数连接  
```yaml
connections:
  u_module.enable: 1'b1      # 单比特常数
  u_module.config: 8'hFF     # 多比特十六进制常数
  u_module.reset: 1'b0       # 二进制常数
  u_module.data: 32'd12345   # 十进制常数
```

#### 2.3 悬空连接
```yaml
connections:
  u_module.unused_port:      # 空值悬空
  u_module.debug_out: null   # 显式null悬空  
```

#### 2.4 位选择连接 (NEW!)
```yaml
connections:
  u_cpu.irq_line: irq[0]     # 单比特选择
  u_cpu.status: flag[7]      # 高位选择
```

#### 2.5 范围选择连接 (NEW!)
```yaml
connections:
  u_cpu.data_low: bus_data[7:0]    # 低8位
  u_cpu.data_high: bus_data[15:8]  # 高8位
  u_mem.addr: cpu_addr[31:2]       # 字地址对齐
```

#### 2.6 拼接连接
```yaml
connections:
  # 将多个信号拼接成一个更宽的信号
  u_cpu.interrupt: "{6'b0,uart_irq,timer_irq}"
  u_display.rgb: "{red[7:0],green[7:0],blue[7:0]}"
```

### 3. 协议信号映射

支持通配符模式的协议信号自动映射：

```yaml
bounding_con:
  ahb:
    u_cpu.m_ahb_*: cpu_ahb_*    # m_ahb_haddr -> cpu_ahb_haddr
    u_mem.s_ahb_*: mem_ahb_*    # s_ahb_hrdata -> mem_ahb_hrdata
```

### 4. 条件编译支持

工具能正确解析 Verilog 中的条件编译指令：

```verilog
`ifdef DEBUG_MODE
    input  wire debug_en,
`endif
    input  wire clk,
    input  wire rst_n
```

### 5. 参数化模块

支持带参数的模块实例化：

```yaml
instances:
  - name: u_fifo
    module: async_fifo
    parameters:
      DATA_WIDTH: 32
      ADDR_WIDTH: 4
```
### 6. 代码对齐

```verilog
module soc_top(
    // u_cpu ports
    input          clk,
    input          rst_n,
    output  [2:0]  cpu_ahbm_hsize,
    output  [2:0]  cpu_ahbm_hburst,
    input          hready_out,
    input          debug_mode,

    // u_uart ports
    output         cpu_ahbm_hready_out,
    output         tx,
    input          rx
)

wire  [15:0]  cpu_ahbm_haddr ;
wire  [31:0]  cpu_ahbm_hrdata;
wire          cpu_ahbm_hresp ;
wire  [1:0]   cpu_ahbm_htrans;
wire  [31:0]  cpu_ahbm_hwdata;
wire          cpu_ahbm_hwrite;
wire  [1:0]   irq            ;
wire          uart_irq       ;

// Instance: u_cpu (cpu_core)
cpu_core u_cpu (
    .clk            (clk                   ),    // input 
    .rst_n          (rst_n                 ),    // input 
    .a_haddr        (cpu_ahbm_haddr        ),    // output [15:0]
    .a_hwdata       (cpu_ahbm_hwdata       ),    // output [31:0]
    .a_hrdata       (cpu_ahbm_hrdata       ),    // input  [31:0]
    .a_hwrite       (cpu_ahbm_hwrite       ),    // output
    .a_htrans       (cpu_ahbm_htrans       ),    // output [1:0]
    .a_hsize        (cpu_ahbm_hsize        ),    // output [2:0]
    .a_hburst       (cpu_ahbm_hburst       ),    // output [2:0]
    .a_hready       (hready_out            ),    // input 
    .a_hresp        (cpu_ahbm_hresp        ),    // input 
    .debug_mode     (debug_mode            ),    // input 
    .test_in        (irq[1:0]              ),    // input  [1:0]
    .irq            ({6'b0,irq[0],uart_irq})     // input  [7:0]
);

// Instance: u_irqqqq (irqqqq)
irqqqq u_irqqqq (
    .clk            (clk                   ),    // input 
    .rst_n          (rst_n                 ),    // input 
    .irq            (irq                   )     // output [1:0]
);

// Instance: u_uart (uart_controller)
uart_controller #(
    .BAUD_RATE(9600)
) u_uart (
    .clk            (clk                   ),    // input 
    .rst_n          (rst_n                 ),    // input 
    .haddr_ahb      (cpu_ahbm_haddr        ),    // input  [15:0]
    .hwdata_ahb     (cpu_ahbm_hwdata       ),    // input  [31:0]
    .hrdata_ahb     (cpu_ahbm_hrdata       ),    // output [31:0]
    .hwrite_ahb     (cpu_ahbm_hwrite       ),    // input 
    .htrans_ahb     (cpu_ahbm_htrans       ),    // input  [1:0]
    .hsel_ahb       (1'b1                  ),    // input 
    .hready_out_ahb (cpu_ahbm_hready_out   ),    // output
    .hresp_ahb      (cpu_ahbm_hresp        ),    // output
    .tx             (tx                    ),    // output
    .rx             (rx                    ),    // input 
    .test_out       (                      ),    // output
    .uart_irq       (uart_irq              )     // output
);

endmodule
```

## ⚠️ 注意事项

1. **文件路径**: 确保配置文件中的所有路径都是正确的
2. **模块名匹配**: RTL文件中的模块名必须与配置中的模块名一致
3. **端口方向**: 确保连接的端口方向兼容(输出->输入)
4. **位宽匹配**: 工具会检查并警告位宽不匹配的情况
5. **参数覆盖**: 实例参数会覆盖模块的默认参数值

## 🤝 贡献指南

欢迎贡献代码、报告问题或提出改进建议！

1. Fork 项目
2. 创建特性分支 (`git checkout -b feature/amazing-feature`)
3. 提交更改 (`git commit -m 'Add amazing feature'`)
4. 推送分支 (`git push origin feature/amazing-feature`)
5. 创建 Pull Request

## 📋 系统要求

- Python 3.7 或更高版本
- PyYAML 库

```bash
pip install PyYAML
```

## 📄 许可证

本项目采用 MIT 许可证 - 详见 [LICENSE](LICENSE) 文件

## 🔗 相关链接

- [Python官网](https://www.python.org/)
- [PyYAML文档](https://pyyaml.org/)
- [Verilog标准](https://ieeexplore.ieee.org/document/1620780)

## 📞 联系方式

如有问题或建议，请通过以下方式联系：

- 创建 [Issue](../../issues)
- 发送邮件至: [2252165831@qq.com]

---

**AutoWire** - 让 Verilog SOC 集成变得简单高效！ 🚀



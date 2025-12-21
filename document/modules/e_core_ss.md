# Efficieny Core Subsystem

The `e_core_ss` module implements the Efficiency Core Subsystem, which includes a RISC-V based core optimized for low power consumption and efficient performance. It also includes itcm, dtcm, clock gate, etc.

![e_core_ss](../svg/modules/e_core_ss.drawio.svg)

## Ports

| Name         | Width          | Direction | Description                    |
| ------------ | -------------- | --------- | ------------------------------ |
| clk_i        | 1              | Input     | System clock                   |
| arst_ni      | 1              | Input     | Asynchronous reset, active low |
| m_axi_req_o  | rvv_axi_req_t  | Output    | Master AXI request Struct      |
| m_axi_resp_i | rvv_axi_resp_t | Input     | Master AXI response Struct     |
| s_axi_req_i  | rvv_axi_req_t  | Input     | Slave AXI request Struct       |
| s_axi_resp_o | rvv_axi_resp_t | Output    | Slave AXI response Struct      |
| io_debug_out | io_debug_out_t | Output    | Debug output Struct            |
| slog_debug   | slog_debug_t   | Output    | Slog debug Struct              |
| io_irq       | 1              | Input     | Interrupt request              |
| io_te        | 1              | Input     | Timer enable                   |
| io_halted    | 1              | Output    | Core halted indicator          |
| io_fault     | 1              | Output    | Core fault indicator           |
| io_wfi       | 1              | Output    | Core waiting for interrupt     |
| io_debug_en  | 4              | Output    | Debug enable signals           |

## Struct Definitions

### rvv_axi_req_t

| Field Name | Width             | Description           |
| ---------- | ----------------- | --------------------- |
| aw         | rvv_axi_aw_chan_t | Write address Channel |
| aw_valid   | 1                 | Write address valid   |
| w          | rvv_axi_w_chan_t  | Write data Channel    |
| w_valid    | 1                 | Write data valid      |
| b_ready    | 1                 | Write response ready  |
| ar         | rvv_axi_ar_chan_t | Read address Channel  |
| ar_valid   | 1                 | Read address valid    |
| r_ready    | 1                 | Read data ready       |

### rvv_axi_resp_t

| Field Name | Width            | Description          |
| ---------- | ---------------- | -------------------- |
| aw_ready   | 1                | Write address ready  |
| w_ready    | 1                | Write data ready     |
| b          | rvv_axi_b_chan_t | Write response Chan  |
| b_valid    | 1                | Write response valid |
| ar_ready   | 1                | Read address ready   |
| r          | rvv_axi_r_chan_t | Read data Channel    |
| r_valid    | 1                | Read data valid      |

### rvv_axi_aw_chan_t

| Field Name | Width | Description        |
| ---------- | ----- | ------------------ |
| id         | 6     | Transaction ID     |
| addr       | 32    | Address            |
| len        | 8     | Burst length       |
| size       | 3     | Burst size         |
| burst      | 2     | Burst type         |
| lock       | 2     | Lock type          |
| cache      | 4     | Cache type         |
| prot       | 3     | Protection type    |
| qos        | 4     | Quality of Service |
| region     | 4     | Region identifier  |
| atop       | 6     | Atomic Operation   |
| user       | 8     | User signal        |

### rvv_axi_w_chan_t

| Field Name | Width | Description   |
| ---------- | ----- | ------------- |
| data       | 128   | Write data    |
| strb       | 16    | Write strobe  |
| last       | 1     | Last transfer |
| user       | 8     | User signal   |

### rvv_axi_b_chan_t

| Field Name | Width | Description    |
| ---------- | ----- | -------------- |
| id         | 6     | Transaction ID |
| resp       | 2     | Write response |
| user       | 8     | User signal    |

### rvv_axi_ar_chan_t

| Field Name | Width | Description        |
| ---------- | ----- | ------------------ |
| id         | 6     | Transaction ID     |
| addr       | 32    | Address            |
| len        | 8     | Burst length       |
| size       | 3     | Burst size         |
| burst      | 2     | Burst type         |
| lock       | 2     | Lock type          |
| cache      | 4     | Cache type         |
| prot       | 3     | Protection type    |
| qos        | 4     | Quality of Service |
| region     | 4     | Region identifier  |
| user       | 8     | User signal        |

### rvv_axi_r_chan_t

| Field Name | Width | Description    |
| ---------- | ----- | -------------- |
| id         | 6     | Transaction ID |
| data       | 128   | Read data      |
| resp       | 2     | Read response  |
| last       | 1     | Last transfer  |
| user       | 8     | User signal    |

### io_debug_out_t

| Field Name                  | Width  | Description                                             |
| ----------------------------| ------ | ------------------------------------------------------- |
| inst                        | 128    | Instruction words corresponding to each PC              |
| addr                        | 128    | Program counter (PC) addresses for up to 4 instructions |
| cycles                      | 32     | Global cycle counter for timestamping/debug correlation |
| dbus_valid                  | 1      | Indicates a valid debug bus transaction                 |
| dbus_addr                   | 32     | Debug bus address                                       |
| dbus_wdata                  | 128    | Debug bus write data                                    |
| dbus_write                  | 1      | Debug bus direction                                     |
| dispatch_instFire           | 4      | Indicates which dispatch lanes issued an instruction    |
| dispatch_instAddr           | 128    | PC of instructions dispatched per lane                  |
| dispatch_instInst           | 128    | Instruction opcode dispatched per lane                  |
| regfile_waddr_valid         | 4      | Valid flags for integer register write addresses        |
| regfile_waddr_bits          | 20     | Integer register destination indices (x0–x31)           |
| regfile_wdata_valid         | 6      | Valid flags for register write data ports               |
| regfile_wdata_bits_addr     | 30     | Register destination addresses for writeback            |
| regfile_wdata_bits_data     | 192    | Register writeback data values                          |
| float_writeAddr_valid       | 1      | Floating-point register write address valid             |
| float_writeAddr_bits        | 5      | Floating-point destination register index               |
| float_writeData_0_valid     | 1      | FP writeback port 0 valid                               |
| float_writeData_0_bits_addr | 32     | FP register address (port 0)                            |
| float_writeData_0_bits_data | 32     | FP writeback data (port 0)                              |
| float_writeData_1_valid     | 1      | FP writeback port 1 valid                               |
| float_writeData_1_bits_addr | 32     | FP register address (port 1)                            |
| float_writeData_1_bits_data | 32     | FP writeback data (port 1)                              |

### slog_debug_t

| Field Name | Width | Description                                       |
| ---------- | ----- | --------------------------------------------------|
| valid      | 1     | Indicates whether the debug log entry is valid    |
| addr       | 5     | Address or index associated with the debug event  |
| data       | 32    | Debug data payload corresponding to the address   |

### other_io

| Field Name | Width | Description                                                 |
| ---------- | ----- | ------------------------------------------------------------|
| io_irq     | 1	 | Interrupt request signal to the core                        |
| io_te      | 1	 | Test / trace enable signal                                  |
| io_halted  | 1	 | Indicates the core is halted                                |
| io_fault   | 1	 | Indicates a fault or exception condition                    |
| io_wfi     | 1	 | Indicates the core is in WFI (Wait For Interrupt) state     |
| io_debug_en| 4	 | Debug enable bus; each bit enables a specific debug feature |

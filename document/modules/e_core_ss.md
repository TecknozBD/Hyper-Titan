# Efficieny Core Subsystem

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

### Struct Definitions

#### rvv_axi_req_t

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

#### rvv_axi_resp_t

| Field Name | Width            | Description          |
| ---------- | ---------------- | -------------------- |
| aw_ready   | 1                | Write address ready  |
| w_ready    | 1                | Write data ready     |
| b          | rvv_axi_b_chan_t | Write response Chan  |
| b_valid    | 1                | Write response valid |
| ar_ready   | 1                | Read address ready   |
| r          | rvv_axi_r_chan_t | Read data Channel    |
| r_valid    | 1                | Read data valid      |

#### rvv_axi_aw_chan_t

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

#### rvv_axi_w_chan_t

| Field Name | Width | Description   |
| ---------- | ----- | ------------- |
| data       | 128   | Write data    |
| strb       | 16    | Write strobe  |
| last       | 1     | Last transfer |
| user       | 8     | User signal   |

#### rvv_axi_b_chan_t

| Field Name | Width | Description    |
| ---------- | ----- | -------------- |
| id         | 6     | Transaction ID |
| resp       | 2     | Write response |
| user       | 8     | User signal    |

#### rvv_axi_ar_chan_t

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

#### rvv_axi_r_chan_t

| Field Name | Width | Description    |
| ---------- | ----- | -------------- |
| id         | 6     | Transaction ID |
| data       | 128   | Read data      |
| resp       | 2     | Read response  |
| last       | 1     | Last transfer  |
| user       | 8     | User signal    |

#### io_debug_out_t

| Field Name | Width | Description |
| ---------- | ----- | ----------- |

// TODO AMIT

#### slog_debug_t

| Field Name | Width | Description |
| ---------- | ----- | ----------- |

// TODO AMIT

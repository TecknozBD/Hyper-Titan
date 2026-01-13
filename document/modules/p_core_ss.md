# Performance Core Subsystem

The `p_core_ss` module implements the Performance Core Subsystem, which includes a high-performance RISC-V based core designed for maximum throughput and computational power.

![p_core_ss](../svg/modules/p_core_ss.svg)

_Figure: Performance Core Subsystem_

## Ports

| Name            | Width           | Direction | Description                    |
| --------------- | --------------- | --------- | ------------------------------ |
| clk_i           | 1               | Input     | System clock                   |
| arst_ni         | 1               | Input     | Asynchronous reset, active low |
| boot_addr_i     | 32              | Input     | Boot address for the core      |
| hart_id_i       | 32              | Input     | Hardware thread ID             |
| irq_i           | 2               | Input     | Interrupt request signals      |
| ipi_i           | 1               | Input     | Inter-processor interrupt      |
| time_irq_i      | 1               | Input     | Timer interrupt                |
| debug_req_i     | 1               | Input     | Debug request signal           |
| rs_m_axi_req_o  | rs_m_axi_req_t  | Output    | Master AXI request Struct      |
| rs_m_axi_resp_i | rs_m_axi_resp_t | Input     | Master AXI response Struct     |
| rs_s_axi_req_i  | rs_s_axi_req_t  | Input     | Slave AXI request Struct       |
| rs_s_axi_resp_o | rs_s_axi_resp_t | Output    | Slave AXI response Struct      |

## Struct Definitions

### rs_m_axi_req_t

| Field Name | Width              | Description           |
| ---------- | ------------------ | --------------------- |
| aw         | rs_m_axi_aw_chan_t | Write address Channel |
| aw_valid   | 1                  | Write address valid   |
| w          | rs_m_axi_w_chan_t  | Write data Channel    |
| w_valid    | 1                  | Write data valid      |
| b_ready    | 1                  | Write response ready  |
| ar         | rs_m_axi_ar_chan_t | Read address Channel  |
| ar_valid   | 1                  | Read address valid    |
| r_ready    | 1                  | Read data ready       |

### rs_m_axi_resp_t

| Field Name | Width             | Description          |
| ---------- | ----------------- | -------------------- |
| aw_ready   | 1                 | Write address ready  |
| w_ready    | 1                 | Write data ready     |
| b          | rs_m_axi_b_chan_t | Write response Chan  |
| b_valid    | 1                 | Write response valid |
| ar_ready   | 1                 | Read address ready   |
| r          | rs_m_axi_r_chan_t | Read data Channel    |
| r_valid    | 1                 | Read data valid      |

### rs_m_axi_aw_chan_t

| Field Name | Width | Description        |
| ---------- | ----- | ------------------ |
| id         | 4     | Transaction ID     |
| addr       | 64    | Address            |
| len        | 8     | Burst length       |
| size       | 3     | Burst size         |
| burst      | 2     | Burst type         |
| lock       | 2     | Lock type          |
| cache      | 4     | Cache type         |
| prot       | 3     | Protection type    |
| qos        | 4     | Quality of Service |
| region     | 4     | Region identifier  |
| atop       | 6     | Atomic Operation   |
| user       | 1     | User signal        |

### rs_m_axi_w_chan_t

| Field Name | Width | Description   |
| ---------- | ----- | ------------- |
| data       | 64    | Write data    |
| strb       | 8     | Write strobe  |
| last       | 1     | Last transfer |
| user       | 1     | User signal   |

### rs_m_axi_b_chan_t

| Field Name | Width | Description    |
| ---------- | ----- | -------------- |
| id         | 4     | Transaction ID |
| resp       | 2     | Write response |
| user       | 1     | User signal    |

### rs_m_axi_ar_chan_t

| Field Name | Width | Description        |
| ---------- | ----- | ------------------ |
| id         | 4     | Transaction ID     |
| addr       | 64    | Address            |
| len        | 8     | Burst length       |
| size       | 3     | Burst size         |
| burst      | 2     | Burst type         |
| lock       | 2     | Lock type          |
| cache      | 4     | Cache type         |
| prot       | 3     | Protection type    |
| qos        | 4     | Quality of Service |
| region     | 4     | Region identifier  |
| user       | 1     | User signal        |

### rs_m_axi_r_chan_t

| Field Name | Width | Description    |
| ---------- | ----- | -------------- |
| id         | 4     | Transaction ID |
| data       | 64    | Read data      |
| resp       | 2     | Read response  |
| last       | 1     | Last transfer  |
| user       | 1     | User signal    |

### rs_s_axi_req_t

| Field Name | Width              | Description           |
| ---------- | ------------------ | --------------------- |
| aw         | rs_s_axi_aw_chan_t | Write address Channel |
| aw_valid   | 1                  | Write address valid   |
| w          | rs_s_axi_w_chan_t  | Write data Channel    |
| w_valid    | 1                  | Write data valid      |
| b_ready    | 1                  | Write response ready  |
| ar         | rs_s_axi_ar_chan_t | Read address Channel  |
| ar_valid   | 1                  | Read address valid    |
| r_ready    | 1                  | Read data ready       |

### rs_s_axi_resp_t

| Field Name | Width             | Description          |
| ---------- | ----------------- | -------------------- |
| aw_ready   | 1                 | Write address ready  |
| w_ready    | 1                 | Write data ready     |
| b          | rs_s_axi_b_chan_t | Write response Chan  |
| b_valid    | 1                 | Write response valid |
| ar_ready   | 1                 | Read address ready   |
| r          | rs_s_axi_r_chan_t | Read data Channel    |
| r_valid    | 1                 | Read data valid      |

### rs_s_axi_aw_chan_t

| Field Name | Width | Description        |
| ---------- | ----- | ------------------ |
| id         | 6     | Transaction ID     |
| addr       | 64    | Address            |
| len        | 8     | Burst length       |
| size       | 3     | Burst size         |
| burst      | 2     | Burst type         |
| lock       | 2     | Lock type          |
| cache      | 4     | Cache type         |
| prot       | 3     | Protection type    |
| qos        | 4     | Quality of Service |
| region     | 4     | Region identifier  |
| atop       | 6     | Atomic Operation   |
| user       | 1     | User signal        |

### rs_s_axi_w_chan_t

| Field Name | Width | Description   |
| ---------- | ----- | ------------- |
| data       | 64    | Write data    |
| strb       | 8     | Write strobe  |
| last       | 1     | Last transfer |
| user       | 1     | User signal   |

### rs_s_axi_b_chan_t

| Field Name | Width | Description    |
| ---------- | ----- | -------------- |
| id         | 6     | Transaction ID |
| resp       | 2     | Write response |
| user       | 1     | User signal    |

### rs_s_axi_ar_chan_t

| Field Name | Width | Description        |
| ---------- | ----- | ------------------ |
| id         | 6     | Transaction ID     |
| addr       | 64    | Address            |
| len        | 8     | Burst length       |
| size       | 3     | Burst size         |
| burst      | 2     | Burst type         |
| lock       | 2     | Lock type          |
| cache      | 4     | Cache type         |
| prot       | 3     | Protection type    |
| qos        | 4     | Quality of Service |
| region     | 4     | Region identifier  |
| user       | 1     | User signal        |

### rs_s_axi_r_chan_t

| Field Name | Width | Description    |
| ---------- | ----- | -------------- |
| id         | 6     | Transaction ID |
| data       | 64    | Read data      |
| resp       | 2     | Read response  |
| last       | 1     | Last transfer  |
| user       | 1     | User signal    |

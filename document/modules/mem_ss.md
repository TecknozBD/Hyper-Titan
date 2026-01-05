# Memory Subsystem

The `mem_ss` module implements the Memory Subsystem, which includes an on-chip ROM and outbound AXI4 master interfaces that connects to a DDR3 PHY. It is responsible for managing memory access and ensuring data integrity.

![mem_ss](../svg/modules/mem_ss.svg)
_Figure 1: Memory Subsystem Block Diagram_

## Ports

| Name            | Width      | Direction | Description                       |
| --------------- | ---------- | --------- | --------------------------------- |
| clk_i           | 1          | Input     | System clock                      |
| arst_ni         | 1          | Input     | Asynchronous reset, active low    |
| sl_m_axi_req_t  | ram_req_t  | Input     | Slave AXI request Struct for RAM  |
| sl_m_axi_resp_t | ram_resp_t | Output    | Slave AXI response Struct for RAM |
| sl_m_axi_req_t  | rom_req_t  | Input     | Slave AXI request Struct for ROM  |
| sl_m_axi_resp_t | rom_resp_t | Output    | Slave AXI response Struct for ROM |

## Struct Definitions

### sl_m_axi_req_t

| Field Name | Width              | Description           |
| ---------- | ------------------ | --------------------- |
| aw         | sl_m_axi_aw_chan_t | Write address Channel |
| aw_valid   | 1                  | Write address valid   |
| w          | sl_m_axi_w_chan_t  | Write data Channel    |
| w_valid    | 1                  | Write data valid      |
| b_ready    | 1                  | Write response ready  |
| ar         | sl_m_axi_ar_chan_t | Read address Channel  |
| ar_valid   | 1                  | Read address valid    |
| r_ready    | 1                  | Read data ready       |

### sl_m_axi_resp_t

| Field Name | Width             | Description          |
| ---------- | ----------------- | -------------------- |
| aw_ready   | 1                 | Write address ready  |
| w_ready    | 1                 | Write data ready     |
| b          | sl_m_axi_b_chan_t | Write response Chan  |
| b_valid    | 1                 | Write response valid |
| ar_ready   | 1                 | Read address ready   |
| r          | sl_m_axi_r_chan_t | Read data Channel    |
| r_valid    | 1                 | Read data valid      |

### sl_m_axi_aw_chan_t

| Field Name | Width | Description        |
| ---------- | ----- | ------------------ |
| id         | 3     | Transaction ID     |
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

### sl_m_axi_w_chan_t

| Field Name | Width | Description   |
| ---------- | ----- | ------------- |
| data       | 64    | Write data    |
| strb       | 8     | Write strobe  |
| last       | 1     | Last transfer |
| user       | 8     | User signal   |

### sl_m_axi_b_chan_t

| Field Name | Width | Description    |
| ---------- | ----- | -------------- |
| id         | 3     | Transaction ID |
| resp       | 2     | Write response |
| user       | 8     | User signal    |

### sl_m_axi_ar_chan_t

| Field Name | Width | Description        |
| ---------- | ----- | ------------------ |
| id         | 3     | Transaction ID     |
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

### sl_m_axi_r_chan_t

| Field Name | Width | Description    |
| ---------- | ----- | -------------- |
| id         | 3     | Transaction ID |
| data       | 64    | Read data      |
| resp       | 2     | Read response  |
| last       | 1     | Last transfer  |
| user       | 8     | User signal    |

# System Link

The `system_link` module is responsible for managing the communication links between the Core Link, Peripheral Link, Memory Subsystem, and APB Bridge. It ensures efficient data transfer and coordination among these components, facilitating seamless operation of the overall system architecture. The module is an AXI XBar switch that routes data between the connected modules based on their addresses and control signals as depicted in the diagram below.

![System Link](../svg/modules/sl.svg)

_Figure: System Link Module Diagram_

**2 Slave Interfaces and 4 Master Interfaces**

## Ports

| Port Name | Direction | Width               | Description                                   |
| --------- | --------- | ------------------- | --------------------------------------------- |
| clk_i     | Input     | 1                   | System clock signal                           |
| arst_ni   | Input     | 1                   | Active low system reset signal                |
| slv_req_i | Input     | [2] sl_s_axi_req_t  | Slave request signal from connected modules   |
| slv_rsp_o | Output    | [2] sl_s_axi_resp_t | Slave response signal to connected modules    |
| mst_req_o | Output    | [4] sl_m_axi_req_t  | Master request signal to connected modules    |
| mst_rsp_i | Input     | [4] sl_m_axi_resp_t | Master response signal from connected modules |

## Struct Definitions

### sl_s_axi_req_t

| Field Name | Width              | Description           |
| ---------- | ------------------ | --------------------- |
| aw         | sl_s_axi_aw_chan_t | Write address Channel |
| aw_valid   | 1                  | Write address valid   |
| w          | sl_s_axi_w_chan_t  | Write data Channel    |
| w_valid    | 1                  | Write data valid      |
| b_ready    | 1                  | Write response ready  |
| ar         | sl_s_axi_ar_chan_t | Read address Channel  |
| ar_valid   | 1                  | Read address valid    |
| r_ready    | 1                  | Read data ready       |

### sl_s_axi_resp_t

| Field Name | Width             | Description          |
| ---------- | ----------------- | -------------------- |
| aw_ready   | 1                 | Write address ready  |
| w_ready    | 1                 | Write data ready     |
| b          | sl_s_axi_b_chan_t | Write response Chan  |
| b_valid    | 1                 | Write response valid |
| ar_ready   | 1                 | Read address ready   |
| r          | sl_s_axi_r_chan_t | Read data Channel    |
| r_valid    | 1                 | Read data valid      |

### sl_s_axi_aw_chan_t

| Field Name | Width | Description        |
| ---------- | ----- | ------------------ |
| id         | 2     | Transaction ID     |
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

### sl_s_axi_w_chan_t

| Field Name | Width | Description   |
| ---------- | ----- | ------------- |
| data       | 64    | Write data    |
| strb       | 8     | Write strobe  |
| last       | 1     | Last transfer |
| user       | 8     | User signal   |

### sl_s_axi_b_chan_t

| Field Name | Width | Description    |
| ---------- | ----- | -------------- |
| id         | 2     | Transaction ID |
| resp       | 2     | Write response |
| user       | 8     | User signal    |

### sl_s_axi_ar_chan_t

| Field Name | Width | Description        |
| ---------- | ----- | ------------------ |
| id         | 2     | Transaction ID     |
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

### sl_s_axi_r_chan_t

| Field Name | Width | Description    |
| ---------- | ----- | -------------- |
| id         | 2     | Transaction ID |
| data       | 64    | Read data      |
| resp       | 2     | Read response  |
| last       | 1     | Last transfer  |
| user       | 8     | User signal    |

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

## Routing Rules

| Address Range             | Target Master Port |
| ------------------------- | ------------------ |
| 0x0000_F000 - 0x0000_FFFF | Master Port 0      |
| 0x0001_0000 - 0x0001_7FFF | Master Port 0      |
| 0x0000_0000 - 0x0000_1FFF | Master Port 0      |
| 0x0800_0000 - 0x080F_FFFF | Master Port 0      |
| 0x0900_0000 - 0x0900_FFFF | Master Port 1      |
| 0x0000_3000 - 0x0000_3FFF | Master Port 3      |
| 0x0000_4000 - 0x0000_4FFF | Master Port 3      |
| 0x0000_6000 - 0x0000_6FFF | Master Port 3      |
| 0x1000_0000 - 0x1FFF_FFFF | Master Port 3      |
| 0x0000_2000 - 0x0000_2FFF | Master Port 3      |
| 0x0000_5000 - 0x0000_5FFF | Master Port 3      |
| All Other Addresses       | Master Port 2      |

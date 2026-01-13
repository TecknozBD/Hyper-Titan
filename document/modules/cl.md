# Core Link

The `core_link` module is responsible for facilitating communication between the Efficiency Core Subsystem and the Performance Core Subsystem. It manages data transfers and synchronization between the two cores, ensuring efficient operation of the SoC. The module is an AXI XBar switch that routes data between the connected modules based on their addresses and control signals as depicted in the diagram below.

![Core Link](../svg/modules/cl.svg)

_Figure: Core Link Module Diagram_

**3 Slave Interfaces and 3 Master Interfaces**

## Ports

| Port Name | Direction | Width               | Description                                  |
| --------- | --------- | ------------------- | -------------------------------------------- |
| clk_i     | Input     | 1                   | Core Link clock signal                       |
| arst_ni   | Input     | 1                   | Active low Core Link reset                   |
| slv_req_i | Input     | [3] cl_s_axi_req_t  | Slave request signal from connected modules  |
| slv_rsp_o | Output    | [3] cl_s_axi_resp_t | Slave response signal to connected modules   |
| mst_req_o | Output    | [3] cl_m_axi_req_t  | Master request signal to connected memory    |
| mst_rsp_i | Input     | [3] cl_m_axi_resp_t | Master response signal from connected memory |

## Struct Definitions

### cl_s_axi_req_t

| Field Name | Width              | Description           |
| ---------- | ------------------ | --------------------- |
| aw         | cl_s_axi_aw_chan_t | Write address Channel |
| aw_valid   | 1                  | Write address valid   |
| w          | cl_s_axi_w_chan_t  | Write data Channel    |
| w_valid    | 1                  | Write data valid      |
| b_ready    | 1                  | Write response ready  |
| ar         | cl_s_axi_ar_chan_t | Read address Channel  |
| ar_valid   | 1                  | Read address valid    |
| r_ready    | 1                  | Read data ready       |

### cl_s_axi_resp_t

| Field Name | Width             | Description          |
| ---------- | ----------------- | -------------------- |
| aw_ready   | 1                 | Write address ready  |
| w_ready    | 1                 | Write data ready     |
| b          | cl_s_axi_b_chan_t | Write response Chan  |
| b_valid    | 1                 | Write response valid |
| ar_ready   | 1                 | Read address ready   |
| r          | cl_s_axi_r_chan_t | Read data Channel    |
| r_valid    | 1                 | Read data valid      |

### cl_s_axi_aw_chan_t

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

### cl_s_axi_w_chan_t

| Field Name | Width | Description   |
| ---------- | ----- | ------------- |
| data       | 128   | Write data    |
| strb       | 16    | Write strobe  |
| last       | 1     | Last transfer |
| user       | 8     | User signal   |

### cl_s_axi_b_chan_t

| Field Name | Width | Description    |
| ---------- | ----- | -------------- |
| id         | 2     | Transaction ID |
| resp       | 2     | Write response |
| user       | 8     | User signal    |

### cl_s_axi_ar_chan_t

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

### cl_s_axi_r_chan_t

| Field Name | Width | Description    |
| ---------- | ----- | -------------- |
| id         | 2     | Transaction ID |
| data       | 128   | Read data      |
| resp       | 2     | Read response  |
| last       | 1     | Last transfer  |
| user       | 8     | User signal    |

### cl_m_axi_req_t

| Field Name | Width              | Description           |
| ---------- | ------------------ | --------------------- |
| aw         | cl_m_axi_aw_chan_t | Write address Channel |
| aw_valid   | 1                  | Write address valid   |
| w          | cl_m_axi_w_chan_t  | Write data Channel    |
| w_valid    | 1                  | Write data valid      |
| b_ready    | 1                  | Write response ready  |
| ar         | cl_m_axi_ar_chan_t | Read address Channel  |
| ar_valid   | 1                  | Read address valid    |
| r_ready    | 1                  | Read data ready       |

### cl_m_axi_resp_t

| Field Name | Width             | Description          |
| ---------- | ----------------- | -------------------- |
| aw_ready   | 1                 | Write address ready  |
| w_ready    | 1                 | Write data ready     |
| b          | cl_m_axi_b_chan_t | Write response Chan  |
| b_valid    | 1                 | Write response valid |
| ar_ready   | 1                 | Read address ready   |
| r          | cl_m_axi_r_chan_t | Read data Channel    |
| r_valid    | 1                 | Read data valid      |

### cl_m_axi_aw_chan_t

| Field Name | Width | Description        |
| ---------- | ----- | ------------------ |
| id         | 4     | Transaction ID     |
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

### cl_m_axi_w_chan_t

| Field Name | Width | Description   |
| ---------- | ----- | ------------- |
| data       | 128   | Write data    |
| strb       | 16    | Write strobe  |
| last       | 1     | Last transfer |
| user       | 8     | User signal   |

### cl_m_axi_b_chan_t

| Field Name | Width | Description    |
| ---------- | ----- | -------------- |
| id         | 4     | Transaction ID |
| resp       | 2     | Write response |
| user       | 8     | User signal    |

### cl_m_axi_ar_chan_t

| Field Name | Width | Description        |
| ---------- | ----- | ------------------ |
| id         | 4     | Transaction ID     |
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

### cl_m_axi_r_chan_t

| Field Name | Width | Description    |
| ---------- | ----- | -------------- |
| id         | 4     | Transaction ID |
| data       | 128   | Read data      |
| resp       | 2     | Read response  |
| last       | 1     | Last transfer  |
| user       | 8     | User signal    |

## Routing Rules

| Address Range             | Target Master Port |
| ------------------------- | ------------------ |
| 0x0001_0000 - 0x0001_7FFF | Master Port 0      |
| 0x0000_0000 - 0x0000_1FFF | Master Port 0      |
| 0x0800_0000 - 0x080F_FFFF | Master Port 1      |
| All Other Addresses       | Master Port 2      |

Further details on axi_xbar can be found [here](https://github.com/pulp-platform/axi/blob/master/doc/axi_xbar.md).

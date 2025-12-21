# Peripheral Link

The `peripheral_link` module is an AXI4-Lite crossbar that connects the system control and low-speed peripherals (UART, CLINT, PLIC) to the rest of the SoC. It accepts one slave-side AXI-Lite interface and routes transactions to up to five master-side ports based on the address map. Use this link for register-style, low-bandwidth accesses.

![Peripheral Link](../svg/modules/pl.drawio.svg)

**1 Slave Interface and 5 Master Interfaces**

## Ports

| Port Name | Direction | Width                | Description                                       |
| --------- | --------- | -------------------- | ------------------------------------------------- |
| clk_i     | Input     | 1                    | Peripheral Link clock signal                      |
| arst_ni   | Input     | 1                    | Active low Peripheral Link reset                  |
| slv_req_i | Input     | [1] pl_s_axil_req_t  | Slave request signal from connected modules       |
| slv_rsp_o | Output    | [1] pl_s_axil_resp_t | Slave response signal to connected modules        |
| mst_req_o | Output    | [5] pl_m_axil_req_t  | Master request signal to connected peripherals    |
| mst_rsp_i | Input     | [5] pl_m_axil_resp_t | Master response signal from connected peripherals |

### Address Routing

- System Control CSR maps to Master Port 0.
- UART maps to Master Port 2.
- CLINT maps to Master Port 3.
- PLIC maps to Master Port 4.
- Unmapped addresses fall through to Master Port 1 (default route / reserved).

### Struct Definitions

#### pl_s_axil_req_t

| Field Name | Width               | Description           |
| ---------- | ------------------- | --------------------- |
| aw         | pl_s_axil_aw_chan_t | Write address Channel |
| aw_valid   | 1                   | Write address valid   |
| w          | pl_s_axil_w_chan_t  | Write data Channel    |
| w_valid    | 1                   | Write data valid      |
| b_ready    | 1                   | Write response ready  |
| ar         | pl_s_axil_ar_chan_t | Read address Channel  |
| ar_valid   | 1                   | Read address valid    |
| r_ready    | 1                   | Read data ready       |

#### pl_s_axil_resp_t

| Field Name | Width              | Description          |
| ---------- | ------------------ | -------------------- |
| aw_ready   | 1                  | Write address ready  |
| w_ready    | 1                  | Write data ready     |
| b          | pl_s_axil_b_chan_t | Write response Chan  |
| b_valid    | 1                  | Write response valid |
| ar_ready   | 1                  | Read address ready   |
| r          | pl_s_axil_r_chan_t | Read data Channel    |
| r_valid    | 1                  | Read data valid      |

#### pl_s_axil_aw_chan_t

| Field Name | Width | Description     |
| ---------- | ----- | --------------- |
| addr       | 32    | Address         |
| prot       | 3     | Protection type |

#### pl_s_axil_w_chan_t

| Field Name | Width | Description  |
| ---------- | ----- | ------------ |
| data       | 32    | Write data   |
| strb       | 4     | Write strobe |

#### pl_s_axil_b_chan_t

| Field Name | Width | Description    |
| ---------- | ----- | -------------- |
| resp       | 2     | Write response |

#### pl_s_axil_ar_chan_t

| Field Name | Width | Description     |
| ---------- | ----- | --------------- |
| addr       | 32    | Address         |
| prot       | 3     | Protection type |

#### pl_s_axil_r_chan_t

| Field Name | Width | Description   |
| ---------- | ----- | ------------- |
| data       | 32    | Read data     |
| resp       | 2     | Read response |

#### pl_m_axil_req_t

| Field Name | Width               | Description           |
| ---------- | ------------------- | --------------------- |
| aw         | pl_m_axil_aw_chan_t | Write address Channel |
| aw_valid   | 1                   | Write address valid   |
| w          | pl_m_axil_w_chan_t  | Write data Channel    |
| w_valid    | 1                   | Write data valid      |
| b_ready    | 1                   | Write response ready  |
| ar         | pl_m_axil_ar_chan_t | Read address Channel  |
| ar_valid   | 1                   | Read address valid    |
| r_ready    | 1                   | Read data ready       |

#### pl_m_axil_resp_t

| Field Name | Width              | Description          |
| ---------- | ------------------ | -------------------- |
| aw_ready   | 1                  | Write address ready  |
| w_ready    | 1                  | Write data ready     |
| b          | pl_m_axil_b_chan_t | Write response Chan  |
| b_valid    | 1                  | Write response valid |
| ar_ready   | 1                  | Read address ready   |
| r          | pl_m_axil_r_chan_t | Read data Channel    |
| r_valid    | 1                  | Read data valid      |

#### pl_m_axil_aw_chan_t

| Field Name | Width | Description     |
| ---------- | ----- | --------------- |
| addr       | 32    | Address         |
| prot       | 3     | Protection type |

#### pl_m_axil_w_chan_t

| Field Name | Width | Description  |
| ---------- | ----- | ------------ |
| data       | 32    | Write data   |
| strb       | 4     | Write strobe |

#### pl_m_axil_b_chan_t

| Field Name | Width | Description    |
| ---------- | ----- | -------------- |
| resp       | 2     | Write response |

#### pl_m_axil_ar_chan_t

| Field Name | Width | Description     |
| ---------- | ----- | --------------- |
| addr       | 32    | Address         |
| prot       | 3     | Protection type |

#### pl_m_axil_r_chan_t

| Field Name | Width | Description   |
| ---------- | ----- | ------------- |
| data       | 32    | Read data     |
| resp       | 2     | Read response |

## Routing Rules

| Address Range             | Target Master Port |
| ------------------------- | ------------------ |
| 0x0000_2000 - 0x0000_2FFF | Master Port 0      |
| 0x0000_5000 - 0x0000_5FFF | Master Port 2      |
| 0x0000_3000 - 0x0000_3FFF | Master Port 3      |
| 0x0000_4000 - 0x0000_4FFF | Master Port 4      |
| All Other Addresses       | Master Port 1      |

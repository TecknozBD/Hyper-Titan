# APB Bridge

The `apb_bridge` module serves as a bridge between the AXI4 system bus and the APB3 peripheral bus. It allows an external APB master to access the internal components of the SoC through the AXI4 interface. The module handles the necessary protocol conversions and ensures proper timing and data integrity during transactions. The diagram below illustrates the structure of the APB Bridge module.

![apb_bridge](../svg/modules/apb_bridge.svg)
_Figure 1: APB Bridge Block Diagram_

## Ports

| Name          | Width           | Direction | Description                                       |
| ------------- | --------------- | --------- | ------------------------------------------------- |
| clk_apb_i     | 1               | Input     | APB domain clock                                  |
| arst_n_apb_i  | 1               | Input     | APB domain asynchronous reset, active low         |
| apb_req_i     | apb_req_t       | Input     | APB3 request struct from external master          |
| apb_resp_o    | apb_resp_t      | Output    | APB3 response struct to external master           |
| clk_sl_i      | 1               | Input     | System Link domain clock                          |
| arst_n_sl_i   | 1               | Input     | System Link domain asynchronous reset, active low |
| sl_axi_req_o  | sl_s_axi_req_t  | Output    | AXI4 request struct to System Link                |
| sl_axi_resp_i | sl_s_axi_resp_t | Input     | AXI4 response struct from System Link             |

## Struct Definitions

### apb_req_t

| Field Name | Width | Description       |
| ---------- | ----- | ----------------- |
| psel       | 1     | APB select signal |
| penable    | 1     | APB enable signal |
| paddr      | 32    | APB address       |
| pwrite     | 1     | APB write signal  |
| pwdata     | 32    | APB write data    |
| pstrb      | 4     | APB write strobe  |

### apb_resp_t

| Field Name | Width | Description            |
| ---------- | ----- | ---------------------- |
| pready     | 1     | APB ready signal       |
| pslverr    | 1     | APB slave error signal |
| prdata     | 32    | APB read data          |

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

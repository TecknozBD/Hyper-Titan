# AXI Converter

The AXI Converter module facilitates communication between two AXI interfaces operating in different clock domains, ID width, Address width, or Data width configurations. It ensures proper data transfer and protocol compliance across these differing AXI interfaces.

## Ports

| Name       | Width      | Direction | Description                     |
| ---------- | ---------- | --------- | ------------------------------- |
| arst_ni    | 1          | Input     | Asynchronous reset, active low  |
| src_clk_i  | 1          | Input     | Source domain clock             |
| src_req_i  | src_req_t  | Input     | Source AXI request struct       |
| src_resp_o | src_resp_t | Output    | Source AXI response struct      |
| dst_clk_i  | 1          | Input     | Destination domain clock        |
| dst_req_o  | dst_req_t  | Output    | Destination AXI request struct  |
| dst_resp_i | dst_resp_t | Input     | Destination AXI response struct |

## Struct Definitions

### src_req_t

| Field Name | Width         | Description           |
| ---------- | ------------- | --------------------- |
| aw         | src_aw_chan_t | Write address Channel |
| aw_valid   | 1             | Write address valid   |
| w          | src_w_chan_t  | Write data Channel    |
| w_valid    | 1             | Write data valid      |
| b_ready    | 1             | Write response ready  |
| ar         | src_ar_chan_t | Read address Channel  |
| ar_valid   | 1             | Read address valid    |
| r_ready    | 1             | Read data ready       |

### src_resp_t

| Field Name | Width        | Description          |
| ---------- | ------------ | -------------------- |
| aw_ready   | 1            | Write address ready  |
| w_ready    | 1            | Write data ready     |
| b          | src_b_chan_t | Write response Chan  |
| b_valid    | 1            | Write response valid |
| ar_ready   | 1            | Read address ready   |
| r          | src_r_chan_t | Read data Channel    |
| r_valid    | 1            | Read data valid      |

### src_aw_chan_t

| Field Name | Width | Description        |
| ---------- | ----- | ------------------ |
| id         | var   | Transaction ID     |
| addr       | var   | Address            |
| len        | 8     | Burst length       |
| size       | 3     | Burst size         |
| burst      | 2     | Burst type         |
| lock       | 2     | Lock type          |
| cache      | 4     | Cache type         |
| prot       | 3     | Protection type    |
| qos        | 4     | Quality of Service |
| region     | 4     | Region identifier  |
| atop       | 6     | Atomic Operation   |
| user       | var   | User signal        |

### src_w_chan_t

| Field Name | Width | Description   |
| ---------- | ----- | ------------- |
| data       | var   | Write data    |
| strb       | 8     | Write strobe  |
| last       | 1     | Last transfer |
| user       | var   | User signal   |

### src_b_chan_t

| Field Name | Width | Description    |
| ---------- | ----- | -------------- |
| id         | var   | Transaction ID |
| resp       | 2     | Write response |
| user       | var   | User signal    |

### src_ar_chan_t

| Field Name | Width | Description        |
| ---------- | ----- | ------------------ |
| id         | var   | Transaction ID     |
| addr       | var   | Address            |
| len        | 8     | Burst length       |
| size       | 3     | Burst size         |
| burst      | 2     | Burst type         |
| lock       | 2     | Lock type          |
| cache      | 4     | Cache type         |
| prot       | 3     | Protection type    |
| qos        | 4     | Quality of Service |
| region     | 4     | Region identifier  |
| user       | var   | User signal        |

### src_r_chan_t

| Field Name | Width | Description    |
| ---------- | ----- | -------------- |
| id         | var   | Transaction ID |
| data       | var   | Read data      |
| resp       | 2     | Read response  |
| last       | 1     | Last transfer  |
| user       | var   | User signal    |

### dst_req_t

| Field Name | Width         | Description           |
| ---------- | ------------- | --------------------- |
| aw         | dst_aw_chan_t | Write address Channel |
| aw_valid   | 1             | Write address valid   |
| w          | dst_w_chan_t  | Write data Channel    |
| w_valid    | 1             | Write data valid      |
| b_ready    | 1             | Write response ready  |
| ar         | dst_ar_chan_t | Read address Channel  |
| ar_valid   | 1             | Read address valid    |
| r_ready    | 1             | Read data ready       |

### dst_resp_t

| Field Name | Width        | Description          |
| ---------- | ------------ | -------------------- |
| aw_ready   | 1            | Write address ready  |
| w_ready    | 1            | Write data ready     |
| b          | dst_b_chan_t | Write response Chan  |
| b_valid    | 1            | Write response valid |
| ar_ready   | 1            | Read address ready   |
| r          | dst_r_chan_t | Read data Channel    |
| r_valid    | 1            | Read data valid      |

### dst_aw_chan_t

| Field Name | Width | Description        |
| ---------- | ----- | ------------------ |
| id         | var   | Transaction ID     |
| addr       | var   | Address            |
| len        | 8     | Burst length       |
| size       | 3     | Burst size         |
| burst      | 2     | Burst type         |
| lock       | 2     | Lock type          |
| cache      | 4     | Cache type         |
| prot       | 3     | Protection type    |
| qos        | 4     | Quality of Service |
| region     | 4     | Region identifier  |
| atop       | 6     | Atomic Operation   |
| user       | var   | User signal        |

### dst_w_chan_t

| Field Name | Width | Description   |
| ---------- | ----- | ------------- |
| data       | var   | Write data    |
| strb       | 8     | Write strobe  |
| last       | 1     | Last transfer |
| user       | var   | User signal   |

### dst_b_chan_t

| Field Name | Width | Description    |
| ---------- | ----- | -------------- |
| id         | var   | Transaction ID |
| resp       | 2     | Write response |
| user       | var   | User signal    |

### dst_ar_chan_t

| Field Name | Width | Description        |
| ---------- | ----- | ------------------ |
| id         | var   | Transaction ID     |
| addr       | var   | Address            |
| len        | 8     | Burst length       |
| size       | 3     | Burst size         |
| burst      | 2     | Burst type         |
| lock       | 2     | Lock type          |
| cache      | 4     | Cache type         |
| prot       | 3     | Protection type    |
| qos        | 4     | Quality of Service |
| region     | 4     | Region identifier  |
| user       | var   | User signal        |

### dst_r_chan_t

| Field Name | Width | Description    |
| ---------- | ----- | -------------- |
| id         | var   | Transaction ID |
| data       | var   | Read data      |
| resp       | 2     | Read response  |
| last       | 1     | Last transfer  |
| user       | var   | User signal    |

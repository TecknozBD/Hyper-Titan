# AXI to AXI-Lite Bridge

This module converts a full AXI interface to an AXI-Lite interface. It handles the necessary protocol conversions, including address alignment, burst handling, and response management.

## Parameters

| Name            | Description                                      | Default |
| --------------- | ------------------------------------------------ | ------- |
| AxiAddrWidth    | Width of the AXI address bus                     | 32      |
| AxiDataWidth    | Width of the AXI data bus                        | 32      |
| AxiIdWidth      | Width of the AXI ID bus                          | 4       |
| AxiUserWidth    | Width of the AXI user signal                     | 1       |
| AxiMaxWriteTxns | Maximum number of outstanding write transactions | 16      |
| AxiMaxReadTxns  | Maximum number of outstanding read transactions  | 16      |
| FullBW          | Enable full bandwidth mode for ID queue          | 0       |
| FallThrough     | Enable fall-through mode for FIFOs               | 1       |
| full_req_t      | Type of the full AXI request struct              | logic   |
| full_resp_t     | Type of the full AXI response struct             | logic   |
| lite_req_t      | Type of the AXI-Lite request struct              | logic   |
| lite_resp_t     | Type of the AXI-Lite response struct             | logic   |

## Ports

| Name       | Width       | Direction | Description                          |
| ---------- | ----------- | --------- | ------------------------------------ |
| clk_i      | 1           | Input     | Clock                                |
| rst_ni     | 1           | Input     | Asynchronous reset, active low       |
| test_i     | 1           | Input     | Test mode enable                     |
| slv_req_i  | full_req_t  | Input     | Slave port full AXI request struct   |
| slv_resp_o | full_resp_t | Output    | Slave port full AXI response struct  |
| mst_req_o  | lite_req_t  | Output    | Master port AXI-Lite request struct  |
| mst_resp_i | lite_resp_t | Input     | Master port AXI-Lite response struct |

Further details on axi_to_axi_lite can be found [here](https://github.com/pulp-platform/axi/blob/master/src/axi_to_axi_lite.sv).

# Performance Core Subsystem


## Ports

| Name             | Width            | Direction | Description                         |
| ---------------- | ---------------- | --------- | ----------------------------------- |
| clk_i            | 1                | Input     | System clock                        |
| arst_ni          | 1                | Input     | Asynchronous reset, active low      |
| boot_addr_i      | 32               | Input     | Boot address for the core           |
| hart_id_i        | 32               | Input     | Hardware thread ID                  |
| irq_i            | 2                | Input     | Interrupt request signals           |
| ipi_i            | 1                | Input     | Inter-processor interrupt           |
| time_irq_i       | 1                | Input     | Timer interrupt                     |
| debug_req_i      | 1                | Input     | Debug request signal                |
| rs_m_axi_req_o   | rs_m_axi_req_t   | Output    | Master AXI request Struct           |
| rs_m_axi_resp_i  | rs_m_axi_resp_t  | Input     | Master AXI response Struct          |
| rs_s_axi_req_i   | rs_s_axi_req_t   | Input     | Slave AXI request Struct            |
| rs_s_axi_resp_o  | rs_s_axi_resp_t  | Output    | Slave AXI response Struct           |


//******************************************************************************
// Module: uart
// Description:
//   Top-level UART module with configurable bus interface (AXI or APB).
//   Includes register interface, TX/RX modules, clock dividers, and CDC FIFOs
//   for crossing clock domains between the system clock and UART baud clock.
//******************************************************************************

module uart #(
    parameter type req_t = logic,   // AXI request type
    parameter type resp_t = logic,  // AXI response type
    parameter int MEM_BASE = 0,     // Base address for UART registers
    parameter int MEM_SIZE = 6,     // Register address width (64 byte address space)
    parameter int DATA_WIDTH = 32   // Data bus width
) (
    // System interface
    input  logic  arst_ni,  // Active-low asynchronous reset
    input  logic  clk_i,    // System clock
    input  req_t  req_i,    // Bus request (AXI or APB)
    output resp_t resp_o,   // Bus response (AXI or APB)

    // UART interface
    output logic       tx_o,  // UART transmit output
    input  logic       rx_i,  // UART receive input
    output logic [7:0] irq_o  // Interrupt output (RX data ready)
);

  //----------------------------------------------------------------------------
  // Import FIFO sizes from base package
  //----------------------------------------------------------------------------

  import uart_pkg::TX_FIFO_SIZE;
  import uart_pkg::RX_FIFO_SIZE;

  //----------------------------------------------------------------------------
  // Memory-mapped interface signals (between bus converter and register IF)
  //----------------------------------------------------------------------------

  logic                    mem_we;  // Write enable
  logic [    MEM_SIZE-1:0] mem_waddr;  // Write address
  logic [  DATA_WIDTH-1:0] mem_wdata;  // Write data
  logic [DATA_WIDTH/8-1:0] mem_wstrb;  // Write strobe (byte enables)
  logic [             1:0] mem_wresp;  // Write response

  logic                    mem_re;  // Read enable
  logic [    MEM_SIZE-1:0] mem_raddr;  // Read address
  logic [  DATA_WIDTH-1:0] mem_rdata;  // Read data
  logic [             1:0] mem_rresp;  // Read response

  //----------------------------------------------------------------------------
  // Control and configuration signals
  //----------------------------------------------------------------------------

  logic                    ctrl_clk_en;  // Clock enable control
  logic                    tx_fifo_flush;  // TX FIFO flush control
  logic                    rx_fifo_flush;  // RX FIFO flush control

  logic                    cfg_parity_en;  // Parity enable configuration
  logic                    cfg_parity_type;  // Parity type (0=even, 1=odd)
  logic                    cfg_stop_bits;  // Stop bits configuration (0=1 bit, 1=2 bits)
  logic                    cfg_rx_parity_err_en_o;
  logic                    cfg_rx_valid_en_o;
  logic                    cfg_rx_near_full_en_o;
  logic                    cfg_rx_full_en_o;
  logic                    cfg_tx_near_full_en_o;
  logic                    cfg_tx_full_en_o;

  logic                    int_parity_err_o;

  logic [  DATA_WIDTH-1:0] clk_div;  // Clock divider value for baud rate
  logic [  DATA_WIDTH-1:0] tx_fifo_count;  // TX FIFO occupancy count
  logic [  DATA_WIDTH-1:0] rx_fifo_count;  // RX FIFO occupancy count

  //----------------------------------------------------------------------------
  // FIFO interface signals (system clock domain)
  //----------------------------------------------------------------------------

  logic [             7:0] tx_fifo_data;  // TX FIFO input data
  logic                    tx_fifo_data_valid;  // TX FIFO input valid
  logic                    tx_fifo_data_ready;  // TX FIFO input ready

  logic [             7:0] rx_fifo_data;  // RX FIFO output data
  logic                    rx_fifo_data_valid;  // RX FIFO output valid
  logic                    rx_fifo_data_ready;  // RX FIFO output ready

  //----------------------------------------------------------------------------
  // UART TX/RX interface signals (baud clock domain)
  //----------------------------------------------------------------------------

  logic [             7:0] tx_data;  // TX data to UART transmitter
  logic                    tx_data_valid;  // TX data valid
  logic                    tx_data_ready;  // TX ready to accept data

  logic [             7:0] rx_data;  // RX data from UART receiver
  logic                    rx_data_valid;  // RX data valid

  //----------------------------------------------------------------------------
  // Generated baud clocks
  //----------------------------------------------------------------------------

  logic                    tx_clk;  // TX baud clock (clk_i / clk_div)
  logic                    rx_clk;  // RX oversampling clock (8x TX baud clock)

  //----------------------------------------------------------------------------
  // FIFO Count Temporary Signals
  //----------------------------------------------------------------------------

  logic [TX_FIFO_SIZE-1:0] tx_fifo_count_temp;
  logic [RX_FIFO_SIZE-1:0] rx_fifo_count_temp;

  //----------------------------------------------------------------------------
  // Access ID FIFO signals
  //----------------------------------------------------------------------------

  logic [             7:0] access_id_req;
  logic                    access_id_req_valid;
  logic                    access_id_req_ready;
  logic [             7:0] access_id_gnt;
  logic                    access_id_gnt_valid;
  logic                    access_id_gnt_ready;

  //============================================================================
  // FIFO Count Assignments
  //============================================================================

  assign tx_fifo_count = tx_fifo_count_temp;
  assign rx_fifo_count = rx_fifo_count_temp;

  //============================================================================
  // Bus-to-Memory Interface Converter
  // Converts AXI or APB bus transactions to simple memory interface
  //============================================================================

  axil_to_simple_if #(
      .req_t(req_t),
      .resp_t(resp_t),
      .MEM_BASE(MEM_BASE),
      .MEM_SIZE(MEM_SIZE)
  ) u_cvtr (
      .arst_ni(arst_ni),
      .clk_i(clk_i),
      .req_i(req_i),
      .resp_o(resp_o),
      .mem_we_o(mem_we),
      .mem_waddr_o(mem_waddr),
      .mem_wdata_o(mem_wdata),
      .mem_wstrb_o(mem_wstrb),
      .mem_wresp_i(mem_wresp),
      .mem_re_o(mem_re),
      .mem_raddr_o(mem_raddr),
      .mem_rdata_i(mem_rdata),
      .mem_rresp_i(mem_rresp)
  );

  //============================================================================
  // UART Register Interface
  // Manages configuration registers and provides FIFO access through registers
  //============================================================================

  uart_regif u_regif (
      .arst_ni(arst_ni),
      .clk_i(clk_i),
      .mem_we_i(mem_we),
      .mem_waddr_i(mem_waddr[5:0]),
      .mem_wdata_i(mem_wdata),
      .mem_wstrb_i(mem_wstrb),
      .mem_wresp_o(mem_wresp),
      .mem_re_i(mem_re),
      .mem_raddr_i(mem_raddr[5:0]),
      .mem_rdata_o(mem_rdata),
      .mem_rresp_o(mem_rresp),
      .ctrl_clk_en_o(ctrl_clk_en),
      .tx_fifo_flush_o(tx_fifo_flush),
      .rx_fifo_flush_o(rx_fifo_flush),
      .cfg_parity_en_o(cfg_parity_en),
      .cfg_parity_type_o(cfg_parity_type),
      .cfg_stop_bits_o(cfg_stop_bits),
      .cfg_rx_parity_err_en_o(cfg_rx_parity_err_en_o),
      .cfg_rx_valid_en_o(cfg_rx_valid_en_o),
      .cfg_rx_near_full_en_o(cfg_rx_near_full_en_o),
      .cfg_rx_full_en_o(cfg_rx_full_en_o),
      .cfg_tx_near_full_en_o(cfg_tx_near_full_en_o),
      .cfg_tx_full_en_o(cfg_tx_full_en_o),
      .clk_div_o(clk_div),
      .tx_fifo_count_i(tx_fifo_count),
      .rx_fifo_count_i(rx_fifo_count),
      .tx_fifo_data_o(tx_fifo_data),
      .tx_fifo_data_valid_o(tx_fifo_data_valid),
      .tx_fifo_data_ready_i(tx_fifo_data_ready),
      .rx_fifo_data_i(rx_fifo_data),
      .rx_fifo_data_valid_i(rx_fifo_data_valid),
      .rx_fifo_data_ready_o(rx_fifo_data_ready),
      .access_id_req_o(access_id_req),
      .access_id_req_valid_o(access_id_req_valid),
      .access_id_req_ready_i(access_id_req_ready),
      .access_id_gnt_i(access_id_gnt),
      .access_id_gnt_valid_i(access_id_gnt_valid),
      .access_id_gnt_ready_o(access_id_gnt_ready)
  );

  //============================================================================
  // Access ID FIFO: Stores access-id requests from the register interface
  // and provides grants back with valid/ready handshaking.
  //============================================================================

  fifo #(
      .ELEM_WIDTH(8),
      .FIFO_SIZE (4)
  ) u_access_id_fifo (
      .clk_i(clk_i),
      .arst_ni(arst_ni),
      .elem_in_i(access_id_req),
      .elem_in_valid_i(access_id_req_valid),
      .elem_in_ready_o(access_id_req_ready),
      .elem_out_o(access_id_gnt),
      .elem_out_valid_o(access_id_gnt_valid),
      .elem_out_ready_i(access_id_gnt_ready)
  );

  //============================================================================
  // TX Baud Rate Clock Divider
  // Generates the transmit baud clock from system clock
  //============================================================================

  clk_div #(
      .DIV_WIDTH(32)
  ) u_clk_div_tx (
      .arst_ni(arst_ni),
      .clk_i  (clk_i),
      .div_i  (clk_div),
      .clk_o  (tx_clk)
  );

  //============================================================================
  // RX Oversampling Clock Divider
  // Generates the receive clock at 8x the baud rate for better sampling
  //============================================================================

  clk_div #(
      .DIV_WIDTH(32)
  ) u_clk_div_rx (
      .arst_ni(arst_ni),
      .clk_i  (clk_i),
      .div_i  ((clk_div >> 3)),  // Divide by 8 for 8x oversampling
      .clk_o  (rx_clk)
  );

  //============================================================================
  // TX CDC FIFO
  // Clock domain crossing from system clock to TX baud clock
  //============================================================================

  cdc_fifo #(
      .ELEM_WIDTH(8),
      .FIFO_SIZE (TX_FIFO_SIZE)
  ) u_tx_fifo (
      .arst_ni(arst_ni & ~tx_fifo_flush),
      .elem_in_i(tx_fifo_data),
      .elem_in_clk_i(clk_i),
      .elem_in_valid_i(tx_fifo_data_valid),
      .elem_in_ready_o(tx_fifo_data_ready),
      .elem_in_count_o(tx_fifo_count_temp),
      .elem_out_o(tx_data),
      .elem_out_clk_i(tx_clk),
      .elem_out_valid_o(tx_data_valid),
      .elem_out_ready_i(tx_data_ready),
      .elem_out_count_o()
  );

  //============================================================================
  // RX CDC FIFO
  // Clock domain crossing from RX oversample clock to system clock
  //============================================================================

  cdc_fifo #(
      .ELEM_WIDTH(8),
      .FIFO_SIZE (RX_FIFO_SIZE)
  ) u_rx_fifo (
      .arst_ni(arst_ni & ~rx_fifo_flush),
      .elem_in_i(rx_data),
      .elem_in_clk_i(rx_clk),
      .elem_in_valid_i(rx_data_valid),
      .elem_in_ready_o(),
      .elem_in_count_o(),
      .elem_out_o(rx_fifo_data),
      .elem_out_clk_i(clk_i),
      .elem_out_valid_o(rx_fifo_data_valid),
      .elem_out_ready_i(rx_fifo_data_ready),
      .elem_out_count_o(rx_fifo_count_temp)
  );

  //============================================================================
  // Interrupt Generation
  // Generate interrupt when RX data is available and interrupt is enabled
  //============================================================================

  assign irq_o[5] = cfg_rx_parity_err_en_o && int_parity_err_o;
  assign irq_o[4] = cfg_rx_valid_en_o && rx_fifo_data_valid;
  assign irq_o[3] = cfg_rx_near_full_en_o && (rx_fifo_count_temp > (RX_FIFO_SIZE / 2));
  assign irq_o[2] = cfg_rx_full_en_o && (rx_fifo_count_temp == RX_FIFO_SIZE);
  assign irq_o[1] = cfg_tx_near_full_en_o && (tx_fifo_count_temp > (TX_FIFO_SIZE / 2));
  assign irq_o[0] = cfg_tx_full_en_o && (tx_fifo_count_temp == TX_FIFO_SIZE);

  //============================================================================
  // UART Transmitter
  // Serializes parallel data to UART TX output
  //============================================================================

  uart_tx u_tx (
      .arst_ni(arst_ni),
      .clk_i(tx_clk & ctrl_clk_en),
      .cfg_parity_en_i(cfg_parity_en),
      .cfg_parity_type_i(cfg_parity_type),
      .cfg_stop_bits_i(cfg_stop_bits),
      .tx_data_i(tx_data),
      .tx_data_valid_i(tx_data_valid),
      .tx_data_ready_o(tx_data_ready),
      .tx_o(tx_o)
  );

  //============================================================================
  // UART Receiver
  // Deserializes UART RX input to parallel data
  //============================================================================

  uart_rx u_rx (
      .arst_ni(arst_ni),
      .clk_i(rx_clk & ctrl_clk_en),
      .cfg_parity_en_i(cfg_parity_en),
      .cfg_parity_type_i(cfg_parity_type),
      .cfg_stop_bits_i(cfg_stop_bits),
      .int_parity_err_o(int_parity_err_o),
      .rx_data_o(rx_data),
      .rx_data_valid_o(rx_data_valid),
      .rx_i(rx_i)
  );

endmodule

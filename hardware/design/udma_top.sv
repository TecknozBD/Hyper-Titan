//==============================================================================
//  File        : udma_top.sv
//  Description : Top-level integration of the uDMA subsystem
//  Author      : Amit Sikder
//  Team        : Design Verification / SoC Integration
//  Organization: Tecknoz
//  Date        : January 2026
//  Integrated Peripherals:
//    - I2S   : Audio streaming interface
//    - SDIO  : Secure Digital I/O interface
//    - I2C   : Control and sensor interfaces
//    - QSPI  : High-speed SPI / external flash interface
//    - UART  : Serial communication interface
//
//  Key Features:
//    - APB-based configuration and control interface
//    - Explicit, non-overlapping linear channel mapping (RX / TX / CMD)
//    - Modular peripheral wrapper architecture
//    - Event-driven transfer completion and error signaling
//    - Independent system and peripheral clock domains
//    - DV- and synthesis-friendly integration
//
//  Notes:
//    - TX channels are driven by the uDMA core and consumed by peripherals
//    - RX channels are driven by peripherals and consumed by the uDMA core
//    - Peripheral slot IDs are used only for configuration decoding
//==============================================================================


module udma_top
  import udma_pkg::*;
#(
  parameter APB_ADDR_WIDTH    = 12,
  parameter N_RX_LIN_CHANNELS = 8,
  parameter N_TX_LIN_CHANNELS = 8,
  parameter N_PERIPHS         = 8,
  parameter N_STREAMS         = 4
)(
  input  logic sys_clk_i,
  input  logic per_clk_i,
  input  logic HRESETn,

  // -------------------------------------------------
  // APB (CPU/Master → uDMA control plane)
  // -------------------------------------------------
  input  logic [APB_ADDR_WIDTH-1:0] PADDR,
  input  logic [31:0]               PWDATA,
  input  logic                      PWRITE,
  input  logic                      PSEL,
  input  logic                      PENABLE,
  output logic [31:0]               PRDATA,
  output logic                      PREADY,
  output logic                      PSLVERR,

  // -------------------------------------------------
  // Event fabric
  // -------------------------------------------------
  input  logic        event_valid_i,
  input  logic [7:0]  event_data_i,
  output logic        event_ready_o,
  output logic [3:0]  event_o,

  // -------------------------------------------------
  // PAD connections
  // -------------------------------------------------
  output i2s_pkg::i2s_to_pad_t     i2s_to_pad,
  input  i2s_pkg::pad_to_i2s_t     pad_to_i2s,

  output sdio_pkg::sdio_to_pad_t   sdio_to_pad,
  input  sdio_pkg::pad_to_sdio_t   pad_to_sdio,

  output i2c_pkg::i2c_to_pad_t     i2c_to_pad,
  input  i2c_pkg::pad_to_i2c_t     pad_to_i2c,

  output qspi_pkg::qspi_to_pad_t   qspi_to_pad,
  input  qspi_pkg::pad_to_qspi_t   pad_to_qspi,

  output uart_pkg::uart_to_pad_t   uart_to_pad,
  input  uart_pkg::pad_to_uart_t   pad_to_uart
);

  // =================================================
  // PERIPHERAL SLOT IDS (config bus only)
  // =================================================
  localparam int I2S_ID  = 0;
  localparam int SDIO_ID = 1;
  localparam int I2C_ID  = 2;
  localparam int QSPI_ID = 3;
  localparam int UART_ID = 4;

  // =================================================
  // LINEAR CHANNEL INDEX MAP  (CRITICAL)
  // RX and TX spaces are independent
  // =================================================

  // -------- RX channels (peripheral → uDMA)
  localparam int I2S_RX_CH   = 0;
  localparam int SDIO_RX_CH  = 1;
  localparam int I2C_RX_CH   = 2;
  localparam int QSPI_RX_CH  = 3;
  localparam int UART_RX_CH  = 4;

  // -------- TX channels (uDMA → peripheral)
  localparam int I2S_TX_CH   = 0;
  localparam int SDIO_TX_CH  = 1;
  localparam int I2C_TX_CH   = 2;
  localparam int I2C_CMD_CH  = 3;
  localparam int QSPI_TX_CH  = 4;
  localparam int QSPI_CMD_CH = 5;
  localparam int UART_TX_CH  = 6;

  // =================================================
  // uDMA peripheral config bus
  // =================================================
  logic [31:0]                periph_data_to;
  logic [4:0]                 periph_addr;
  logic                       periph_rwn;
  logic [N_PERIPHS-1:0]       periph_valid;
  logic [N_PERIPHS-1:0]       periph_ready;
  logic [N_PERIPHS-1:0][31:0] periph_data_from;

  // =================================================
  // uDMA linear channels
  // =================================================
  UDMA_LIN_CH.rx_in  lin_rx [N_RX_LIN_CHANNELS-1:0]; // driven by peripherals
  UDMA_LIN_CH.tx_out lin_tx [N_TX_LIN_CHANNELS-1:0]; // driven by uDMA

  // =================================================
  // uDMA CORE
  // =================================================
  udma_core i_udma_core (
    .sys_clk_i          (sys_clk_i),
    .per_clk_i          (per_clk_i),
    .dft_cg_enable_i    (1'b0),

    .HRESETn            (HRESETn),
    .PADDR              (PADDR),
    .PWDATA             (PWDATA),
    .PWRITE             (PWRITE),
    .PSEL               (PSEL),
    .PENABLE            (PENABLE),
    .PRDATA             (PRDATA),
    .PREADY             (PREADY),
    .PSLVERR            (PSLVERR),

    .event_valid_i      (event_valid_i),
    .event_data_i       (event_data_i),
    .event_ready_o      (event_ready_o),
    .event_o            (event_o),

    .periph_per_clk_o   (),
    .periph_sys_clk_o   (),

    .periph_data_to_o   (periph_data_to),
    .periph_addr_o      (periph_addr),
    .periph_rwn_o       (periph_rwn),
    .periph_data_from_i (periph_data_from),
    .periph_valid_o     (periph_valid),
    .periph_ready_i     (periph_ready),

    .lin_ch_rx          (lin_rx),
    .lin_ch_tx          (lin_tx),

    // unused
    .rx_l2_req_o        (),
    .rx_l2_gnt_i        (1'b0),
    .rx_l2_addr_o       (),
    .rx_l2_be_o         (),
    .rx_l2_wdata_o      (),
    .tx_l2_req_o        (),
    .tx_l2_gnt_i        (1'b0),
    .tx_l2_addr_o       (),
    .tx_l2_rdata_i      ('0),
    .tx_l2_rvalid_i     (1'b0),
    .str_ch_tx          (),
    .ext_ch_rx          (),
    .ext_ch_tx          ()
  );

  // =================================================
  // I2S (RX + TX)
  // =================================================
  UDMA_LIN_CH.rx_out i2s_rx[0:0];
  UDMA_LIN_CH.tx_in  i2s_tx[0:0];

  assign lin_rx[I2S_RX_CH] = i2s_rx[0];
  assign i2s_tx[0]        = lin_tx[I2S_TX_CH];

  udma_i2s_wrap i_i2s (
    .sys_clk_i    (sys_clk_i),
    .periph_clk_i (per_clk_i),
    .rstn_i       (HRESETn),
    .cfg_data_i   (periph_data_to),
    .cfg_addr_i   (periph_addr),
    .cfg_valid_i  (periph_valid[I2S_ID]),
    .cfg_rwn_i    (periph_rwn),
    .cfg_ready_o  (periph_ready[I2S_ID]),
    .cfg_data_o   (periph_data_from[I2S_ID]),
    .events_o     (),
    .events_i     (event_o),
    .rx_ch        (i2s_rx),
    .tx_ch        (i2s_tx),
    .i2s_to_pad   (i2s_to_pad),
    .pad_to_i2s   (pad_to_i2s)
  );

  // =================================================
  // SDIO (RX + TX)
  // =================================================
  UDMA_LIN_CH.rx_out sdio_rx[0:0];
  UDMA_LIN_CH.tx_in  sdio_tx[0:0];

  assign lin_rx[SDIO_RX_CH] = sdio_rx[0];
  assign sdio_tx[0]        = lin_tx[SDIO_TX_CH];

  udma_sdio_wrap i_sdio (
    .sys_clk_i    (sys_clk_i),
    .periph_clk_i (per_clk_i),
    .rstn_i       (HRESETn),
    .cfg_data_i   (periph_data_to),
    .cfg_addr_i   (periph_addr),
    .cfg_valid_i  (periph_valid[SDIO_ID]),
    .cfg_rwn_i    (periph_rwn),
    .cfg_ready_o  (periph_ready[SDIO_ID]),
    .cfg_data_o   (periph_data_from[SDIO_ID]),
    .events_o     (),
    .events_i     (event_o),
    .rx_ch        (sdio_rx),
    .tx_ch        (sdio_tx),
    .sdio_to_pad  (sdio_to_pad),
    .pad_to_sdio  (pad_to_sdio)
  );

  // =================================================
  // I2C (TX + CMD + RX)
  // =================================================
  UDMA_LIN_CH.rx_out i2c_rx[0:0];
  UDMA_LIN_CH.tx_in  i2c_tx[0:0];
  UDMA_LIN_CH.tx_in  i2c_cmd[0:0];

  assign lin_rx[I2C_RX_CH] = i2c_rx[0];
  assign i2c_tx[0]        = lin_tx[I2C_TX_CH];
  assign i2c_cmd[0]       = lin_tx[I2C_CMD_CH];

  udma_i2c_wrap i_i2c (
    .sys_clk_i    (sys_clk_i),
    .periph_clk_i (per_clk_i),
    .rstn_i       (HRESETn),
    .cfg_data_i   (periph_data_to),
    .cfg_addr_i   (periph_addr),
    .cfg_valid_i  (periph_valid[I2C_ID]),
    .cfg_rwn_i    (periph_rwn),
    .cfg_ready_o  (periph_ready[I2C_ID]),
    .cfg_data_o   (periph_data_from[I2C_ID]),
    .events_o     (),
    .err_o        (),
    .nack_o       (),
    .events_i     (event_o),
    .tx_ch        (i2c_tx),
    .cmd_ch       (i2c_cmd),
    .rx_ch        (i2c_rx),
    .i2c_to_pad   (i2c_to_pad),
    .pad_to_i2c   (pad_to_i2c)
  );

  // =================================================
  // QSPI (TX + CMD + RX)
  // =================================================
  UDMA_LIN_CH.rx_out qspi_rx[0:0];
  UDMA_LIN_CH.tx_in  qspi_tx[0:0];
  UDMA_LIN_CH.tx_in  qspi_cmd[0:0];

  assign lin_rx[QSPI_RX_CH] = qspi_rx[0];
  assign qspi_tx[0]        = lin_tx[QSPI_TX_CH];
  assign qspi_cmd[0]       = lin_tx[QSPI_CMD_CH];

  udma_qspi_wrap i_qspi (
    .sys_clk_i       (sys_clk_i),
    .periph_clk_i    (per_clk_i),
    .rstn_i          (HRESETn),
    .dft_test_mode_i (1'b0),
    .dft_cg_enable_i (1'b0),
    .cfg_data_i      (periph_data_to),
    .cfg_addr_i      (periph_addr),
    .cfg_valid_i     (periph_valid[QSPI_ID]),
    .cfg_rwn_i       (periph_rwn),
    .cfg_ready_o     (periph_ready[QSPI_ID]),
    .cfg_data_o      (periph_data_from[QSPI_ID]),
    .events_o        (),
    .events_i        (event_o),
    .tx_ch           (qspi_tx),
    .cmd_ch          (qspi_cmd),
    .rx_ch           (qspi_rx),
    .qspi_to_pad     (qspi_to_pad),
    .pad_to_qspi     (pad_to_qspi)
  );

  // =================================================
  // UART (RX + TX)
  // =================================================
  UDMA_LIN_CH.rx_out uart_rx[0:0];
  UDMA_LIN_CH.tx_in  uart_tx[0:0];

  assign lin_rx[UART_RX_CH] = uart_rx[0];
  assign uart_tx[0]        = lin_tx[UART_TX_CH];

  udma_uart_wrap i_uart (
    .sys_clk_i    (sys_clk_i),
    .periph_clk_i (per_clk_i),
    .rstn_i       (HRESETn),
    .cfg_data_i   (periph_data_to),
    .cfg_addr_i   (periph_addr),
    .cfg_valid_i  (periph_valid[UART_ID]),
    .cfg_rwn_i    (periph_rwn),
    .cfg_ready_o  (periph_ready[UART_ID]),
    .cfg_data_o   (periph_data_from[UART_ID]),
    .events_o     (),
    .events_i     (event_o),
    .rx_ch        (uart_rx),
    .tx_ch        (uart_tx),
    .uart_to_pad  (uart_to_pad),
    .pad_to_uart  (pad_to_uart)
  );

  // =================================================
  // Tie-off unused peripheral slots
  // =================================================
  genvar i;
  generate
    for (i = 0; i < N_PERIPHS; i++) begin
      if (i > UART_ID) begin
        assign periph_ready[i]     = 1'b1;
        assign periph_data_from[i] = 32'h0;
      end
    end
  endgenerate

endmodule

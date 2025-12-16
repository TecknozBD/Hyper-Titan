// ============================================================================
// UART Register Interface Module
// ============================================================================
// Description:
//   Memory-mapped register interface for UART peripheral control and data
//   transfer. Provides access to control, configuration, status, and FIFO
//   data registers through a simple memory interface.
// ============================================================================

module uart_regif
  import uart_pkg::REG_CTRL_ADDR;
  import uart_pkg::REG_CFG_ADDR;
  import uart_pkg::REG_CLK_DIV_ADDR;
  import uart_pkg::REG_TX_FIFO_STAT_ADDR;
  import uart_pkg::REG_RX_FIFO_STAT_ADDR;
  import uart_pkg::REG_TX_FIFO_DATA_ADDR;
  import uart_pkg::REG_RX_FIFO_DATA_ADDR;
  import uart_pkg::REG_RX_FIFO_PEEK_ADDR;
  import uart_pkg::REG_ACCESS_ID_REQ_ADDR;
  import uart_pkg::REG_ACCESS_ID_GNT_ADDR;
  import uart_pkg::REG_ACCESS_ID_GNT_PEEK_ADDR;
#(
    localparam int ADDR_WIDTH = 6,  // Address bus width (supports up to 64 byte address space)
    localparam int DATA_WIDTH = 32  // Data bus width
) (
    // ========================================================================
    // Global Signals
    // ========================================================================
    input logic arst_ni,  // Active-low asynchronous reset
    input logic clk_i,    // System clock

    // ========================================================================
    // Memory Write Interface
    // ========================================================================
    input  logic                    mem_we_i,     // Write enable
    input  logic [  ADDR_WIDTH-1:0] mem_waddr_i,  // Write address
    input  logic [  DATA_WIDTH-1:0] mem_wdata_i,  // Write data
    input  logic [DATA_WIDTH/8-1:0] mem_wstrb_i,  // Write strobe (byte enables)
    output logic [             1:0] mem_wresp_o,  // Write response (00: OKAY, 10: SLVERR)

    // ========================================================================
    // Memory Read Interface
    // ========================================================================
    input  logic                  mem_re_i,     // Read enable
    input  logic [ADDR_WIDTH-1:0] mem_raddr_i,  // Read address
    output logic [DATA_WIDTH-1:0] mem_rdata_o,  // Read data
    output logic [           1:0] mem_rresp_o,  // Read response (00: OKAY, 10: SLVERR)

    // ========================================================================
    // Control Register (0x00) Outputs
    // ========================================================================
    output logic ctrl_clk_en_o,    // Clock enable for UART
    output logic tx_fifo_flush_o,  // Flush TX FIFO (self-clearing)
    output logic rx_fifo_flush_o,  // Flush RX FIFO (self-clearing)

    // ========================================================================
    // Configuration Register (0x04) Outputs
    // ========================================================================
    output logic cfg_parity_en_o,         // Enable parity checking
    output logic cfg_parity_type_o,       // Parity type (0: Even, 1: Odd)
    output logic cfg_stop_bits_o,         // Stop bits (0: 1 bit, 1: 2 bits)
    output logic cfg_rx_parity_err_en_o,  // RX interrupt enable
    output logic cfg_rx_valid_en_o,       // RX interrupt enable
    output logic cfg_rx_near_full_en_o,   // RX interrupt enable
    output logic cfg_rx_full_en_o,        // RX interrupt enable
    output logic cfg_tx_near_full_en_o,   // RX interrupt enable
    output logic cfg_tx_full_en_o,        // RX interrupt enable

    // ========================================================================
    // Clock Divisor Register (0x08) Output
    // ========================================================================
    output logic [DATA_WIDTH-1:0] clk_div_o,  // Clock divisor for baud rate generation

    // ========================================================================
    // TX FIFO Status Register (0x0C) Input
    // ========================================================================
    input logic [DATA_WIDTH-1:0] tx_fifo_count_i,  // Current TX FIFO occupancy

    // ========================================================================
    // RX FIFO Status Register (0x10) Input
    // ========================================================================
    input logic [DATA_WIDTH-1:0] rx_fifo_count_i,  // Current RX FIFO occupancy

    // ========================================================================
    // TX FIFO Data Register (0x14) Interface
    // ========================================================================
    output logic [7:0] tx_fifo_data_o,        // Data to be transmitted
    output logic       tx_fifo_data_valid_o,  // Data valid signal
    input  logic       tx_fifo_data_ready_i,  // FIFO ready to accept data

    // ========================================================================
    // RX FIFO Data Register (0x18) Interface
    // ========================================================================
    input  logic [7:0] rx_fifo_data_i,        // Received data from FIFO
    input  logic       rx_fifo_data_valid_i,  // Data valid from FIFO
    output logic       rx_fifo_data_ready_o,  // Ready to read data (pop from FIFO)

    // ========================================================================
    // Access ID Request Register (0x20) Interface
    // ========================================================================
    output logic [7:0] access_id_req_o,        // Access ID request value
    output logic       access_id_req_valid_o,  // Request valid (write strobe)
    input  logic       access_id_req_ready_i,  // Request ready (FIFO has space)

    // ========================================================================
    // Access ID Grant Register (0x24) Interface
    // ========================================================================
    input  logic [7:0] access_id_gnt_i,        // Access ID grant value from UART
    input  logic       access_id_gnt_valid_i,  // Grant valid (data available)
    output logic       access_id_gnt_ready_o   // Grant ready (pop from FIFO)

);

  // ==========================================================================
  // Write Logic (Combinational)
  // ==========================================================================
  // Handles write operations to writable registers. Returns OKAY response
  // when write is successful, SLVERR otherwise. Some writes are conditional
  // based on FIFO state or readiness.
  // ==========================================================================
  always_comb begin : write_logic
    mem_wresp_o = 2'b10;  // Default: SLVERR (slave error)
    tx_fifo_data_o = mem_wdata_i[7:0];
    tx_fifo_data_valid_o = 1'b0;
    access_id_req_o = mem_wdata_i[7:0];
    access_id_req_valid_o = 1'b0;

    if (mem_we_i) begin
      case (mem_waddr_i)

        REG_CTRL_ADDR: begin
          // Control register: Always writable
          mem_wresp_o = 2'b00;  // OKAY
        end

        REG_CFG_ADDR: begin
          // Configuration register: Only writable when both FIFOs are empty
          // This prevents changing UART parameters mid-transaction
          if (tx_fifo_count_i == 0 && rx_fifo_count_i == 0) begin
            mem_wresp_o = 2'b00;  // OKAY
          end
        end

        REG_CLK_DIV_ADDR: begin
          // Clock divisor register: Only writable when both FIFOs are empty
          // This prevents baud rate changes during active communication
          if (tx_fifo_count_i == 0 && rx_fifo_count_i == 0) begin
            mem_wresp_o = 2'b00;  // OKAY
          end
        end

        REG_TX_FIFO_DATA_ADDR: begin
          // TX FIFO data register: Only writable when FIFO has space
          if (tx_fifo_data_ready_i) begin
            mem_wresp_o = 2'b00;  // OKAY
            tx_fifo_data_valid_o = 1'b1;  // Assert valid to push data
          end
        end

        REG_ACCESS_ID_REQ_ADDR: begin
          // Access ID request register: write enqueues an access-id request
          // to the UART-side handler when the downstream interface is ready.
          if (access_id_req_ready_i) begin
            mem_wresp_o = 2'b00;
            access_id_req_valid_o = 1'b1;
          end
        end

      endcase
    end
  end

  // ==========================================================================
  // Read Logic (Combinational)
  // ==========================================================================
  // Handles read operations from readable registers. Returns OKAY response
  // when read is successful, SLVERR otherwise. Some reads are conditional
  // based on FIFO data availability.
  // ==========================================================================
  always_comb begin : read_logic
    mem_rresp_o = 2'b10;  // Default: SLVERR (slave error)
    rx_fifo_data_ready_o = 1'b0;
    access_id_gnt_ready_o = 1'b0;
    mem_rdata_o = '0;
    if (mem_re_i) begin
      case (mem_raddr_i)

        REG_CTRL_ADDR: begin
          // Read control register
          mem_rresp_o = 2'b00;  // OKAY
          mem_rdata_o = {'0, rx_fifo_flush_o, tx_fifo_flush_o, ctrl_clk_en_o};
        end



        REG_CFG_ADDR: begin
          // Read configuration register
          mem_rresp_o = 2'b00;  // OKAY
          mem_rdata_o = {
            '0,
            cfg_tx_full_en_o,
            cfg_tx_near_full_en_o,
            cfg_rx_full_en_o,
            cfg_rx_near_full_en_o,
            cfg_rx_valid_en_o,
            cfg_rx_parity_err_en_o,
            cfg_stop_bits_o,
            cfg_parity_type_o,
            cfg_parity_en_o
          };
        end

        REG_CLK_DIV_ADDR: begin
          // Read clock divisor register
          mem_rresp_o = 2'b00;  // OKAY
          mem_rdata_o = {'0, clk_div_o};
        end

        REG_TX_FIFO_STAT_ADDR: begin
          // Read TX FIFO status (occupancy count)
          mem_rresp_o = 2'b00;  // OKAY
          mem_rdata_o = {'0, tx_fifo_count_i};
        end

        REG_RX_FIFO_STAT_ADDR: begin
          // Read RX FIFO status (occupancy count)
          mem_rresp_o = 2'b00;  // OKAY
          mem_rdata_o = {'0, rx_fifo_count_i};
        end

        REG_RX_FIFO_DATA_ADDR: begin
          // Read RX FIFO data (destructive read - pops from FIFO)
          if (rx_fifo_data_valid_i) begin
            mem_rresp_o = 2'b00;  // OKAY
            rx_fifo_data_ready_o = 1'b1;  // Assert ready to pop data
            mem_rdata_o = {'0, rx_fifo_data_i};
          end
        end

        REG_RX_FIFO_PEEK_ADDR: begin
          // Peek RX FIFO data (non-destructive read - does not pop)
          if (rx_fifo_data_valid_i) begin
            mem_rresp_o = 2'b00;  // OKAY
            mem_rdata_o = {'0, rx_fifo_data_i};
          end
        end

        REG_ACCESS_ID_GNT_ADDR: begin
          // Read Access ID grant (destructive): return the granted ID
          // when available and assert ready to consume the grant entry.
          if (access_id_gnt_valid_i) begin
            mem_rresp_o = 2'b00;
            access_id_gnt_ready_o = 1'b1;
            mem_rdata_o = {'0, access_id_gnt_i};
          end
        end

        REG_ACCESS_ID_GNT_PEEK_ADDR: begin
          // Peek Access ID grant (non-destructive): return the next
          // grant value without consuming it (no ready asserted).
          if (access_id_gnt_valid_i) begin
            mem_rresp_o = 2'b00;
            mem_rdata_o = {'0, access_id_gnt_i};
          end
        end

      endcase
    end
  end

  // ==========================================================================
  // Register Update Logic (Sequential)
  // ==========================================================================
  // Updates register values on successful writes. Registers are reset to
  // default values on async reset.
  // ==========================================================================
  always_ff @(posedge clk_i or negedge arst_ni) begin
    if (~arst_ni) begin
      // Reset all registers to default values
      ctrl_clk_en_o          <= '0;
      tx_fifo_flush_o        <= '0;
      rx_fifo_flush_o        <= '0;
      cfg_parity_en_o        <= '0;
      cfg_parity_type_o      <= '0;
      cfg_stop_bits_o        <= '0;
      cfg_rx_parity_err_en_o <= '0;
      cfg_rx_valid_en_o      <= '0;
      cfg_rx_near_full_en_o  <= '0;
      cfg_rx_full_en_o       <= '0;
      cfg_tx_near_full_en_o  <= '0;
      cfg_tx_full_en_o       <= '0;
      clk_div_o              <= 'h28B1;
    end else begin
      // Update registers on successful write (OKAY response)
      if (mem_wresp_o == 0) begin
        unique case (mem_waddr_i)

          REG_CTRL_ADDR: begin
            // Update control register fields
            ctrl_clk_en_o   <= mem_wdata_i[0];  // Bit 0: Clock enable
            tx_fifo_flush_o <= mem_wdata_i[1];  // Bit 1: TX FIFO flush
            rx_fifo_flush_o <= mem_wdata_i[2];  // Bit 2: RX FIFO flush
          end

          REG_CFG_ADDR: begin
            // Update configuration register fields
            cfg_parity_en_o <= mem_wdata_i[0];  // Bit 0: Parity enable
            cfg_parity_type_o <= mem_wdata_i[1];  // Bit 1: Parity type
            cfg_stop_bits_o <= mem_wdata_i[2];  // Bit 2: Stop bits
            cfg_rx_parity_err_en_o <= mem_wdata_i[3];  // Bit 3: RX parity error flag (CONFIG)
            cfg_rx_valid_en_o <= mem_wdata_i[4];  // Bit 4: RX data valid flag (CONFIG)
            cfg_rx_near_full_en_o <= mem_wdata_i[5];  // Bit 5: RX near-full threshold flag (CONFIG)
            cfg_rx_full_en_o <= mem_wdata_i[6];  // Bit 6: RX FIFO full flag (CONFIG)
            cfg_tx_near_full_en_o <= mem_wdata_i[7];  // Bit 7: TX near-full threshold flag (CONFIG)
            cfg_tx_full_en_o <= mem_wdata_i[8];  // Bit 8: TX FIFO full flag (CONFIG)
          end

          REG_CLK_DIV_ADDR: begin
            // Update clock divisor register (full 32-bit value)
            clk_div_o <= mem_wdata_i[DATA_WIDTH-1:0];
          end

          REG_TX_FIFO_DATA_ADDR: begin
            // TX FIFO data write - no register state to update
            // Data is pushed to FIFO via tx_fifo_data_o and tx_fifo_data_valid_o
          end

          REG_ACCESS_ID_REQ_ADDR: begin
            // Access ID write - no register state to update
            // Data is pushed to FIFO via access_id_req_o and access_id_req_valid_o
          end

        endcase
      end
    end
  end

endmodule

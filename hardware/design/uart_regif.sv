// ============================================================================
// UART Register Interface Module
// ============================================================================
// Description:
//   Memory-mapped register interface for UART peripheral control and data
//   transfer. Provides access to control, configuration, status, and FIFO
//   data registers through a simple memory interface.
// ============================================================================

module uart_regif
  import hyper_titan_pkg::REG_OFFSET_UART_CTRL;
  import hyper_titan_pkg::REG_OFFSET_UART_REQ_ID_PUSH;
  import hyper_titan_pkg::REG_OFFSET_UART_GNT_ID_PEEK;
  import hyper_titan_pkg::REG_OFFSET_UART_GNT_ID_POP;
  import hyper_titan_pkg::REG_OFFSET_UART_CFG;
  import hyper_titan_pkg::REG_OFFSET_UART_TX_DATA;
  import hyper_titan_pkg::REG_OFFSET_UART_RX_DATA;
  import hyper_titan_pkg::REG_OFFSET_UART_RX_DATA_PEEK;
  import hyper_titan_pkg::REG_OFFSET_UART_TX_FIFO_COUNT;
  import hyper_titan_pkg::REG_OFFSET_UART_RX_FIFO_COUNT;
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
    // Control Register (0x000) Outputs 
    // ========================================================================
    output logic       UART_CTRL_TX_EN,            // TX_EN (RW)
    output logic       UART_CTRL_TX_FIFO_FLUSH,    // TX_FIFO_FLUSH (RW)
    output logic       UART_CTRL_TX_IRQ_EMPTY,     // TX_IRQ_EMPTY (RW)
    output logic       UART_CTRL_TX_IRQ_NEAR_FULL, // TX_IRQ_NEAR_FULL (RW)
    output logic       UART_CTRL_TX_IRQ_FULL,      // TX_IRQ_FULL (RW)
    output logic       UART_CTRL_RX_EN,            // RX_EN (RW)
    output logic       UART_CTRL_RX_FIFO_FLUSH,    // RX_FIFO_FLUSH (RW)
    output logic       UART_CTRL_RX_IRQ_EMPTY,     // RX_IRQ_EMPTY (RW)
    output logic       UART_CTRL_RX_IRQ_NEAR_FULL, // RX_IRQ_NEAR_FULL (RW)
    output logic       UART_CTRL_RX_IRQ_FULL,      // RX_IRQ_FULL (RW)

    // ========================================================================
    // Configuration Register (0x010) Outputs 
    // ========================================================================
    output logic [19:0] UART_CFG_CLK_DIVIDER,  // CLK_DIVIDER (RW)
    output logic        UART_CFG_PARITY_EN,    // PARITY_EN (RW)
    output logic        UART_CFG_PARITY_TYPE,  // PARITY_TYPE (RW)

    // ========================================================================
    // TX Data Register (0x014) Interface 
    // ========================================================================
    output logic [7:0] UART_TX_DATA_DATA,        // DATA (RW)
    output logic       UART_TX_DATA_VALID,       // Handshake: Data valid
    input  logic       UART_TX_DATA_READY,       // Handshake: TX FIFO ready

    // ========================================================================
    // RX Data Register (0x018) Interface 
    // ========================================================================
    input  logic [7:0] UART_RX_DATA_DATA,        // DATA (RO)
    input  logic       UART_RX_DATA_VALID,       // Handshake: RX FIFO has data
    output logic       UART_RX_DATA_READY,       // Handshake: Ready to read (pop)

    // ========================================================================
    // RX Data Peek Register (0x01C) Interface 
    // ========================================================================
    input logic [7:0] UART_RX_DATA_PEEK_DATA,  // Bits 7:0: DATA (RO)

    // ========================================================================
    // TX FIFO Count Register (0x020) Input 
    // ========================================================================
    input logic [7:0] UART_TX_FIFO_COUNT,  // Bits 7:0: FIFO_COUNT (RO)

    // ========================================================================
    // RX FIFO Count Register (0x024) Input 
    // ========================================================================
    input logic [7:0] UART_RX_FIFO_COUNT,  // Bits 7:0: FIFO_COUNT (RO)

    // ========================================================================
    // Request ID Register (0x004) Interface 
    // ========================================================================
    output logic [31:0] UART_REQ_ID_ID,        // Bits 31:0: ID (RW)
    output logic        UART_REQ_ID_VALID,     // Handshake: Request ID valid
    input  logic        UART_REQ_ID_READY,     // Handshake: Request ID FIFO ready

    // ========================================================================
    // Grant Peek Register (0x008) Interface 
    // ========================================================================
    input logic [31:0] UART_GNT_PEEK_ID,  // Bits 31:0: ID (RO)

    // ========================================================================
    // Grant Pop Register (0x00C) Interface 
    // ========================================================================
    input  logic [31:0] UART_GNT_POP_ID,        // Bits 31:0: ID (RW) - value from FIFO
    input  logic        UART_GNT_POP_VALID,     // Handshake: Grant pop data valid
    output logic        UART_GNT_POP_READY      // Handshake: Ready to pop grant
);

  // ==========================================================================
  // Write Logic (Combinational)
  // ==========================================================================
  always_comb begin : write_logic
    // Default values
    mem_wresp_o = 2'b10;  // Default: SLVERR
    UART_TX_DATA_DATA = 8'b0;
    UART_TX_DATA_VALID = 1'b0;
    UART_REQ_ID_ID = 32'b0;
    UART_REQ_ID_VALID = 1'b0;
    UART_GNT_POP_READY = 1'b0;

    if (mem_we_i) begin
      case (mem_waddr_i)

        REG_OFFSET_UART_CTRL: begin
          // Control register: Always writable
          mem_wresp_o = 2'b00;  // OKAY
        end

        REG_OFFSET_UART_CFG: begin
          // Configuration register: Only writable when both FIFOs are empty
          if (UART_TX_FIFO_COUNT == 0 && UART_RX_FIFO_COUNT == 0) begin
            mem_wresp_o = 2'b00;  // OKAY
          end
        end

        REG_OFFSET_UART_TX_DATA: begin
          // TX FIFO data register: Only writable when FIFO has space
          if (UART_TX_DATA_READY) begin
            mem_wresp_o = 2'b00;  // OKAY
            UART_TX_DATA_DATA = mem_wdata_i[7:0];  // Only bits 7:0 used
            UART_TX_DATA_VALID = 1'b1;  // Assert valid to push data
          end
        end

        REG_OFFSET_UART_REQ_ID_PUSH: begin
          // Request ID register: write enqueues an ID request
          if (UART_REQ_ID_READY) begin
            mem_wresp_o = 2'b00;  // OKAY
            UART_REQ_ID_VALID = 1'b1;
            UART_REQ_ID_ID = mem_wdata_i;
          end
        end

        REG_OFFSET_UART_GNT_ID_POP: begin
          // Grant Pop register: write to pop the granted ID
          if (UART_GNT_POP_VALID) begin
            mem_wresp_o = 2'b00;  // OKAY
            UART_GNT_POP_READY = 1'b1;  // Pop the FIFO
          end
        end

      endcase
    end
  end

  // ==========================================================================
  // Read Logic (Combinational)
  // ==========================================================================
  always_comb begin : read_logic
    mem_rresp_o = 2'b10;  // Default: SLVERR
    UART_RX_DATA_READY = 1'b0;
    mem_rdata_o = '0;

    if (mem_re_i) begin
      case (mem_raddr_i)

        REG_OFFSET_UART_CTRL: begin
          // Read control register
          mem_rresp_o = 2'b00;  // OKAY
          mem_rdata_o = {
            22'b0,
            UART_CTRL_RX_IRQ_FULL,
            UART_CTRL_RX_IRQ_NEAR_FULL,
            UART_CTRL_RX_IRQ_EMPTY,
            UART_CTRL_RX_FIFO_FLUSH,
            UART_CTRL_RX_EN,
            UART_CTRL_TX_IRQ_FULL,
            UART_CTRL_TX_IRQ_NEAR_FULL,
            UART_CTRL_TX_IRQ_EMPTY,
            UART_CTRL_TX_FIFO_FLUSH,
            UART_CTRL_TX_EN
          };
        end

        REG_OFFSET_UART_REQ_ID_PUSH: begin
          // Read request ID register
          mem_rresp_o = 2'b00;  // OKAY
          mem_rdata_o = UART_REQ_ID_ID;
        end

        REG_OFFSET_UART_GNT_ID_PEEK: begin
          // Read grant peek register
          mem_rresp_o = 2'b00;  // OKAY
          mem_rdata_o = UART_GNT_PEEK_ID;
        end

        REG_OFFSET_UART_GNT_ID_POP: begin
          // Read grant pop register
          if (UART_GNT_POP_VALID) begin
            mem_rresp_o = 2'b00;  // OKAY
            mem_rdata_o = UART_GNT_POP_ID;
            UART_GNT_POP_READY = 1'b1;  // Pop when reading
          end
        end

        REG_OFFSET_UART_CFG: begin
          // Read configuration register
          mem_rresp_o = 2'b00;  // OKAY
          mem_rdata_o = {
            10'b0,
            UART_CFG_PARITY_TYPE,
            UART_CFG_PARITY_EN,
            UART_CFG_CLK_DIVIDER
          };
        end

        REG_OFFSET_UART_TX_DATA: begin
          // TX data register is write-only, read returns 0
          mem_rresp_o = 2'b00;  // OKAY
          mem_rdata_o = '0;
        end

        REG_OFFSET_UART_RX_DATA: begin
          // Read RX FIFO data (destructive read - pops from FIFO)
          if (UART_RX_DATA_VALID) begin
            mem_rresp_o = 2'b00;  // OKAY
            mem_rdata_o = {24'b0, UART_RX_DATA_DATA};
            UART_RX_DATA_READY = 1'b1;  // Assert ready to pop data
          end
        end

        REG_OFFSET_UART_RX_DATA_PEEK: begin
          // Peek RX FIFO data (non-destructive read)
          if (UART_RX_DATA_VALID) begin
            mem_rresp_o = 2'b00;  // OKAY
            mem_rdata_o = {24'b0, UART_RX_DATA_PEEK_DATA};
          end
        end

        REG_OFFSET_UART_TX_FIFO_COUNT: begin
          // Read TX FIFO count
          mem_rresp_o = 2'b00;  // OKAY
          mem_rdata_o = {24'b0, UART_TX_FIFO_COUNT};
        end

        REG_OFFSET_UART_RX_FIFO_COUNT: begin
          // Read RX FIFO count
          mem_rresp_o = 2'b00;  // OKAY
          mem_rdata_o = {24'b0, UART_RX_FIFO_COUNT};
        end

      endcase
    end
  end

  // ==========================================================================
  // Register Update Logic (Sequential)
  // ==========================================================================
  always_ff @(posedge clk_i or negedge arst_ni) begin
    if (~arst_ni) begin
      // Reset all registers to default values
      UART_CTRL_TX_EN            <= '0;
      UART_CTRL_TX_FIFO_FLUSH    <= '0;
      UART_CTRL_TX_IRQ_EMPTY     <= '0;
      UART_CTRL_TX_IRQ_NEAR_FULL <= '0;
      UART_CTRL_TX_IRQ_FULL      <= '0;
      UART_CTRL_RX_EN            <= '0;
      UART_CTRL_RX_FIFO_FLUSH    <= '0;
      UART_CTRL_RX_IRQ_EMPTY     <= '0;
      UART_CTRL_RX_IRQ_NEAR_FULL <= '0;
      UART_CTRL_RX_IRQ_FULL      <= '0;
      
      UART_CFG_PARITY_EN         <= '0;
      UART_CFG_PARITY_TYPE       <= '0;
      UART_CFG_CLK_DIVIDER       <= 20'h28B1;  // Default baud rate divider
      
      UART_REQ_ID_ID             <= '0;
    end else begin
      // Update registers on successful write (OKAY response)
      if (mem_wresp_o == 2'b00) begin
        case (mem_waddr_i)

          REG_OFFSET_UART_CTRL: begin
            // Update control register fields
            UART_CTRL_TX_EN            <= mem_wdata_i[0];
            UART_CTRL_TX_FIFO_FLUSH    <= mem_wdata_i[1];
            UART_CTRL_TX_IRQ_EMPTY     <= mem_wdata_i[2];
            UART_CTRL_TX_IRQ_NEAR_FULL <= mem_wdata_i[3];
            UART_CTRL_TX_IRQ_FULL      <= mem_wdata_i[4];
            UART_CTRL_RX_EN            <= mem_wdata_i[5];
            UART_CTRL_RX_FIFO_FLUSH    <= mem_wdata_i[6];
            UART_CTRL_RX_IRQ_EMPTY     <= mem_wdata_i[7];
            UART_CTRL_RX_IRQ_NEAR_FULL <= mem_wdata_i[8];
            UART_CTRL_RX_IRQ_FULL      <= mem_wdata_i[9];
          end

          REG_OFFSET_UART_CFG: begin
            // Update configuration register fields
            UART_CFG_CLK_DIVIDER <= mem_wdata_i[19:0];
            UART_CFG_PARITY_EN   <= mem_wdata_i[20];
            UART_CFG_PARITY_TYPE <= mem_wdata_i[21];
          end

          REG_OFFSET_UART_REQ_ID_PUSH: begin
            // Update request ID register
            UART_REQ_ID_ID <= mem_wdata_i;
          end

        endcase
      end
      
      // Auto-clear flush bits after one cycle
      UART_CTRL_TX_FIFO_FLUSH <= 1'b0;
      UART_CTRL_RX_FIFO_FLUSH <= 1'b0;
    end
  end

endmodule
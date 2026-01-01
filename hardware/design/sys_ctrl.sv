// ============================================================================
// System Control Register Interface Module
// ============================================================================
// Description:
//   Memory-mapped register interface for System Control (SYS_CTRL) peripheral.
//   Base Address: 0x0000_2000
//   Address Range: 0x0000_2000 to 0x0000_2FFF (4KB)
// ============================================================================

module sys_ctrl
  import hyper_titan_pkg::REG_OFFSET_E_CORE_CLK_RST;
  import hyper_titan_pkg::REG_OFFSET_P_CORE_CLK_RST;
  import hyper_titan_pkg::REG_OFFSET_CORE_LINK_CLK_RST;
  import hyper_titan_pkg::REG_OFFSET_SYS_LINK_CLK_RST;
  import hyper_titan_pkg::REG_OFFSET_PERIPH_LINK_CLK_RST;
  import hyper_titan_pkg::REG_OFFSET_BOOT_ADDR_E_CORE;
  import hyper_titan_pkg::REG_OFFSET_BOOT_ADDR_P_CORE;
  import hyper_titan_pkg::REG_OFFSET_BOOT_HARTID_E_CORE;
  import hyper_titan_pkg::REG_OFFSET_BOOT_HARTID_P_CORE;
  import hyper_titan_pkg::REG_OFFSET_PLL_CFG_E_CORE;
  import hyper_titan_pkg::REG_OFFSET_PLL_CFG_P_CORE;
  import hyper_titan_pkg::REG_OFFSET_PLL_CFG_SYS_LINK;
#(
    parameter type         req_t    = logic,
    parameter type         resp_t   = logic,
    parameter logic [63:0] MEM_BASE = '0,
    parameter int          MEM_SIZE = 32
) (
    // ========================================================================
    // Global Signals
    // ========================================================================
    input logic arst_ni,  // Active-low asynchronous reset
    input logic clk_i,    // System clock

    // =======================================================================
    // AXI4-Lite Interface
    // =======================================================================

    input  req_t  req_i,  // AXI4-Lite request input
    output resp_t resp_o, // AXI4-Lite response output

    // ========================================================================
    // E_CORE_CLK_RST Register Outputs
    // ========================================================================
    output logic e_core_clk_en_o,  // Clock enable for efficiency core
    output logic e_core_rst_no,    // Active-low reset for efficiency core

    // ========================================================================
    // P_CORE_CLK_RST Register Outputs
    // ========================================================================
    output logic p_core_clk_en_o,  // Clock enable for performance core
    output logic p_core_rst_no,    // Active-low reset for performance core

    // ========================================================================
    // CORE_LINK_CLK_RST Register Outputs
    // ========================================================================
    output logic       core_link_clk_en_o,  // Clock enable for core link
    output logic       core_link_rst_no,    // Active-low reset for core link
    input  logic [1:0] core_link_clk_src_i, // Clock source selection for core link

    // ========================================================================
    // SYS_LINK_CLK_RST Register Outputs
    // ========================================================================
    output logic sys_link_clk_en_o,  // Clock enable for system link
    output logic sys_link_rst_no,    // Active-low reset for system link

    // ========================================================================
    // PERIPH_LINK_CLK_RST Register Outputs
    // ========================================================================
    output logic periph_link_clk_en_o,  // Clock enable for peripheral link
    output logic periph_link_rst_no,    // Active-low reset for peripheral link

    // ========================================================================
    // BOOT_ADDR_E_CORE Register Output
    // ========================================================================
    output logic [31:0] boot_addr_e_core_o,  // Boot address for E core

    // ========================================================================
    // BOOT_ADDR_P_CORE Register Output
    // ========================================================================
    output logic [31:0] boot_addr_p_core_o,  // Boot address for P core

    // ========================================================================
    // BOOT_HARTID_E_CORE Register Output
    // ========================================================================
    output logic [31:0] boot_hartid_e_core_o,  // HART_ID for E core

    // ========================================================================
    // BOOT_HARTID_P_CORE Register Output
    // ========================================================================
    output logic [31:0] boot_hartid_p_core_o,  // HART_ID for P core

    // ========================================================================
    // PLL_CFG_E_CORE Register Interface
    // ========================================================================
    output logic [ 3:0] pll_ref_div_e_core_o,  // Reference divider for E core PLL
    output logic [11:0] pll_fb_div_e_core_o,   // Feedback divider for E core PLL
    input  logic        pll_locked_e_core_i,   // PLL lock status input

    // ========================================================================
    // PLL_CFG_P_CORE Register Interface
    // ========================================================================
    output logic [ 3:0] pll_ref_div_p_core_o,  // Reference divider for P core PLL
    output logic [11:0] pll_fb_div_p_core_o,   // Feedback divider for P core PLL
    input  logic        pll_locked_p_core_i,   // PLL lock status input

    // ========================================================================
    // PLL_CFG_SYS_LINK Register Interface
    // ========================================================================
    output logic [ 3:0] pll_ref_div_sys_link_o,  // Reference divider for system link PLL
    output logic [11:0] pll_fb_div_sys_link_o,   // Feedback divider for system link PLL
    input  logic        pll_locked_sys_link_i    // PLL lock status input
);

  localparam int ADDR_WIDTH = $bits(req_i.aw.addr);
  localparam int DATA_WIDTH = $bits(req_i.w.data);

  // ========================================================================
  // Memory Write Interface
  // ========================================================================
  logic                    mem_we;
  logic [  ADDR_WIDTH-1:0] mem_waddr;
  logic [  DATA_WIDTH-1:0] mem_wdata;
  logic [DATA_WIDTH/8-1:0] mem_wstrb;
  logic [             1:0] mem_wresp;

  // ========================================================================
  // Memory Read Interface
  // ========================================================================
  logic                    mem_re;
  logic [  ADDR_WIDTH-1:0] mem_raddr;
  logic [  DATA_WIDTH-1:0] mem_rdata;
  logic [             1:0] mem_rresp;

  axil_to_memif #(
      .req_t   (req_t),
      .resp_t  (resp_t),
      .MEM_BASE(MEM_BASE),
      .MEM_SIZE(MEM_SIZE)
  ) u_axil_to_memif (
      .arst_ni    (arst_ni),
      .clk_i      (clk_i),
      .req_i      (req_i),
      .resp_o     (resp_o),
      .mem_we_o   (mem_we),
      .mem_waddr_o(mem_waddr),
      .mem_wdata_o(mem_wdata),
      .mem_wstrb_o(mem_wstrb),
      .mem_wresp_i(mem_wresp),
      .mem_re_o   (mem_re),
      .mem_raddr_o(mem_raddr),
      .mem_rdata_i(mem_rdata),
      .mem_rresp_i(mem_rresp)
  );

  // ==========================================================================
  // Write Logic (Combinational)
  // ==========================================================================
  always_comb begin : write_logic
    mem_wresp = 2'b10;

    if (mem_we) begin
      case (mem_waddr)
        REG_OFFSET_E_CORE_CLK_RST: begin
          // Control register: Always writable
          mem_wresp = 2'b00;  // OKAY
        end

        REG_OFFSET_P_CORE_CLK_RST: begin
          // Control register: Always writable
          mem_wresp = 2'b00;  // OKAY
        end

        REG_OFFSET_CORE_LINK_CLK_RST: begin
          // Control register: Always writable
          mem_wresp = 2'b00;  // OKAY
        end

        REG_OFFSET_SYS_LINK_CLK_RST: begin
          // Control register: Always writable
          mem_wresp = 2'b00;  // OKAY
        end

        REG_OFFSET_PERIPH_LINK_CLK_RST: begin
          // Control register: Always writable
          mem_wresp = 2'b00;  // OKAY
        end

        REG_OFFSET_BOOT_ADDR_E_CORE: begin
          // Boot address register: Always writable
          mem_wresp = 2'b00;  // OKAY
        end

        REG_OFFSET_BOOT_ADDR_P_CORE: begin
          // Boot address register: Always writable
          mem_wresp = 2'b00;  // OKAY
        end

        REG_OFFSET_BOOT_HARTID_E_CORE: begin
          // HART_ID register: Always writable
          mem_wresp = 2'b00;  // OKAY
        end

        REG_OFFSET_BOOT_HARTID_P_CORE: begin
          // HART_ID register: Always writable
          mem_wresp = 2'b00;  // OKAY
        end

        REG_OFFSET_PLL_CFG_E_CORE: begin
          // PLL configuration register: Always writable (except RO bit 16)
          mem_wresp = 2'b00;  // OKAY
        end

        REG_OFFSET_PLL_CFG_P_CORE: begin
          // PLL configuration register: Always writable (except RO bit 16)
          mem_wresp = 2'b00;  // OKAY
        end

        REG_OFFSET_PLL_CFG_SYS_LINK: begin
          // PLL configuration register: Always writable (except RO bit 16)
          mem_wresp = 2'b00;  // OKAY
        end

        default: begin
          // Unmapped address space
          mem_wresp = 2'b10;  // SLVERR
        end
      endcase
    end
  end

  // ==========================================================================
  // Read Logic (Combinational)
  // ==========================================================================
  always_comb begin : read_logic
    mem_rresp = 2'b10;
    mem_rdata = 32'h0;

    if (mem_re) begin
      case (mem_raddr)
        REG_OFFSET_E_CORE_CLK_RST: begin
          // Read control register 
          mem_rresp = 2'b00;  // OKAY
          mem_rdata = {30'b0, e_core_rst_no, e_core_clk_en_o};
        end

        REG_OFFSET_P_CORE_CLK_RST: begin
          // Read control register
          mem_rresp = 2'b00;  // OKAY
          mem_rdata = {30'b0, p_core_rst_no, p_core_clk_en_o};
        end

        REG_OFFSET_CORE_LINK_CLK_RST: begin
          // Read control register
          mem_rresp = 2'b00;  // OKAY
          mem_rdata = {28'b0, core_link_clk_src_i, core_link_rst_no, core_link_clk_en_o};
        end

        REG_OFFSET_SYS_LINK_CLK_RST: begin
          // Read control register
          mem_rresp = 2'b00;  // OKAY
          mem_rdata = {30'b0, sys_link_rst_no, sys_link_clk_en_o};
        end

        REG_OFFSET_PERIPH_LINK_CLK_RST: begin
          // Read control register
          mem_rresp = 2'b00;  // OKAY
          mem_rdata = {30'b0, periph_link_rst_no, periph_link_clk_en_o};
        end

        REG_OFFSET_BOOT_ADDR_E_CORE: begin
          // Read boot address register
          mem_rresp = 2'b00;  // OKAY
          mem_rdata = boot_addr_e_core_o;
        end

        REG_OFFSET_BOOT_ADDR_P_CORE: begin
          // Read boot address register
          mem_rresp = 2'b00;  // OKAY
          mem_rdata = boot_addr_p_core_o;
        end

        REG_OFFSET_BOOT_HARTID_E_CORE: begin
          // Read HART_ID register
          mem_rresp = 2'b00;  // OKAY
          mem_rdata = boot_hartid_e_core_o;
        end

        REG_OFFSET_BOOT_HARTID_P_CORE: begin
          // Read HART_ID register
          mem_rresp = 2'b00;  // OKAY
          mem_rdata = boot_hartid_p_core_o;
        end

        REG_OFFSET_PLL_CFG_E_CORE: begin
          // Read PLL configuration register 
          mem_rresp = 2'b00;  // OKAY
          mem_rdata = {15'b0, pll_locked_e_core_i, pll_fb_div_e_core_o, pll_ref_div_e_core_o};
        end

        REG_OFFSET_PLL_CFG_P_CORE: begin
          // Read PLL configuration register
          mem_rresp = 2'b00;  // OKAY
          mem_rdata = {15'b0, pll_locked_p_core_i, pll_fb_div_p_core_o, pll_ref_div_p_core_o};
        end

        REG_OFFSET_PLL_CFG_SYS_LINK: begin
          // Read PLL configuration register
          mem_rresp = 2'b00;  // OKAY
          mem_rdata = {15'b0, pll_locked_sys_link_i, pll_fb_div_sys_link_o, pll_ref_div_sys_link_o};
        end

        default: begin
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
      e_core_clk_en_o        <= 1'b0;
      e_core_rst_no          <= 1'b0;
      p_core_clk_en_o        <= 1'b0;
      p_core_rst_no          <= 1'b0;
      core_link_clk_en_o     <= 1'b1;
      core_link_rst_no       <= 1'b1;
      sys_link_clk_en_o      <= 1'b1;
      sys_link_rst_no        <= 1'b1;
      periph_link_clk_en_o   <= 1'b1;
      periph_link_rst_no     <= 1'b1;
      boot_addr_e_core_o     <= '0;
      boot_addr_p_core_o     <= '0;
      boot_hartid_e_core_o   <= '0;
      boot_hartid_p_core_o   <= 32'h0000_0001;
      pll_ref_div_e_core_o   <= '0;
      pll_fb_div_e_core_o    <= '0;
      pll_ref_div_p_core_o   <= '0;
      pll_fb_div_p_core_o    <= '0;
      pll_ref_div_sys_link_o <= '0;
      pll_fb_div_sys_link_o  <= '0;
    end else begin
      // Update registers on successful write (OKAY response)
      if (mem_wresp == 2'b00) begin
        unique case (mem_waddr)
          REG_OFFSET_E_CORE_CLK_RST: begin
            e_core_clk_en_o <= mem_wdata[0];
            e_core_rst_no   <= mem_wdata[1];
          end

          REG_OFFSET_P_CORE_CLK_RST: begin
            p_core_clk_en_o <= mem_wdata[0];
            p_core_rst_no   <= mem_wdata[1];
          end

          REG_OFFSET_CORE_LINK_CLK_RST: begin
            core_link_clk_en_o <= mem_wdata[0];
            core_link_rst_no   <= mem_wdata[1];
          end

          REG_OFFSET_SYS_LINK_CLK_RST: begin
            sys_link_clk_en_o <= mem_wdata[0];
            sys_link_rst_no   <= mem_wdata[1];
          end

          REG_OFFSET_PERIPH_LINK_CLK_RST: begin
            periph_link_clk_en_o <= mem_wdata[0];
            periph_link_rst_no   <= mem_wdata[1];
          end

          REG_OFFSET_BOOT_ADDR_E_CORE: begin
            boot_addr_e_core_o <= mem_wdata;
          end

          REG_OFFSET_BOOT_ADDR_P_CORE: begin
            boot_addr_p_core_o <= mem_wdata;
          end

          REG_OFFSET_BOOT_HARTID_E_CORE: begin
            boot_hartid_e_core_o <= mem_wdata;
          end

          REG_OFFSET_BOOT_HARTID_P_CORE: begin
            boot_hartid_p_core_o <= mem_wdata;
          end

          REG_OFFSET_PLL_CFG_E_CORE: begin
            pll_ref_div_e_core_o <= mem_wdata[3:0];
            pll_fb_div_e_core_o  <= mem_wdata[15:4];
          end

          REG_OFFSET_PLL_CFG_P_CORE: begin
            pll_ref_div_p_core_o <= mem_wdata[3:0];
            pll_fb_div_p_core_o  <= mem_wdata[15:4];
          end

          REG_OFFSET_PLL_CFG_SYS_LINK: begin
            pll_ref_div_sys_link_o <= mem_wdata[3:0];
            pll_fb_div_sys_link_o  <= mem_wdata[15:4];
          end
        endcase
      end
    end
  end

endmodule

`timescale 1ns/1ps

module tb_dma_simple;

  import amba_axi_pkg::*;
  import dma_utils_pkg::*;

  // --------------------------------------------------------------------------
  // Clock / Reset
  // --------------------------------------------------------------------------
  logic clk;
  logic rst_n;

  initial clk = 1'b0;
  always #5 clk = ~clk;

  initial begin
    rst_n = 1'b0;
    repeat (10) @(posedge clk);
    rst_n = 1'b1;
  end

  // --------------------------------------------------------------------------
  // Memory map
  // --------------------------------------------------------------------------
  localparam logic [63:0] ROM_BASE = 64'h0000_0000_0900_0000;
  localparam logic [63:0] ROM_END  = 64'h0000_0000_0901_0000;

  localparam logic [63:0] RAM_BASE = 64'h0000_0000_8000_0000;

  // --------------------------------------------------------------------------
  // Types
  // --------------------------------------------------------------------------
  typedef s_axi_mosi_t req_t;
  typedef s_axi_miso_t resp_t;

  // --------------------------------------------------------------------------
  // DUT Ports
  // --------------------------------------------------------------------------
  req_t  mp_req_i;
  resp_t mp_resp_o;

  req_t  sp_req_o;
  resp_t sp_resp_i;

  logic dma_done_o;
  logic dma_error_o;

  // --------------------------------------------------------------------------
  // DUT
  // --------------------------------------------------------------------------
  axi_dma #(
    .CSR_BASE  ('h0000_F000),
    .DMA_ID_VAL(0),
    .mp_req_t  (req_t),
    .mp_resp_t (resp_t),
    .sp_req_t  (req_t),
    .sp_resp_t (resp_t)
  ) dut (
    .clk        (clk),
    .rst_n      (rst_n),

    .mp_req_i   (mp_req_i),
    .mp_resp_o  (mp_resp_o),

    .sp_req_o   (sp_req_o),
    .sp_resp_i  (sp_resp_i),

    .dma_done_o (dma_done_o),
    .dma_error_o(dma_error_o)
  );

  // --------------------------------------------------------------------------
  // mem_ss instance
  // --------------------------------------------------------------------------
  req_t  rom_req;
  resp_t rom_resp;

  req_t  ram_req;
  resp_t ram_resp;

  mem_ss #(
    .req_t  (req_t),
    .resp_t (resp_t)
  ) u_mem_ss (
    .clk_i    (clk),
    .arst_ni  (rst_n),

    .rom_req_i (rom_req),
    .rom_resp_o(rom_resp),

    .ram_req_i (ram_req),
    .ram_resp_o(ram_resp)
  );

  // --------------------------------------------------------------------------
  // Decode helpers
  // --------------------------------------------------------------------------
  function automatic logic is_rom(input logic [63:0] addr);
    return (addr >= ROM_BASE) && (addr < ROM_END);
  endfunction

  function automatic logic is_ram(input logic [63:0] addr);
    return (addr >= RAM_BASE);
  endfunction

  // --------------------------------------------------------------------------
  // Routing (field-by-field, NO struct copies)
  // --------------------------------------------------------------------------
  always_comb begin
    // Defaults
    rom_req.awvalid = 1'b0;
    rom_req.wvalid  = 1'b0;
    rom_req.bready  = 1'b0;
    rom_req.arvalid = 1'b0;
    rom_req.rready  = 1'b0;

    ram_req.awvalid = 1'b0;
    ram_req.wvalid  = 1'b0;
    ram_req.bready  = 1'b0;
    ram_req.arvalid = 1'b0;
    ram_req.rready  = 1'b0;

    // --------------------------
    // Write routing
    // --------------------------
    if (sp_req_o.awvalid) begin
      if (is_rom(sp_req_o.awaddr)) begin
        rom_req.awid    = sp_req_o.awid;
        rom_req.awaddr  = sp_req_o.awaddr;
        rom_req.awlen   = sp_req_o.awlen;
        rom_req.awvalid = sp_req_o.awvalid;

        rom_req.wdata   = sp_req_o.wdata;
        rom_req.wstrb   = sp_req_o.wstrb;
        rom_req.wlast   = sp_req_o.wlast;
        rom_req.wvalid  = sp_req_o.wvalid;

        rom_req.bready  = sp_req_o.bready;

      end else if (is_ram(sp_req_o.awaddr)) begin
        ram_req.awid    = sp_req_o.awid;
        ram_req.awaddr  = sp_req_o.awaddr;
        ram_req.awlen   = sp_req_o.awlen;
        ram_req.awvalid = sp_req_o.awvalid;

        ram_req.wdata   = sp_req_o.wdata;
        ram_req.wstrb   = sp_req_o.wstrb;
        ram_req.wlast   = sp_req_o.wlast;
        ram_req.wvalid  = sp_req_o.wvalid;

        ram_req.bready  = sp_req_o.bready;
      end
    end

    // --------------------------
    // Read routing
    // --------------------------
    if (sp_req_o.arvalid) begin
      if (is_rom(sp_req_o.araddr)) begin
        rom_req.arid    = sp_req_o.arid;
        rom_req.araddr  = sp_req_o.araddr;
        rom_req.arlen   = sp_req_o.arlen;
        rom_req.arvalid = sp_req_o.arvalid;

        rom_req.rready  = sp_req_o.rready;

      end else if (is_ram(sp_req_o.araddr)) begin
        ram_req.arid    = sp_req_o.arid;
        ram_req.araddr  = sp_req_o.araddr;
        ram_req.arlen   = sp_req_o.arlen;
        ram_req.arvalid = sp_req_o.arvalid;

        ram_req.rready  = sp_req_o.rready;
      end
    end

    // --------------------------
    // Response mux
    // --------------------------
    sp_resp_i.awready = rom_resp.awready | ram_resp.awready;
    sp_resp_i.wready  = rom_resp.wready  | ram_resp.wready;
    sp_resp_i.arready = rom_resp.arready | ram_resp.arready;

    sp_resp_i.bvalid  = ram_resp.bvalid | rom_resp.bvalid;
    sp_resp_i.bresp   = (ram_resp.bvalid) ? ram_resp.bresp : rom_resp.bresp;
    sp_resp_i.bid     = (ram_resp.bvalid) ? ram_resp.bid   : rom_resp.bid;
    sp_resp_i.buser   = (ram_resp.bvalid) ? ram_resp.buser : rom_resp.buser;

    sp_resp_i.rvalid  = ram_resp.rvalid | rom_resp.rvalid;
    sp_resp_i.rdata   = (ram_resp.rvalid) ? ram_resp.rdata : rom_resp.rdata;
    sp_resp_i.rresp   = (ram_resp.rvalid) ? ram_resp.rresp : rom_resp.rresp;
    sp_resp_i.rid     = (ram_resp.rvalid) ? ram_resp.rid   : rom_resp.rid;
    sp_resp_i.rlast   = (ram_resp.rvalid) ? ram_resp.rlast : rom_resp.rlast;
    sp_resp_i.ruser   = (ram_resp.rvalid) ? ram_resp.ruser : rom_resp.ruser;
  end

  // --------------------------------------------------------------------------
  // Init
  // --------------------------------------------------------------------------
  task automatic init_all();
    begin
      mp_req_i.awvalid = 1'b0;
      mp_req_i.wvalid  = 1'b0;
      mp_req_i.bready  = 1'b0;
      mp_req_i.arvalid = 1'b0;
      mp_req_i.rready  = 1'b0;

      sp_req_o.awvalid = 1'b0;
      sp_req_o.wvalid  = 1'b0;
      sp_req_o.bready  = 1'b0;
      sp_req_o.arvalid = 1'b0;
      sp_req_o.rready  = 1'b0;
    end
  endtask

  // --------------------------------------------------------------------------
  // Simple RAM write/read tasks (NO enum fields touched)
  // --------------------------------------------------------------------------
  task automatic ram_write64(input logic [63:0] addr, input logic [63:0] data);
    begin
      @(posedge clk);

      sp_req_o.awid    <= '0;
      sp_req_o.awaddr  <= addr;
      sp_req_o.awlen   <= '0;
      sp_req_o.awvalid <= 1'b1;

      sp_req_o.wdata   <= data;
      sp_req_o.wstrb   <= 8'hFF;
      sp_req_o.wlast   <= 1'b1;
      sp_req_o.wvalid  <= 1'b1;

      sp_req_o.bready  <= 1'b1;

      wait (sp_resp_i.awready && sp_resp_i.wready);
      @(posedge clk);

      sp_req_o.awvalid <= 1'b0;
      sp_req_o.wvalid  <= 1'b0;

      wait (sp_resp_i.bvalid);
      @(posedge clk);

      sp_req_o.bready <= 1'b0;

      $display("[%0t] RAM_WRITE addr=0x%08h data=0x%016h", $time, addr[31:0], data);
    end
  endtask

  task automatic ram_read64(input logic [63:0] addr, output logic [63:0] data);
    begin
      @(posedge clk);

      sp_req_o.arid    <= '0;
      sp_req_o.araddr  <= addr;
      sp_req_o.arlen   <= '0;
      sp_req_o.arvalid <= 1'b1;

      sp_req_o.rready  <= 1'b1;

      wait (sp_resp_i.arready);
      @(posedge clk);

      sp_req_o.arvalid <= 1'b0;

      wait (sp_resp_i.rvalid);
      data = sp_resp_i.rdata;

      @(posedge clk);
      sp_req_o.rready <= 1'b0;

      $display("[%0t] RAM_READ  addr=0x%08h data=0x%016h", $time, addr[31:0], data);
    end
  endtask

  // --------------------------------------------------------------------------
  // Main test
  // --------------------------------------------------------------------------
  initial begin
    logic [63:0] wr_data;
    logic [63:0] rd_data;

    init_all();

    wait (rst_n);
    @(posedge clk);

    $display("============================================================");
    $display("TB: RAM write/read same location (NO enum assignments)");
    $display("============================================================");

    wr_data = 64'hDEADBEEF_12345678;

    ram_write64(RAM_BASE, wr_data);
    ram_read64(RAM_BASE, rd_data);

    if (rd_data !== wr_data) begin
      $display("TB FAIL: Expected=0x%016h Got=0x%016h", wr_data, rd_data);
      $finish;
    end

    $display("TB PASS ✅");

    #50;
    $finish;
  end

  // --------------------------------------------------------------------------
  // Dump waves
  // --------------------------------------------------------------------------
  initial begin
    $dumpfile("tb_dma_simple.vcd");
    $dumpvars(0, tb_dma_simple);
  end

endmodule

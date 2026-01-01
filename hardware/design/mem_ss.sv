module mem_ss #(
    parameter type req_t  = logic,
    parameter type resp_t = logic
) (
    input logic clk_i,
    input logic arst_ni,

    input  req_t  rom_req_i,
    output resp_t rom_resp_o,

    input  req_t  ram_req_i,
    output resp_t ram_resp_o
);

  axi_ram #(
      .MEM_BASE    ('h0900_0000),
      .MEM_SIZE    (16),
      .ALLOW_WRITES('0),
      .req_t       (req_t),
      .resp_t      (resp_t)
  ) u_rom (
      .clk_i  (clk_i),
      .arst_ni(arst_ni),
      .req_i  (rom_req_i),
      .resp_o (rom_resp_o)
  );

  axi_ram #(
      .MEM_BASE    ('h8000_0000),
      .MEM_SIZE    (31),
      .ALLOW_WRITES('1),
      .req_t       (req_t),
      .resp_t      (resp_t)
  ) u_ram (
      .clk_i  (clk_i),
      .arst_ni(arst_ni),
      .req_i  (ram_req_i),
      .resp_o (ram_resp_o)
  );

endmodule

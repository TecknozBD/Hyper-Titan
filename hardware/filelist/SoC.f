-sv

-i ${SOC}/include

${AXI}/src/axi_pkg.sv
${SOC}/package/ariane_axi_pkg.sv
${SOC}/package/soc_pkg.sv

${SOC}/source/dual_flop_synchronizer.sv
${SOC}/source/pll.sv
${SOC}/source/clk_mux.sv
${SOC}/source/clk_gate.sv

${SOC}/source/axi_to_simple_if.sv
${SOC}/source/axi_ram.sv

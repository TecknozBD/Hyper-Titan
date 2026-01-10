-sv

-i ${SOC}/include/vip
-i ${APB}/include
-i ${AXI}/include

${APB}/src/apb_pkg.sv
${AXI}/src/axi_pkg.sv
${HYPER_TITAN}/hardware/package/RvvAxiPkg.sv
${HYPER_TITAN}/hardware/package/hyper_titan_pkg.sv

${HYPER_TITAN}/hardware/testbench/ddr3_tb.sv

${HYPER_TITAN}/hardware/testbench/hyper_titan_tb.sv

${HYPER_TITAN}/hardware/testbench/e_core_ss_tb.sv

${HYPER_TITAN}/hardware/testbench/delay_gen_tb.sv

# UDMA Core explicit filelist (submodule)

# packages / defines
${HYPER_TITAN}/submodule/udma_core/rtl/common/udma_pkg.sv
${HYPER_TITAN}/submodule/udma_core/rtl/common/udma_core_defines.svh

# common interfaces and helpers
${HYPER_TITAN}/submodule/udma_core/rtl/common/udma_interfaces.sv
${HYPER_TITAN}/submodule/udma_core/rtl/common/udma_ctrl.sv
${HYPER_TITAN}/submodule/udma_core/rtl/common/udma_dc_fifo.sv
${HYPER_TITAN}/submodule/udma_core/rtl/common/io_generic_fifo.sv
${HYPER_TITAN}/submodule/udma_core/rtl/common/io_tx_fifo.sv
${HYPER_TITAN}/submodule/udma_core/rtl/common/io_tx_fifo_dc.sv
${HYPER_TITAN}/submodule/udma_core/rtl/common/io_tx_fifo_mark.sv
${HYPER_TITAN}/submodule/udma_core/rtl/common/io_shiftreg.sv
${HYPER_TITAN}/submodule/udma_core/rtl/common/io_event_counter.sv
${HYPER_TITAN}/submodule/udma_core/rtl/common/io_clk_gen.sv
${HYPER_TITAN}/submodule/udma_core/rtl/common/udma_clkgen.sv
${HYPER_TITAN}/submodule/udma_core/rtl/common/udma_clk_div_cnt.sv
${HYPER_TITAN}/submodule/udma_core/rtl/common/udma_apb_if.sv

# core units (depend on packages/helpers)
${HYPER_TITAN}/submodule/udma_core/rtl/core/udma_arbiter.sv
${HYPER_TITAN}/submodule/udma_core/rtl/core/udma_ch_addrgen.sv
${HYPER_TITAN}/submodule/udma_core/rtl/core/udma_rx_channels.sv
${HYPER_TITAN}/submodule/udma_core/rtl/core/udma_tx_channels.sv
${HYPER_TITAN}/submodule/udma_core/rtl/core/udma_stream_unit.sv

# top-level core
${HYPER_TITAN}/submodule/udma_core/rtl/core/udma_core.sv
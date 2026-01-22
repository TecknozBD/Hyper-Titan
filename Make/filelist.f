#/home/farhana/Farhana/Tecknoz/work/Hyper-Titan/Make

#+incdir+${AXI}/include
#+incdir+${COMMON_CELLS}/include

${AXI}/src/axi_pkg.sv
${SOC}/package/ariane_axi_pkg.sv
../submodule/SoC/package/soc_pkg.sv
../submodule/common_cells/src/stream_register.sv
${COMMON_CELLS}/src/cf_math_pkg.sv
#${REPO_ROOT}/submodule/axi/include/axi/assign.svh
#${REPO_ROOT}/submodule/SoC/include/axi/assign.svh

../submodule/axi/include/axi/typedef.svh
${AXI}/src/axi_intf.sv

${AXI}/src/axi_burst_unwrap.sv
${AXI}/src/axi_bus_compare.sv
${AXI}/src/axi_cdc_dst.sv
${AXI}/src/axi_cdc_src.sv
${AXI}/src/axi_cut.sv
${AXI}/src/axi_delayer.sv
${AXI}/src/axi_demux_simple.sv
${AXI}/src/axi_dw_downsizer.sv
${AXI}/src/axi_dw_upsizer.sv
${AXI}/src/axi_fifo.sv
${AXI}/src/axi_fifo_delay_dyn.sv
${AXI}/src/axi_id_remap.sv
${AXI}/src/axi_id_prepend.sv
${AXI}/src/axi_inval_filter.sv
${AXI}/src/axi_isolate.sv
${AXI}/src/axi_join.sv
${AXI}/src/axi_lite_demux.sv
${AXI}/src/axi_lite_dw_converter.sv
${AXI}/src/axi_lite_from_mem.sv
${AXI}/src/axi_lite_join.sv
${AXI}/src/axi_lite_lfsr.sv
${AXI}/src/axi_lite_mailbox.sv
${AXI}/src/axi_lite_mux.sv
${AXI}/src/axi_lite_regs.sv
${AXI}/src/axi_lite_to_apb.sv
${AXI}/src/axi_lite_to_axi.sv
${AXI}/src/axi_modify_address.sv
${AXI}/src/axi_mux.sv
${AXI}/src/axi_rw_join.sv
${AXI}/src/axi_rw_split.sv
${AXI}/src/axi_serializer.sv
${AXI}/src/axi_slave_compare.sv
${AXI}/src/axi_throttle.sv
${AXI}/src/axi_to_detailed_mem.sv

${AXI}/src/axi_cdc.sv
${AXI}/src/axi_demux.sv
#../submodule/ariane.sv
${AXI}/src/axi_err_slv.sv
${AXI}/src/axi_dw_converter.sv
${AXI}/src/axi_from_mem.sv
${AXI}/src/axi_id_serialize.sv
${AXI}/src/axi_lfsr.sv
${AXI}/src/axi_multicut.sv
#${REPO_ROOT}/submodule/axi/include/axi/assign.svh
${AXI}/src/axi_to_axi_lite.sv
${AXI}/src/axi_to_mem.sv
${AXI}/src/axi_zero_mem.sv
${AXI}/src/axi_interleaved_xbar.sv
${AXI}/src/axi_iw_converter.sv
${AXI}/src/axi_lite_xbar.sv
#${HYPER_TITAN}/hardware/design/axi_xbar_unmuxed.sv
${AXI}/src/axi_to_mem_banked.sv
${AXI}/src/axi_to_mem_interleaved.sv
${AXI}/src/axi_to_mem_split.sv
${AXI}/src/axi_xbar.sv
${AXI}/src/axi_xp.sv



# AXI DMA RTL files
${SUBMODULE}/AXI-DMA/rtl/amba_axi_pkg.sv
#${SUBMODULE}/AXI-DMA/rtl/dma_pkg.svh
${SUBMODULE}/AXI-DMA/rtl/dma_utils_pkg.sv
${SUBMODULE}/AXI-DMA/rtl/rggen_rtl_macros.vh
#${SUBMODULE}/csr_dma.h

#${SUBMODULE}/AXI-DMA/rtl/tb_axi_dma.sv
${SUBMODULE}/AXI-DMA/rtl/dma_axi_wrapper.sv
${SUBMODULE}/AXI-DMA/rtl/csr_dma.v
${SUBMODULE}/AXI-DMA/rtl/dma_func_wrapper.sv

${SUBMODULE}/AXI-DMA/rtl/rggen_axi4lite_adapter.v
${SUBMODULE}/AXI-DMA/rtl/rggen_default_register.v
${SUBMODULE}/AXI-DMA/rtl/rggen_bit_field.v
${SUBMODULE}/AXI-DMA/rtl/dma_fsm.sv
${SUBMODULE}/AXI-DMA/rtl/dma_streamer.sv
${SUBMODULE}/AXI-DMA/rtl/dma_axi_if.sv

${SUBMODULE}/AXI-DMA/rtl/dma_fifo.sv
${SUBMODULE}/AXI-DMA/rtl/rggen_axi4lite_skid_buffer.v
${SUBMODULE}/AXI-DMA/rtl/rggen_adapter_common.v
${SUBMODULE}/AXI-DMA/rtl/rggen_register_common.v
${SUBMODULE}/AXI-DMA/rtl/rggen_mux.v
${SUBMODULE}/AXI-DMA/rtl/rggen_address_decoder.v
${SUBMODULE}/AXI-DMA/rtl/rggen_or_reducer.v
${SUBMODULE}/AXI-DMA/rtl/rggen_or_reducer.v

#${HARDWARE}/design/axi_dma.sv


# filelist for DMA simulation


# Your RTL top module
${AXI}/src/axi_burst_splitter.sv
${AXI}/src/axi_atop_filter.sv
${AXI}/src/axi_burst_splitter_gran.sv
../submodule/axi/src/axi_to_axi_lite.sv
$REPO_ROOT/hardware/design/axi_dma.sv
#../submodule/SoC/source/axi_ram.sv
../hardware/design/mem_ss.sv
# testbench 
#$REPO_ROOT/hardware/Testbench/tb_dma_simple.sv

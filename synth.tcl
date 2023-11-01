yosys -import
read_verilog rtl/*.v rtl/library/*.v

hierarchy -check -top cpu -libdir ./rtl


synth_ice40
#synth_xilinx
write_json build/hdl.json
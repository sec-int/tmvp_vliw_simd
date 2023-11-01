# RTL    = $(wildcard rtl/*.v)
RTL       = rtl/config.v \
				rtl/cpu.v
LIBRARIES = $(wildcard rtl/library/*.v)

build:
	iverilog -o computer -g2012 -Wall \
		rtl/tb/cpu_tb.v \
		$(RTL) \
		$(LIBRARIES)

sim: build
	vvp -n computer

clean:
	rm -rf computer *.vcd

view: run
	gtkwave waveform.vcd gtkwave/computer.gtkw

install:
	sudo apt-get update && sudo apt-get install gtkwave iverilog

synth:
	yosys synth.tcl

asm: asm/main.asm
	customasm -p asm/main.asm

pnr:
	nextpnr-ice40 \
		--json build/hdl.json \
		--top cpu \
		--report build/report.json \
		--detailed-timing-report \
		--lp8k \
		--pcf design.pcf \
		--package tq144:4k \
		--asc bitstream.asc
	
.PHONY: build run clean view

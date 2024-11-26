all :clr cmp sim

cmp:
	vcs -full64 -timescale=1ns/1ns +vcs+flush+all +warn=all -sverilog tb.sv

sim:
	./simv

clr:
	find . -type f ! -name 'tb.sv' ! -name 'Makefile' -exec rm -f {} \;
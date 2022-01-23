transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Alexm/Desktop/Snooping {C:/Users/Alexm/Desktop/Snooping/TestBench.v}
vlog -vlog01compat -work work +incdir+C:/Users/Alexm/Desktop/Snooping {C:/Users/Alexm/Desktop/Snooping/Snooping.v}
vlog -vlog01compat -work work +incdir+C:/Users/Alexm/Desktop/Snooping {C:/Users/Alexm/Desktop/Snooping/MaquinasDeEstados.v}


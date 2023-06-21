if [file exists work] {vdel -all}
vlib work
vlog -f compile.f
onbreak {resume}
set NoQuitOnFinish 1
vsim -voptargs="+acc" top +UVM_TESTNAME=switch_test +UVM_VERBOSITY=UVM_HIGH
add wave /top/swh_if/clk
add wave /top/swh_if/rstn
add wave /top/swh_if/vld
add wave /top/swh_if/addr
add wave /top/swh_if/data
add wave /top/swh_if/addr_a
add wave /top/swh_if/data_a
add wave /top/swh_if/addr_b
add wave /top/swh_if/data_b
run -all
coverage report -cvg -detail
#-- Lattice Semiconductor Corporation Ltd.
#-- Map run script generated by Radiant

set ret 0
if {[catch {

sys_set_attribute -gui on -msg {C:/Users/jbowman/Desktop/microP_lab2/fpga/radiant_project/lab2_jb/promote.xml}
msg_load {C:/Users/jbowman/Desktop/microP_lab2/fpga/radiant_project/lab2_jb/promote.xml}
des_set_project_udb -in {microP_lab2_impl_1_syn.udb} -out {microP_lab2_impl_1_map.udb} -milestone map -pm ice40tp
des_set_reference_udb -clean
map_set_option {pdc_file "C:/Users/jbowman/Desktop/microP_lab2/fpga/radiant_project/lab2_jb/source/impl_1/impl_1.pdc"}
# map option
map_set_option { report_symbol_cross_reference false report_signal_cross_reference false   ignore_constraint_errors false}
map_run

} out]} {
   puts $out
   set ret 1
}
exit -force ${ret}

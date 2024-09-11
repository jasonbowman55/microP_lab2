if {[catch {

# define run engine funtion
source [file join {C:/Lattice Radiant} scripts tcl flow run_engine.tcl]
# define global variables
global para
set para(gui_mode) "1"
set para(prj_dir) "C:/Users/spenc/OneDrive/Desktop/microP_lab2/fpga/radiant_project/lab2_jb"
# synthesize IPs
# synthesize VMs
# synthesize top design
::radiant::runengine::run_postsyn [list -a iCE40UP -p iCE40UP5K -t SG48 -sp High-Performance_1.2V -oc Industrial -top -w -o microP_lab2_impl_1_syn.udb microP_lab2_impl_1.vm] [list C:/Users/spenc/OneDrive/Desktop/microP_lab2/fpga/radiant_project/lab2_jb/impl_1/microP_lab2_impl_1.ldc]

} out]} {
   ::radiant::runengine::runtime_log $out
   exit 1
}

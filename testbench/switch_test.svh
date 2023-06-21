`include "uvm_macros.svh"

class switch_test extends uvm_test;

    `uvm_component_utils(switch_test);

    switch_env env;


    function new(string name="", uvm_component parent);
        super.new(name,parent);
    endfunction //new()

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = switch_env::type_id::create("env",this);
        env.set_report_verbosity_level_hier(UVM_DEBUG);
    endfunction


endclass //switch_test extends uvm_test
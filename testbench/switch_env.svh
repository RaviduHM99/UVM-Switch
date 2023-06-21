`include "uvm_macros.svh"

class switch_env extends uvm_env;

    `uvm_component_utils(switch_env)


    switch_driver drv;
    switch_test_seq tst;
    uvm_sequencer #(switch_in, switch_out) seqr;
    switch_monitor mon;
    switch_scoreboard scr;
    switch_coverage cov;

    function new(string name="", uvm_component parent);
        super.new(name, parent);
    endfunction //new()

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        drv = switch_driver::type_id::create("drv", this);
        tst = switch_test_seq::type_id::create("tst", this);
        seqr = new("seqr", this);
        mon = switch_monitor::type_id::create("mon", this);
        scr = switch_scoreboard::type_id::create("scr", this);
        cov = switch_coverage::type_id::create("cov", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        drv.seq_item_port.connect(seqr.seq_item_export);
        mon.SW_in_Tx.connect(scr.score_in_port.analysis_export);
        mon.SW_out_Tx.connect(scr.score_out_port.analysis_export);
        mon.SW_in_Tx.connect(cov.req_p.analysis_export);
        mon.SW_out_Tx.connect(cov.rsp_p.analysis_export);
    endfunction


    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        tst.start(seqr);
        phase.phase_done.set_drain_time(this, 0.5ns);
        phase.drop_objection(this);
    endtask


endclass //switch_env extends uvm
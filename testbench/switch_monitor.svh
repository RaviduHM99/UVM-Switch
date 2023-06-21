class switch_monitor extends uvm_agent;
    
    `uvm_component_utils(switch_monitor)
    virtual interface switch_if vif;

    uvm_analysis_port #(switch_in) SW_in_Tx;
    uvm_analysis_port #(switch_out) SW_out_Tx;
    
    function new(string name="", uvm_component parent);
        super.new(name, parent);
    endfunction //new()

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        vif = switch_pkg::global_swif;
        SW_in_Tx = new("SW_in_Tx", this);
        SW_out_Tx = new("SW_out_Tx", this);
    endfunction

    task run_phase(uvm_phase phase);
        switch_in req = new();
        switch_out rsp = new();
        forever begin
            @(posedge vif.clk);
            #2;
            req.rstn = vif.rstn;
            req.vld = vif.vld;
            req.addr = vif.addr;
            req.data = vif.data;
            rsp.addr_a = vif.addr_a;
            rsp.data_a = vif.data_a;
            rsp.addr_b = vif.addr_b;
            rsp.data_b = vif.data_b;
            SW_in_Tx.write(req);
            SW_out_Tx.write(rsp);
            `uvm_info("Monitor","***********Obtained the REQ & RSP***********", UVM_MEDIUM);
        end 
    endtask
endclass //driver extends uvm_driver #(switch_in, switch_out   )super.new(name, parent)
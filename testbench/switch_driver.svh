class switch_driver extends uvm_driver #(switch_in, switch_out);
    
    `uvm_component_utils(switch_driver)
    virtual interface switch_if vif;
    switch_in req;
    switch_out rsp;
    
    function new(string name="", uvm_component parent);
        super.new(name, parent);
    endfunction //new()

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        vif = switch_pkg::global_swif;
    endfunction

    task run_phase(uvm_phase phase);
        forever begin
            @(negedge vif.clk);
            seq_item_port.try_next_item(req);
            if (req!=null) begin
                seq_item_port.item_done();
                `uvm_info("RUN", $psprintf("Driver Sending %s", req.convert2string()), UVM_DEBUG);
                vif.rstn = req.rstn;
                vif.vld = req.vld;
                vif.addr = req.addr;
                vif.data = req.data;
            end

            @(posedge vif.clk);
            #1;
            rsp = new();
            rsp.addr_a = vif.addr_a;
            rsp.data_a = vif.data_a;
            rsp.addr_b = vif.addr_b;
            rsp.data_b = vif.data_b;
            `uvm_info("run", $psprintf("Driver Receiving %s", rsp.convert2string()), UVM_DEBUG)
            rsp.set_id_info(req);
            seq_item_port.put_response(rsp);
        end 
    endtask
endclass //driver extends uvm_driver #(switch_in, switch_out   )super.new(name, parent)
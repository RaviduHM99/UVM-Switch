class switch_test_seq extends uvm_sequence #(switch_in, switch_out);

    `uvm_object_utils(switch_test_seq)

    switch_in req;
    switch_out rsp;

    function new(string name="");
        super.new(name);
    endfunction //new()
    
    task body();

        req = new();
        start_item(req);
        req.rstn = 1'b0;
        `uvm_info("Test REQ Sequence",{"Sending Transaction: ", req.convert2string()}, UVM_MEDIUM);
        finish_item(req);
        get_response(rsp);
        `uvm_info("Test RSP Sequence",{"Receiving Transaction: ", rsp.convert2string()}, UVM_MEDIUM);

        repeat (10) begin

            req = new();
            start_item(req);
            assert(req.randomize());
            `uvm_info("Test REQ Sequence",{"Sending Transaction: ", req.convert2string()}, UVM_MEDIUM);
            finish_item(req);
            get_response(rsp);
            `uvm_info("Test RSP Sequence",{"Receiving Transaction: ", rsp.convert2string()}, UVM_MEDIUM);

        end

        req = new();
        start_item(req);
        req.rstn = 1'b1;
        req.vld = 1'b1;
        req.addr = 8'hFF;
        req.data = 16'h45BC;
        `uvm_info("Test REQ Sequence",{"Sending Transaction: ", req.convert2string()}, UVM_MEDIUM);
        finish_item(req);
        get_response(rsp);
        `uvm_info("Test RSP Sequence",{"Receiving Transaction: ", rsp.convert2string()}, UVM_MEDIUM);

    endtask
endclass //switch_test_seq extends uvm_sequence


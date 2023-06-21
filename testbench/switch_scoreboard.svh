class switch_scoreboard extends uvm_scoreboard;
    
    `uvm_component_utils(switch_scoreboard)

    uvm_tlm_analysis_fifo   #(switch_in) score_in_port;
    uvm_tlm_analysis_fifo   #(switch_out) score_out_port;

    function new(string name="", uvm_component parent);
        super.new(name, parent);
    endfunction //new()

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        score_in_port = new("score_in_port", this);
        score_out_port = new("score_out_port", this);
    endfunction

    task run_phase(uvm_phase phase); 
        switch_in req;
        switch_out rsp;
        forever begin
            `uvm_info("Scoreboard", "*******Started*******",UVM_MEDIUM);
            score_in_port.get(req);
            score_out_port.get(rsp);
            if (!req.rstn) begin
                if (!{rsp.addr_a, rsp.data_a, rsp.addr_b, rsp.data_b}) begin
                    `uvm_info("Scoreboard", "*******Passed Reset*******", UVM_MEDIUM);
                end else begin
                    `uvm_info("Scoreboard", "*******Failed Reset*******", UVM_MEDIUM);
                end
            end else begin
                if (req.vld) begin
                    if (req.addr >= 0 && req.addr <= switch_pkg::ADDR_DIV) begin
                        if (rsp.addr_a === req.addr && rsp.data_a === req.data) begin
                            `uvm_info("Scoreboard", "*******Passed Test Case A*******", UVM_MEDIUM);
                        end else begin
                            `uvm_info("Scoreboard", "*******Failed Test Case A*******", UVM_MEDIUM);
                        end
                    end else begin
                        if (rsp.addr_b === req.addr && rsp.data_b === req.data) begin
                            `uvm_info("Scoreboard", "*******Passed Test Case B*******", UVM_MEDIUM);
                        end else begin
                            `uvm_info("Scoreboard", "*******Failed Test Case B*******", UVM_MEDIUM);
                        end
                    end 
                end else begin
                    `uvm_info("Scoreboard", "*******Failed Test Case Vld*******",UVM_MEDIUM); 
                end 
            end
            `uvm_info("Scoreboard", "*******Finished*******",UVM_MEDIUM); 
        end

    endtask

endclass //driver extends uvm_driver #(switch_in, switch_out   )super.new(name, parent)
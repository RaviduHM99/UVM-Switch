class switch_coverage extends uvm_agent;

    `uvm_component_utils(switch_coverage)

    uvm_tlm_analysis_fifo #(switch_in)  req_p;
    uvm_tlm_analysis_fifo #(switch_out) rsp_p;

    logic rstn;
    logic vld;
    logic [switch_pkg::ADDR_WIDTH-1:0] addr;
    reg [switch_pkg::ADDR_WIDTH-1:0] addr_a;
    reg [switch_pkg::ADDR_WIDTH-1:0] addr_b;

    covergroup Switch_Input;
        coverpoint rstn;
        coverpoint vld;
        coverpoint addr{
            bins zeros = {0};
            bins ones = {~ADDR_WIDTH'('h0)};
            bins middle = {ADDR_DIV};
            bins addr_a = {[0:ADDR_DIV]};
            bins addr_b = {[ADDR_DIV+1: ~ADDR_WIDTH'('h0)]};
            bins trans_ab = ([0: ADDR_DIV] => [ADDR_DIV+1: ~ADDR_WIDTH'('h0)]);
            bins trans_ba = ([ADDR_DIV+1: ~ADDR_WIDTH'('h0)] => [0: ADDR_DIV]);
        }
        coverpoint addr_a{
            bins zeros = {0};
            bins ones = {~ADDR_WIDTH'('h0)};
            bins middle = {ADDR_DIV};
            bins addr_a = {[0:ADDR_DIV]};
            bins addr_b = {[ADDR_DIV+1: ~ADDR_WIDTH'('h0)]};
        }
        coverpoint addr_b{
            bins zeros = {0};
            bins ones = {~ADDR_WIDTH'('h0)};
            bins middle = {ADDR_DIV};
            bins addr_a = {[0:ADDR_DIV]};
            bins addr_b = {[ADDR_DIV+1: ~ADDR_WIDTH'('h0)]};
        }
    endgroup

    covergroup Switch_Cross;
        rstn_point: coverpoint rstn;
        vld_point: coverpoint vld;
        addr_point: coverpoint addr{
            bins zeros = {0};
            bins ones = {~ADDR_WIDTH'('h0)};
            bins middle = {ADDR_DIV};
        }
        cross_points: cross rstn_point, vld_point, addr_point;
    endgroup


    function new(string name="", uvm_component parent);
        super.new(name, parent);
        Switch_Input = new();
        Switch_Cross = new();
    endfunction //new()

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        req_p = new("req_p", this);
        rsp_p = new("rsp_p", this);
    endfunction

    task run_phase(uvm_phase phase);
        switch_in req;
        switch_out rsp;

        forever begin
            req_p.get(req);
            rsp_p.get(rsp);
            rstn = req.rstn;
            vld = req.vld;
            addr = req.addr;
            addr_a = rsp.addr_a;
            addr_b = rsp.addr_b;
            `uvm_info("COVER", $sformatf("*************Functiona Coverage*************"), UVM_MEDIUM)
            Switch_Input.sample();
            Switch_Cross.sample();
        end
    endtask



endclass //switch_coverage extends uvm_agent   
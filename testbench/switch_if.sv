interface switch_if;

    logic clk;
    logic rstn;
    logic vld;
    logic [switch_pkg::ADDR_WIDTH-1:0] addr;
    logic [switch_pkg::DATA_WIDTH-1:0] data;
    reg [switch_pkg::ADDR_WIDTH-1:0] addr_a;
    reg [switch_pkg::DATA_WIDTH-1:0] data_a;
    reg [switch_pkg::ADDR_WIDTH-1:0] addr_b;
    reg [switch_pkg::DATA_WIDTH-1:0] data_b;

    modport sw_mp (
        input clk,
        input rstn,
        input vld,
        input addr,
        input data,
        output addr_a,
        output data_a,
        output addr_b,
        output data_b
    );

    initial begin : clock_gen
        clk = 0;
        forever #10 clk <= ~clk;
    end : clock_gen



endinterface
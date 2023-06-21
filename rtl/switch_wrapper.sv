module switch_wrapper #(
    parameter ADDR_WIDTH = 8,
    parameter DATA_WIDTH = 16,
    parameter ADDR_DIV = 8'h3F
)(
    switch_if.sw_mp p
);

    switch_sv #(
        .ADDR_WIDTH(ADDR_WIDTH),
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_DIV(ADDR_DIV)
    ) dut_sw (
    .clk(p.clk),
    .rstn(p.rstn),
    .vld(p.vld),
    .addr(p.addr),
    .data(p.data),
    .addr_a(p.addr_a),
    .data_a(p.data_a),
    .addr_b(p.addr_b),
    .data_b(p.data_b)
    ) ;

endmodule
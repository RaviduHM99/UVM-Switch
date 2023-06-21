class switch_out extends uvm_sequence_item;

    `uvm_object_utils(switch_out)

    rand reg [switch_pkg::ADDR_WIDTH-1:0] addr_a;
    rand reg [switch_pkg::DATA_WIDTH-1:0] data_a;
    rand reg [switch_pkg::ADDR_WIDTH-1:0] addr_b;
    rand reg [switch_pkg::DATA_WIDTH-1:0] data_b;

    function new();
        super.new();
    endfunction //new()

    function string convert2string();
        return $psprintf("Address A : %2h Data A : %4h *** Address B : %2h Data B : %4h", addr_a, data_a, addr_b, data_b);
    endfunction

    function void load_data(reg [switch_pkg::ADDR_WIDTH-1:0] a
    , reg [switch_pkg::DATA_WIDTH-1:0] ad
    , reg [switch_pkg::ADDR_WIDTH-1:0] b
    , reg [switch_pkg::DATA_WIDTH-1:0] bd);
        
        addr_a = a;
        data_a = ad;
        addr_b = b;
        data_b = bd;
        
    endfunction
endclass //switch_base_seq_item extends uvm_sequence_item
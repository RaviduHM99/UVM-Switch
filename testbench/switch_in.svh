class switch_in extends uvm_sequence_item;

    `uvm_object_utils(switch_in)

    rand bit rstn;
    rand bit vld;
    rand logic [switch_pkg::ADDR_WIDTH-1:0] addr;
    rand logic [switch_pkg::DATA_WIDTH-1:0] data;

    function new();
        super.new();
    endfunction //new()

    function string convert2string();
        return $psprintf("Reset : %1b VLD : %1b Address : %2h Data : %4h", rstn, vld, addr, data);
    endfunction

    
endclass //switch_in extends uvm_sequence_itemsuper.new();
import uvm_pkg::*;
import switch_pkg::*;

module top;

    switch_if swh_if();
    switch_wrapper DUT(swh_if.sw_mp);

    initial begin
        string test_name;
        switch_pkg::global_swif = swh_if;
        run_test();
    end 
endmodule
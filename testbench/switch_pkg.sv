package switch_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    //global interface
    
    virtual interface switch_if global_swif;

    // parameters
    parameter ADDR_WIDTH = 8;
    parameter DATA_WIDTH = 16;
    parameter ADDR_DIV = 8'h3F;

        // uvm_transactions
    `include "switch_in.svh"
    `include "switch_out.svh"
    `include "switch_test_seq.svh"

    // uvm_subscribers
    `include "switch_scoreboard.svh"
    `include "switch_monitor.svh"
    `include "switch_driver.svh"
    `include "switch_coverage.svh"

    // uvm_environment
    `include "switch_env.svh"

    // uvm_tests
    `include "switch_test.svh"

endpackage
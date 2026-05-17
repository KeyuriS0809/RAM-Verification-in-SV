`include "Package.sv"
import files_pkg :: *; 
`include "Interface.sv"

module Test_Bench_Top;

  logic clock;

  intf intff(clock);
  TEST tst;

  RAM DUT (.clk(intff.clk), .rst(intff.rst), .wr_enb(intff.wr_enb), .wr_addr(intff.wr_addr), .wr_data(intff.wr_data), .rd_enb(intff.rd_enb), .rd_addr(intff.rd_addr), .rd_data(intff.rd_data));

  always #5 clock = ~clock;

  initial begin 
    $dumpfile("dump.vcd"); $dumpvars;
  end

  initial begin

    clock = 1;  

    tst = new(intff);

    if($test$plusargs("sanity_test"))
      tst = sanity_test::new(intff);

    else if($test$plusargs("same_addr_wr"))
      tst = same_addr_wr::new(intff);

    else if($test$plusargs("full_ram_check"))
      tst = full_ram_check::new(intff);

    else if($test$plusargs("walk_0"))
      tst = walk_0::new(intff);

    else if($test$plusargs("walk_1"))
      tst = walk_1::new(intff);

    else
      $error("TEST NOT FOUND ENTER VALID TEST NAME");

    tst.reset();
    tst.run();

    wait(files_pkg::raise_cnt == 0);
    $display($time,, "reset is called from test");
    $finish;
  end

endmodule

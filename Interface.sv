interface intf(input logic clk);
  logic rst;
  logic wr_enb;
  logic [`ADDR_WIDTH-1:0] wr_addr;  
  logic [`DATA_WIDTH-1:0] wr_data;

  logic rd_enb;
  logic [`ADDR_WIDTH-1:0] rd_addr;
  logic [`DATA_WIDTH-1:0] rd_data;

  //   clocking drv_cb @(posedge clk);
  //     default input #1 output #1;
  //  	input 	rd_data;
  //     output  rst;
  //     output  wr_enb, wr_addr, wr_data;
  //     output  rd_enb, rd_addr;
  //   endclocking

  //   clocking mon_cb @(posedge clk);
  //     default input #1 output #1;
  //     input rst;
  //     input wr_enb,wr_addr,wr_data;
  //     input rd_enb, rd_addr, rd_data;
  //   endclocking

  //   modport driver_signals (clocking drv_cb);
  //   modport monitor_signals(clocking mon_cb); 

endinterface

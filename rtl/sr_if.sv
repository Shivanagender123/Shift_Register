interface sr_if (input bit clk);

logic data_in;
logic data_out;
logic enable;
logic reset;

clocking w_dr_cb@(posedge clk);
output data_in;
output reset;
output enable;
endclocking 

clocking w_mon_cb@(posedge clk);
input data_in;
input reset;
input enable;
endclocking 

clocking r_mon_cb@(posedge clk);
input data_out;
endclocking 

modport W_DR_MP (clocking w_dr_cb);
modport W_MON_MP (clocking w_mon_cb);
modport R_MON_MP  (clocking r_mon_cb);

endinterface

module top;
import test_pkg::*;
import uvm_pkg::*;
`include"uvm_macros.svh"
bit clk;
sr_if in(clk);
sr DUT(.data_in(in.data_in),.clk(clk),.enable(in.enable),.reset(in.reset),.data_out(in.data_out));
initial
 begin
	uvm_config_db #(virtual sr_if)::set(null,"*","vif",in);
	run_test("vtest_lib");
end
always #5 clk=~clk;
endmodule

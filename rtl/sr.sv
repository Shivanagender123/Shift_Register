module sr (input data_in,clk,reset,enable,output data_out);
reg [3:0]q;
`define ASSERTIONS
always@(posedge clk)
 begin
  if(reset)
	q<=0;
  else 
     begin
	if(enable)
		q<={q[2:0],data_in};
	else
		q<=q;
     end
end

assign data_out=q[3];
`ifdef ASSERTIONS
property Q0;
@(posedge clk) enable  |=> q[0]==$past(data_in,1);  
endproperty
property Q1;
@(posedge clk) enable && ~$isunknown(q[0])|=> q[1]==$past(q[0],1);  
endproperty
property Q2;
@(posedge clk) enable && ~$isunknown(q[1]) |=> q[2]==$past(q[1],1);  
endproperty
property out1;
@(posedge clk) data_in && enable ##1 enable[->3] |=> data_out;
endproperty
property out0;
@(posedge clk) ~data_in ##0 enable[->4] |=> ~data_out;
endproperty
Q_0: assert property(Q0);
Q_1: assert property(Q1);
Q_2: assert property(Q2);
OUT_1: assert property(out1);
OUT_0 :assert property(out0);
`endif
endmodule	

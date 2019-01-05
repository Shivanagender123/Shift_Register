class scoreboard extends uvm_scoreboard;
`uvm_component_utils(scoreboard);
uvm_tlm_analysis_fifo #(write_xtn)ap1;
uvm_tlm_analysis_fifo #(write_xtn)ap2;
write_xtn xtn1,xtn2;
bit q[$];
bit y;
extern function new(string name="SB",uvm_component parent);
extern task run_phase(uvm_phase);
extern task fun_input(write_xtn x);
extern task fun_check(write_xtn x1);
extern task fun_read();
endclass

function scoreboard::new(string name="SB",uvm_component parent);
super.new(name,parent);
ap1=new("AP_W",this);
ap2=new("AP_R",this);
endfunction

task scoreboard::run_phase(uvm_phase);
	fork
		forever begin 
			ap1.get(xtn1);
			fun_input(xtn1);
			end
		forever begin 
			ap2.get(xtn2);
			fun_check(xtn2);
			end
	join
endtask

task scoreboard::fun_input(write_xtn x);
	if(x.reset)
	begin
	  q.push_front(0);
	  q.push_front(0);
	  q.push_front(0);
	  q.push_front(0);
	end
	else if(x.enable)
		begin
		if(q.size==4)
		q.pop_back;
		q.push_front(x.data_in);
		end
endtask

task scoreboard::fun_check(write_xtn x1);
	write_xtn r;
	fun_read();
	if(y!=x1.data_out)
		$display("WRONG OUPUT");
	else $display("CRCT OUTPUT %d %d",y,x1.data_out);
endtask

task scoreboard::fun_read();
	if(q.size==4)
	y=q[3];
endtask
	



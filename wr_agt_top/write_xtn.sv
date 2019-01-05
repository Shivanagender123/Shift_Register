class write_xtn extends uvm_sequence_item;

`uvm_object_utils(write_xtn)

rand bit data_in;
bit enable=1;
bit reset;
bit data_out;
extern function new(string name="W");
extern function void do_copy(uvm_object rhs);
extern function bit do_compare(uvm_object rhs,uvm_comparer comparer);
extern function void do_print (uvm_printer printer);
endclass

function write_xtn::new(string name="W");

 super.new(name);
endfunction

function void write_xtn::do_copy(uvm_object rhs);

	write_xtn rhs_;
	$cast(rhs_,rhs);
	super.do_copy(rhs);
	this.data_in=rhs_.data_in;
	this.enable=rhs_.enable;
	this.reset=rhs_.reset;
endfunction

function bit write_xtn::do_compare(uvm_object rhs,uvm_comparer comparer);
	write_xtn rhs_;
	$cast(rhs_,rhs);
	return super.do_compare(rhs,comparer) && this.data_in==rhs_.data_in &&this.enable==rhs_.enable && this.reset==rhs_.reset;
endfunction 

function void write_xtn::do_print(uvm_printer printer);
	super.do_print(printer);
	printer.print_field("data_in",data_in,1,UVM_BIN);
	printer.print_field("enable",enable,1,UVM_BIN);
	printer.print_field("data_out",data_out,1,UVM_BIN);
	printer.print_field("reset",reset,1,UVM_BIN);
endfunction

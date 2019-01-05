class w_sequencer extends uvm_sequencer #(write_xtn);

	`uvm_component_utils(w_sequencer);

extern function new(string name="SEQR",uvm_component parent);

endclass

function w_sequencer::new(string name="SEQR",uvm_component parent);

	super.new(name,parent);
endfunction

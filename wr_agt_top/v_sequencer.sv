class v_sequencer extends uvm_sequencer #(uvm_sequence_item);

	`uvm_component_utils(v_sequencer);
	w_sequencer wseqr;
extern function new(string name="V_SEQR",uvm_component parent);

endclass

function v_sequencer::new(string name="V_SEQR",uvm_component parent);

	super.new(name,parent);
endfunction

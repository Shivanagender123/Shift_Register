class v_seqs extends uvm_sequence #(uvm_sequence_item);

	`uvm_object_utils(v_seqs);
	w_sequencer wseqr;
	w_seqs wseq;
	v_sequencer vseqr;
extern function new(string name="V_SEQR");
extern task body;
endclass

function v_seqs::new(string name="V_SEQ");

	super.new(name);
endfunction

task v_seqs::body();
 $cast(vseqr,m_sequencer);
 wseq=w_seqs::type_id::create("WSEQS");
 wseqr=vseqr.wseqr;
 wseq.start(wseqr);
endtask

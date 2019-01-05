class env extends uvm_env;
`uvm_component_utils(env);
w_agent wag;
r_agent rag;
scoreboard sb;
v_sequencer v_seqr;
extern function new(string name="ENV",uvm_component parent);
extern function void build_phase (uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
endclass

function env::new(string name="ENV",uvm_component parent);

	super.new(name,parent);
endfunction

function void env::build_phase(uvm_phase phase);
	super.build_phase(phase);
	wag=w_agent::type_id::create("WRITE_AGENT",this);
	rag=r_agent::type_id::create("read_agent",this);
	sb=scoreboard::type_id::create("SB",this);
	v_seqr=v_sequencer::type_id::create("V_SEQR",this);
endfunction

function void env::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	wag.wmon.wap.connect(sb.ap1.analysis_export);
	rag.rmon.rap.connect(sb.ap2.analysis_export);
	v_seqr.wseqr=wag.wseqr;
endfunction 


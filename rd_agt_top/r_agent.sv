class r_agent extends uvm_agent;

	`uvm_component_utils(r_agent)
	w_sequencer wseqr;
	w_driver wdr;
	r_monitor rmon;
	env_config cfg;
extern function new(string name="R_AGENT",uvm_component parent);
extern function void build_phase (uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
endclass
function r_agent::new(string name="R_AGENT",uvm_component parent);

	super.new(name,parent);
endfunction

function void  r_agent::build_phase(uvm_phase phase);
	if(!uvm_config_db #(env_config) ::get(this,"","env_config",cfg))
		`uvm_fatal("R_AGENT","cant get data");

	uvm_config_db #(r_agent_config) ::set(this,"*","rd_config",cfg.rcfg);
	super.build_phase(phase);
	if(cfg.rcfg.is_active==UVM_ACTIVE)
	begin
	wseqr=w_sequencer::type_id::create("SEQUENCER",this);
	wdr=w_driver::type_id::create("DRIVER",this);
	end
	rmon=r_monitor::type_id::create("MONIToR",this);
endfunction

function void r_agent::connect_phase(uvm_phase phase);
	if(cfg.rcfg.is_active==UVM_ACTIVE)
	wdr.seq_item_port.connect(wseqr.seq_item_export);
endfunction



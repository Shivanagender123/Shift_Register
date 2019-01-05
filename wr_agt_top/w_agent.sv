class w_agent extends uvm_agent;

	`uvm_component_utils(w_agent)
	w_sequencer wseqr;
	w_driver wdr;
	w_monitor wmon;
	env_config cfg;
extern function new(string name="AGENT",uvm_component parent);
extern function void build_phase (uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
endclass
function w_agent::new(string name="AGENT",uvm_component parent);

	super.new(name,parent);
endfunction

function void  w_agent::build_phase(uvm_phase phase);
	if(!uvm_config_db #(env_config) ::get(this,"","env_config",cfg))
		`uvm_fatal("AGENT","cant get data");

	uvm_config_db #(w_agent_config) ::set(this,"*","wr_config",cfg.wcfg);
	super.build_phase(phase);
	if(cfg.wcfg.is_active==UVM_ACTIVE)
	begin
	wseqr=w_sequencer::type_id::create("SEQUENCER",this);
	wdr=w_driver::type_id::create("DRIVER",this);
	end
	wmon=w_monitor::type_id::create("MONIToR",this);
endfunction

function void w_agent::connect_phase(uvm_phase phase);
	if(cfg.wcfg.is_active==UVM_ACTIVE)
	wdr.seq_item_port.connect(wseqr.seq_item_export);
endfunction



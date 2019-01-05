class r_monitor extends uvm_monitor;

	`uvm_component_utils(r_monitor);
	uvm_analysis_port #(write_xtn) rap;
	virtual sr_if.R_MON_MP vif;
	r_agent_config cfg;
	write_xtn xtn;
extern function new(string name="MON",uvm_component parent);
extern function void build_phase (uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase);
extern task collect_data;
endclass

function r_monitor::new(string name="MON",uvm_component parent);

	super.new(name,parent);
	rap=new("R_AP",this);
endfunction

function void  r_monitor::build_phase(uvm_phase phase);
	if(!uvm_config_db #(r_agent_config) ::get(this,"","rd_config",cfg))
		`uvm_fatal("MONITOR","cant get interface");
	super.build_phase(phase);
endfunction

function void r_monitor::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	vif=cfg.vif;
endfunction

task r_monitor::run_phase(uvm_phase);
	collect_data;
endtask

task r_monitor::collect_data();
	forever begin
	@(vif.r_mon_cb);
	xtn=write_xtn::type_id::create("XTN");
	xtn.data_out=vif.r_mon_cb.data_out;
	rap.write(xtn);
	end
endtask

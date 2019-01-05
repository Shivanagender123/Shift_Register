class w_monitor extends uvm_monitor;

	`uvm_component_utils(w_monitor);
	uvm_analysis_port #(write_xtn) wap;
	virtual sr_if.W_MON_MP vif;
	w_agent_config cfg;
	write_xtn xtn;
extern function new(string name="MON",uvm_component parent);
extern function void build_phase (uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase);
extern task collect_data;
endclass

function w_monitor::new(string name="MON",uvm_component parent);

	super.new(name,parent);
	wap=new("AP",this);
endfunction

function void  w_monitor::build_phase(uvm_phase phase);
	if(!uvm_config_db #(w_agent_config) ::get(this,"","wr_config",cfg))
		`uvm_fatal("MONITOR","cant get interface");
	super.build_phase(phase);
endfunction

function void w_monitor::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	vif=cfg.vif;
endfunction

task w_monitor::run_phase(uvm_phase);
	collect_data;
endtask

task w_monitor::collect_data();
	forever begin
	@(vif.w_mon_cb);
	xtn=write_xtn::type_id::create("W_XTN");
	xtn.data_in=vif.w_mon_cb.data_in;
	xtn.reset=vif.w_mon_cb.reset;
	xtn.enable=vif.w_mon_cb.enable;
	wap.write(xtn);
	end
endtask

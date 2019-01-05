class w_driver extends uvm_driver #(write_xtn);

	`uvm_component_utils(w_driver);
	virtual sr_if.W_DR_MP vif;
	w_agent_config cfg;
extern function new(string name="DR",uvm_component parent);
extern function void build_phase (uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern function void start_of_simulation_phase(uvm_phase phase);
extern task run_phase(uvm_phase);
extern task drive(write_xtn xtn);
endclass

function w_driver::new(string name="DR",uvm_component parent);

	super.new(name,parent);
endfunction

function void  w_driver::build_phase(uvm_phase phase);
	if(!uvm_config_db #(w_agent_config) ::get(this,"","wr_config",cfg))
		`uvm_fatal("DRIVER","cant get interface");
	super.build_phase(phase);
endfunction

function void w_driver::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	vif=cfg.vif;
endfunction

function void w_driver::start_of_simulation_phase(uvm_phase phase);
	super.start_of_simulation_phase(phase);
	uvm_top.print_topology;
endfunction

task w_driver::run_phase(uvm_phase);
	forever begin
	seq_item_port.get_next_item(req);
	drive(req);
	seq_item_port.item_done;
	end
endtask

task w_driver::drive(write_xtn xtn);
	@(vif.w_dr_cb);
	vif.w_dr_cb.data_in<=xtn.data_in;
	vif.w_dr_cb.reset<=xtn.reset;
	vif.w_dr_cb.enable<=xtn.enable;
endtask


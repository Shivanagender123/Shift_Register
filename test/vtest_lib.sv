class vtest_lib extends uvm_test;
`uvm_component_utils(vtest_lib)
env e;
v_sequencer v_seqr;
v_seqs v_seq;
env_config cfg;
w_agent_config wcfg;
r_agent_config rcfg;
int has_ragent=1;
int has_wagent=1;
virtual sr_if g;
extern function new(string name ="TEST",uvm_component parent);
extern function void build_phase (uvm_phase);
extern function  void connect_phase(uvm_phase);
extern task run_phase(uvm_phase phase);
endclass

function vtest_lib::new(string name ="TEST",uvm_component parent);
super.new(name,parent);
endfunction
function void vtest_lib::build_phase(uvm_phase phase);
	cfg=env_config::type_id::create("ENV_CFG");
	if(!uvm_config_db #(virtual sr_if)::get(this,"","vif",g))
		`uvm_fatal("TEST","cant get interface from top");
	if(has_wagent)
		begin
		wcfg=w_agent_config::type_id::create("W_CFG");
		wcfg.vif=g;
		wcfg.is_active=UVM_ACTIVE;
		cfg.wcfg=wcfg;
		end
	if(has_ragent)
		begin
		rcfg=r_agent_config::type_id::create("R_CFG");
		rcfg.vif=g;
		rcfg.is_active=UVM_PASSIVE;
		cfg.rcfg=rcfg;
		end
	uvm_config_db#(env_config)::set(this,"*","env_config",cfg);
	super.build_phase(phase);
	e=env::type_id::create("ENV",this);
	v_seq=v_seqs::type_id::create("V_SEQUENCE");
	v_seqr=v_sequencer::type_id::create("V_SEQUENCER",this);
endfunction

function void vtest_lib::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
endfunction

task vtest_lib::run_phase(uvm_phase phase);
	phase.raise_objection(this);
	v_seq.start(e.v_seqr);
	phase.drop_objection(this);
endtask


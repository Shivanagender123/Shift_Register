class env_config extends uvm_object;

	`uvm_object_utils(env_config)

r_agent_config rcfg;
w_agent_config wcfg;
int has_scoreboard;

function new(string name="E_CFG");
super.new(name);
endfunction

endclass

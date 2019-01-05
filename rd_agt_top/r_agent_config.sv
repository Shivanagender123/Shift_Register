class r_agent_config extends uvm_object;
`uvm_object_utils(r_agent_config)

uvm_active_passive_enum is_active=UVM_PASSIVE;
virtual sr_if vif;

function new(string name="R_A_CFG");
super.new(name);
endfunction

endclass

class w_agent_config extends uvm_object;
`uvm_object_utils(w_agent_config)

uvm_active_passive_enum is_active=UVM_ACTIVE;
virtual sr_if vif;

function new(string name="A_CFG");
super.new(name);
endfunction

endclass

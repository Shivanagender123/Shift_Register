class w_seqs extends uvm_sequence #(write_xtn);
`uvm_object_utils(w_seqs)

extern function new(string name="SEQ");
extern task body;
endclass

function w_seqs::new(string name="SEQ");

 super.new(name);
endfunction

task w_seqs::body();
repeat(10)
begin
 req = write_xtn::type_id::create("WRITE");
start_item(req);
req.randomize;
finish_item(req);
end
endtask


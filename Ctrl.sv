// CSE141L
import definitions::*;
// control decoder (combinational, not clocked)
// inputs from instrROM, ALU flags
// outputs to program_counter (fetch unit)
module Ctrl (
  input[8:0] Instruction,	   // machine code
  input FLAG_IN, 
  output logic branch_en,
               flag_write
  );
// jump on right shift that generates a zero
always_comb
begin
  if ((Instruction[8:6] ==  opOTHER) && FLAG_IN)
    branch_en = 1;
  else
    branch_en = 0;

  if (Instruction[8:6] == opCEQ || Instruction[8:6] == opCLT)
    flag_write = 1;
  else 
    flag_write = 0;
end
endmodule
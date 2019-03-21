// Design Name:    basic_proc
// Module Name:    IF 
// Project Name:   CSE141L
// Description:    instruction fetch (pgm ctr) for processor
//
// Revision:  2019.01.27
//
module IF(
  input Init,				    // reset, start, etc.
  input CLK,				    // PC can change on pos. edges only
  input Branch_en,
  input FLAG_IN,
  input [9:0] Target,
  input [1:0] ProgState,
  output logic [9:0] PC = 0,	// program counter
  output logic Halt = 0			  // Done flag
  );
	 
  always_ff @(posedge CLK) begin	            // or just always; always_ff is a linting construct
    if (!Init) begin
      if (Branch_en && FLAG_IN)	begin      // Conditional Jump
        PC <= Target;
        Halt <= 1'b0;
      end
      else if ((PC == 10'b00001_11010) || (PC == 10'b00100_01101)) begin  // temp need to be changed
        PC <= PC + 10'b00000_00001;
        Halt <= 1'b1;
      end
      else begin
         PC <= PC + 10'b00000_00001;
         Halt <= 1'b0;
      end
    end else begin
      if (ProgState == 2'b00) 
        PC <= 10'b00000_00000;
      else if (ProgState == 2'b01)
        PC <= 10'b00001_11011;
      else PC <= 10'b00000_00000;
    end
  end
endmodule

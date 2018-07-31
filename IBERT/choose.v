/*
This Module chooses between PRBS-7 or PRBS-13.
If the input control is 0, PRBS-13 is selected 
and if control is 1, PRBS-7 is selected
*/
module choose(
	input control,
	input clock,
	input reset,
	output reg [12:0] pattern
//	output [12:0] error
);
wire [7:0]rnd;
wire [12:0]rnd1 ;
seven s1(control,clock,reset,rnd);
thirteen tt1(control,clock,reset,rnd1);
always @(*)begin
if(rnd==0)begin
pattern <=rnd1 ;
end
else if(rnd1==0)begin
pattern <=rnd ;
end
end
//error_adder e1(pattern,error);
endmodule

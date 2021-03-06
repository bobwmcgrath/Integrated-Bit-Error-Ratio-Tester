
module test_control(
input control,
input sel,
input reset,
input clock,
input signed [2:0] taps,
input [12:0] normal_input,
output  [12:0] error,
output  reg [12:0] total_error,
output reg [31:0] count
);
wire signed [12:0] corrupted,original,test_pattern;
wire signed [31:0] count1 ;
wire signed [12:0] sum_error;
reg [10:0] flag;

initial begin
	 total_error [12:0] <= 13'b0;
	 count [31:0] <= 0;
	 flag [10:0] <= 0 ;
end

//LFSR l1 (clock,reset,test_pattern);
transmit t1(control,clock,reset,taps,test_pattern);
mux m1(sel,test_pattern,normal_input,original);
error e1 (original,corrupted);
comp c1 (original,corrupted,error,sum_error,count1);
always @(*)begin

if((sum_error==total_error) && flag==1)begin
count = 0;
end


if(control==0)begin
if((sum_error == 13'h00) || (sum_error == 13'h01))
begin
total_error =  total_error+sum_error ;
flag=flag+1;
count = count+8;
end
end

if(control==1)begin
if((sum_error == 13'h00) || (sum_error == 13'h01))
begin
total_error =  total_error+sum_error ;
flag=flag+1;
count = count+13;
end
end

else if(total_error!=13'b0)
begin
total_error = total_error ;
//count = count + 8'd8 ;
end
else begin
total_error =  13'b0;
end
end
endmodule

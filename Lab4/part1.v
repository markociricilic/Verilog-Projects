// Clk == Clock
// Enable == T
// CounterValue == Q

module TFF(Clk, Resetn, T, Q);

	input Clk;
	input Resetn;
	input T;
	
	output reg Q;

	always @(posedge Clk, negedge Resetn)
		begin
			if (~Resetn)
				Q <= 1'b0;
			else
				Q <= Q ^ T;
		end
		
endmodule


module part1(Clock, Enable, Clear_b, CounterValue);

	input Clock;
	input Enable;
	input Clear_b;
	
	output [7:0] CounterValue;
		
	TFF u1(.T(Enable), .Clk(Clock), .Resetn(Clear_b), .Q(CounterValue[0]));
	TFF u2(.T(CounterValue[0] && Enable), .Clk(Clock), .Resetn(Clear_b), .Q(CounterValue[1]));
	TFF u3(.T(CounterValue[1] && CounterValue[0] && Enable), .Clk(Clock), .Resetn(Clear_b), .Q(CounterValue[2]));
	TFF u4(.T(CounterValue[2] && CounterValue[1] && CounterValue[0] && Enable), .Clk(Clock), .Resetn(Clear_b), .Q(CounterValue[3]));
	TFF u5(.T(CounterValue[3] && CounterValue[2] && CounterValue[1] && CounterValue[0] && Enable), .Clk(Clock), .Resetn(Clear_b), .Q(CounterValue[4]));
	TFF u6(.T(CounterValue[4] && CounterValue[3] && CounterValue[2] && CounterValue[1] && CounterValue[0] && Enable), .Clk(Clock), .Resetn(Clear_b), .Q(CounterValue[5]));
	TFF u7(.T(CounterValue[5] && CounterValue[4] && CounterValue[3] && CounterValue[2] && CounterValue[1] && CounterValue[0] && Enable), .Clk(Clock), .Resetn(Clear_b), .Q(CounterValue[6]));
	TFF u8(.T(CounterValue[6] && CounterValue[5] && CounterValue[4] && CounterValue[3] && CounterValue[2] && CounterValue[1] && CounterValue[0] && Enable), .Clk(Clock), .Resetn(Clear_b), .Q(CounterValue[7]));
		
endmodule

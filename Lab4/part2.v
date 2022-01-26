module rateDivider(clk, rst, Speed, out);

	input clk;
	input rst;
	input [1:0] Speed;
	
	output reg [10:0] out;
	reg [10:0] final;
	
	always @(*)
		begin
			if (Speed == 2'b00)
				final <= 11'd0;
			else if (Speed == 2'b01)
				final <= 11'd499;
			else if (Speed == 2'b10)
				final <= 11'd999;
			else if (Speed == 2'b11)
				final <= 11'd1999;
			else 
				final <= 11'd0;
		end
	
	always @(posedge clk)
		begin
			if (rst)
				out <= 0;
			else if (out == 0)
				out <= final;
			else if (out != 0)
				out <= out - 1;
		end

endmodule


module part2(ClockIn, Reset, Speed, CounterValue);

	input ClockIn;
	input Reset;
	input [1:0] Speed;
	
	output reg [3:0] CounterValue;
	
	wire [10:0] w;
	wire Enable;
	
	rateDivider u1(ClockIn, Reset, Speed, w);
	
	assign Enable = (w == 11'b00000000000) ? 1 : 0;
	
	always @(posedge ClockIn)
		begin
			if (Reset == 1'b1)
				CounterValue <= 0;
//			else if (CounterValue == 4'b1111)
//				CounterValue <= 0;
			else if (Enable == 1'b1)
				CounterValue <= CounterValue + 1;
		end

endmodule
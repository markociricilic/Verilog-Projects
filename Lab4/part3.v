module rateDivider(clk, rst, out);

	input clk;
	input rst;
	
	reg [7:0] counter;
	output reg out;


	always @(posedge clk, negedge rst)
		begin
			if (!rst)
				counter <= 8'b11111001;
			else if (counter == 0)
				counter <= 8'b11111001;
			else
				counter <= counter - 1;
		end
		
		assign out = (counter == 0) ? 1 : 0;
	
endmodule


module part3(ClockIn, Resetn, Start, Letter, DotDashOut);

	input ClockIn;
	input Resetn;
	input Start;
	input [2:0] Letter;

	output reg DotDashOut;
	reg [11:0] loadIn;

	wire Enable;
	
	rateDivider u1(ClockIn, Resetn, Enable);

	always @(posedge Start, negedge Resetn)
		begin
				if (!Resetn)
					loadIn <= 0;
				else
				case (Letter)
					3'b000: loadIn = 12'b101110000000; //A
					3'b001: loadIn = 12'b111010101000; //B
					3'b010: loadIn = 12'b111010111010; //C
					3'b011: loadIn = 12'b111010100000; //D
					3'b100: loadIn = 12'b100000000000; //E
					3'b101: loadIn = 12'b101011101000; //F
					3'b110: loadIn = 12'b111011101000; //G
					3'b111: loadIn = 12'b101010100000; //H
					default: loadIn = 12'b000000000000;
				endcase
		end
		
	always @(posedge Enable, negedge Resetn)
		begin
			if (!Resetn)
				DotDashOut <= 0;
			else 
				begin
					DotDashOut <= loadIn[11];
					loadIn <= loadIn << 1;
					loadIn[0] <= loadIn[11];
				end
		end

endmodule
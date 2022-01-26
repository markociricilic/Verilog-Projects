module fullAdder(a, b, c_in, s, c_out);

	input a, b, c_in;
	output s, c_out;

	assign s = c_in^a^b;
	assign c_out = (a & b) | (c_in & a) | (c_in & b);

endmodule


module rippleAdder(a, b, c_in, s, c_out);
	
	input c_in;
	input [3:0] a;
	input [3:0] b;

	output [3:0] s;
	output [3:0] c_out;

	fullAdder bit0(a[0], b[0], c_in, s[0], c_out[0]);

	fullAdder bit1(a[1], b[1], c_out[0], s[1], c_out[1]);

	fullAdder bit2(a[2], b[2], c_out[1], s[2], c_out[2]);

	fullAdder bit3(a[3], b[3], c_out[2], s[3], c_out[3]);

endmodule

module part2(Clock, Reset_b, Data, Function, ALUout);

	input Reset_b;
	input Clock;
	input [3:0] Data;
	input [2:0] Function;
	
	output reg [7:0] ALUout;
	reg [7:0] ALU_2;
	
	wire [3:0] B;
	assign B = ALUout[3:0];

	wire [3:0] sum;
	wire [3:0] carry;
	
	rippleAdder bit0(Data, B, 0, sum, carry);
	
	wire [4:0] add;
	assign add = Data + B;
	
	wire [4:0] multiply;
	assign multiply = Data * B;
	
	always @(*)
		begin
			case(Function[2:0])
				3'b000: ALU_2 = {3'b000, carry[3], sum};
				3'b001: ALU_2 = {3'b000, add};
				3'b010: ALU_2 = {{4{B[3]}}, B};
				3'b011: ALU_2 = {(Data | B) ? 8'b00000001 : 8'b0};
				3'b100: ALU_2 = {((&Data) & (&B)) ? 8'b00000001 : 8'b0};
				3'b101: ALU_2 = {4'b0000,B} << Data;	
				3'b110: ALU_2 = {3'b000, multiply};
				3'b111: ALU_2 = ALUout;
				default: ALU_2 = 8'b00000000;
			endcase
		end

	always @(posedge Clock)
		begin
			if(Reset_b == 1'b0)
			
				ALUout <= 8'b00000000;
			else
				ALUout <= ALU_2;
		end
		
endmodule

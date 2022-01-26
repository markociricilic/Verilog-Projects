module fullAdder(a, b, c_in, s, c_out);

	input a, b, c_in;
	output s, c_out;

	assign s = c_in^a^b;
	assign c_out = (a & b) | (c_in & a) | (c_in & b);

endmodule


module part2(a, b, c_in, s, c_out);
	
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


module part3(A, B, Function, ALUout);

	input [3:0] A;
	input [3:0] B;
	input [2:0] Function;

	output reg [7:0] ALUout;
	
	wire [3:0] sum;
	wire [3:0] carry;
	wire [4:0] add;

	assign add = A + B; 
	
	part2 flamingdonkey(A, B, 0, sum, carry);
	
	always @(*)
	begin
		case (Function [2:0])
			3'b000: ALUout = {3'b000, carry[3], sum};
			3'b001: ALUout = {3'b000, add};
			3'b010: ALUout = {{4{B[3]}}, B};
			3'b011: ALUout = {(A | B) ? 8'b0000001 : 8'b0};
			3'b100: ALUout = {((&A) & (&B)) ? 8'b0000001 : 8'b0};
			3'b101: ALUout = {A, B};
			default: ALUout = 8'b00000000;
		endcase
	end

endmodule
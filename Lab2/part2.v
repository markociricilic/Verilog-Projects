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
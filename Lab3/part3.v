module part3(clock, reset, ParallelLoadn, RotateRight, ASRight, Data_IN, Q);
	
	input clock;
	input reset;
	input ParallelLoadn;
	input RotateRight;
	input ASRight;
	
	input [7:0] Data_IN;
	
	output [7:0] Q;
	
	wire c3;
		
		mux2to1 uberpussy(Q[0], Q[7], ASRight, c3);
		subcircuit q0(.left(Q[1]), .right(Q[7]), .clock(clock), .LoadLeft(RotateRight), .D(Data_IN[0]), .loadn(ParallelLoadn), .reset(reset), .Q(Q[0]));
		subcircuit q1(.left(Q[2]), .right(Q[0]), .clock(clock), .LoadLeft(RotateRight), .D(Data_IN[1]), .loadn(ParallelLoadn), .reset(reset), .Q(Q[1]));
		subcircuit q2(.left(Q[3]), .right(Q[1]), .clock(clock), .LoadLeft(RotateRight), .D(Data_IN[2]), .loadn(ParallelLoadn), .reset(reset), .Q(Q[2]));
		subcircuit q3(.left(Q[4]), .right(Q[2]), .clock(clock), .LoadLeft(RotateRight), .D(Data_IN[3]), .loadn(ParallelLoadn), .reset(reset), .Q(Q[3]));
		subcircuit q4(.left(Q[5]), .right(Q[3]), .clock(clock), .LoadLeft(RotateRight), .D(Data_IN[4]), .loadn(ParallelLoadn), .reset(reset), .Q(Q[4]));
		subcircuit q5(.left(Q[6]), .right(Q[4]), .clock(clock), .LoadLeft(RotateRight), .D(Data_IN[5]), .loadn(ParallelLoadn), .reset(reset), .Q(Q[5]));
		subcircuit q6(.left(Q[7]), .right(Q[5]), .clock(clock), .LoadLeft(RotateRight), .D(Data_IN[6]), .loadn(ParallelLoadn), .reset(reset), .Q(Q[6]));
		subcircuit q7(.left(c3), .right(Q[6]), .clock(clock), .LoadLeft(RotateRight), .D(Data_IN[7]), .loadn(ParallelLoadn), .reset(reset), .Q(Q[7]));

endmodule


module mux2to1(x, y, s, m);
	
	input x, y, s;
	output m;
	
	assign m = (~s & x)|(s & y);
endmodule


module flipflop (d, reset, clock, q);

	input d, reset, clock;
	output reg q;
	
	always @(posedge clock)
	begin 
		if (reset == 1'b1)
			q <= 0;
		else
			q <= d;
	end	
endmodule


module subcircuit (left, right, clock, LoadLeft, D, loadn, reset, Q);

input left, right, clock, LoadLeft, D, loadn, reset;
output Q;

wire c1, c2;

mux2to1 donkey(.x(right), .y(left), .s(LoadLeft), .m(c1));
mux2to1 goat(.x(D), .y(c1), .s(loadn), .m(c2));

flipflop flamingo(.d(c2), .reset(reset), .clock(clock), .q(Q));

endmodule 
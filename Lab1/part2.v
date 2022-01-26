module v7404(pin1, pin3, pin5, pin9, pin11, pin13, pin2, pin4, pin6, pin8, pin10, pin12);

input pin1, pin3, pin5, pin9, pin11, pin13;
output pin2, pin4, pin6, pin8, pin10, pin12;

assign pin2 = ~pin1;
assign pin4 = ~pin3;
assign pin6 = ~pin5;
assign pin8 = ~pin9;
assign pin10 = ~pin11;
assign pin12 = ~pin13;

endmodule

module v7408(pin1, pin3, pin5, pin9, pin11, pin13, pin2, pin4, pin6, pin8, pin10, pin12);

input pin1, pin2, pin4, pin5, pin9, pin10, pin12, pin13;
output pin3, pin6, pin8, pin11;

assign pin3 = pin1 & pin2;
assign pin6 = pin4 & pin5;
assign pin8 = pin9 & pin10;
assign pin11 = pin12 & pin13;

endmodule

module v7432(pin1, pin3, pin5, pin9, pin11, pin13, pin2, pin4, pin6, pin8, pin10, pin12);

input pin1, pin2, pin4, pin5, pin9, pin10, pin12, pin13;
output pin3, pin6, pin8, pin11;

assign pin3 = pin1 | pin2;
assign pin6 = pin4 | pin5;
assign pin8 = pin9 | pin10;
assign pin11 = pin12 | pin13;

endmodule

module mux2to1(x, y, s, m);

wire not_to_and, and_to_or1, and_to_or2;

input x, y, s;
output m;

v7404 not_chip (
	.pin1(s),
	.pin2(not_to_and)
);

v7408 and_chip (
	.pin1(x),
	.pin2(not_to_and),
	.pin3(and_to_or1),
	.pin4(s),
	.pin5(y),
	.pin6(and_to_or2)
	
); 

v7432 or_chip (
	.pin1(and_to_or1),
	.pin2(and_to_or2),
	.pin3(m)
);

endmodule

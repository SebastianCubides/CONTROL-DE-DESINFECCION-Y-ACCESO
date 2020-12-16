module DISPENSADOR(clk,bomba,Sout);

input clk;
//entrada de la salida del sensor
input Sout;
//salida a la bomba de agua
output reg bomba;
//divisor para ajustar el ciclo de trabajo
DIVFREQ div(clk, clk_2);

always @(posedge clk_2)begin

	if(Sout==1)begin
		bomba=1;
	end
	else begin
		bomba = 0;
	end
end
endmodule 
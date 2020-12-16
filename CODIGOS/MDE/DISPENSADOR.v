module DISPENSADOR(clk,bomba,Sout,G,G2);

input clk;
input G;
//entrada de la salida del sensor
input Sout;
//salida a la bomba de agua
output reg bomba;
output reg G2;
//divisor para ajustar el ciclo de trabajo
DIVFREQ div(clk, clk_2);

always @(posedge clk_2)begin
	if(G==1)begin
		if(Sout==0)begin
			bomba=0;
			G2=1;
		end
		else begin
			bomba = 1;
			G2=0;
		end
	end
	else begin
		bomba = 1;
		G2=0;
	end
end
endmodule 
module MDE (clk,SoutG, bomba, SoutA, Alarma, RX, TX, RxData, reset, st);

//Entradas
input SoutG;
input SoutA;
input clk;
input wire RX;
input reset;
//Salidas
reg done;
output wire bomba;
output wire Alarma;
output wire TX;
output [7:0] RxData;
//output [7:0] RxData2;
//Registros
reg D;
reg T;
reg G;
wire G2;
reg LCD;
reg E;
reg A;
reg [2:0]status;
reg rst;
input st;

//INICIALIZACIÓN

UART uartSC(clk,reset,RX,TX,RxData);
//UART uartSC2(clk,reset,RX2,TX2,RxData2);
DISPENSADOR dsp(clk, bomba, SoutG,G,G2);
buzzer bzz(clk,rst,Alarma,A);


//Definición de los estados como parámetros
parameter START = 0, DATA = 1, TEMP = 2, GEL = 3, ALARM = 4, END = 5;	

//M.D.E.
always @(posedge clk)begin

	case(status)
		START: begin
			D = 0;
			T = 0;
			G = 0;
			A = 0;
			LCD = 1;
			rst = 1;
			status = TEMP;
			//if(Data)begin
				//status = DATA;
				//E = 0;
				//reset = 0;
			//end
			//if (SoutA==1)begin
				//status = ALARM;
			//end
		end
		DATA: begin
			D = 1;
			T = 0;
			G = 0;
			A = 0;
			E = 0;
			rst = 1;
			status = TEMP;
			//if (SoutA==1)begin
				//status = ALARM;
			//end
		end
		TEMP: begin
			D = 0;
			T = 1;
			G = 0;
			A = 0;
			rst = 1;
			E = 0;
			if(RxData==2)begin
				status = GEL;
			end
			if(RxData==1)begin
				status = ALARM;
			end
			if (SoutA==0)begin
				status = ALARM;
			end
		end
		GEL: begin
			D = 0;
			T = 0;
			G = 1;
			A = 0;
			E = 0;
			LCD = 4;
			rst = 1;
			if(G2==1)begin
				status = END;
			end
			if (SoutA==0)begin
				status = ALARM;
			end
		end
		ALARM: begin
			D = 0;
			T = 0;
			G = 0;
			A = 1;
			E = 0;
			rst = 1;
			if (st==0)begin
				status = START;
			end
			else begin
				status = ALARM;
			end
		end
		END: begin
			D = 0;
			T = 0;
			G = 0;
			A = 0;
			E = 1;
			LCD = 5;
			rst = 1;
			if (st==0)begin
				status = START;
			end
		end
		default status = START;
	endcase
end
endmodule

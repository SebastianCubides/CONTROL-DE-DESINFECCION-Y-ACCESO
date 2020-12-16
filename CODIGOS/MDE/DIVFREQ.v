module DIVFREQ(clk,clk2h);

input clk;
output reg clk2h;

reg [27:0] count;

always @(posedge clk)begin 
	
	if(count<50_000_000)begin
		
		count = count + 1; 	
		
		end
	
	else begin
	
		clk2h = !clk2h;
		count = 0;
		
		end
end 
endmodule 
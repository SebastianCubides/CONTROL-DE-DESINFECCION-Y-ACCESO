//��ʵ������LCD1602��ʾӢ�ġ���LCD���ֿ⣩
module lcd1602(clk, rs, rw, en,dat,lcdC);  
input clk;
 input [7:0] lcdC;
 output [7:0] dat; 
 output  rs,rw,en; 
 //tri en; 
 reg e; 
 reg [7:0] dat; 
 reg rs;   
 reg  [15:0] counter; 
 reg [4:0] current,next; 
 reg clkr; 
 reg [1:0] cnt; 
 parameter  set0=4'h0; 
 parameter  set1=4'h1; 
 parameter  set2=4'h2; 
 parameter  set3=4'h3; 
 parameter  set4=4'h4; 
 parameter  set5=4'h5; 
 parameter  set6=4'h6; 
 parameter  set7=4'h7;
 
 parameter  dat0=4'h4; 
 parameter  dat1=4'h5; 
 parameter  dat2=4'h6; 
 parameter  dat3=4'h7; 
 parameter  dat4=4'h8; 
 parameter  dat5=4'h9; 

 parameter  dat6=4'hA; 
 parameter  dat7=4'hB; 
 parameter  dat8=4'hC; 
 parameter  dat9=4'hD; 
 parameter  dat10=4'hE; 
 parameter  dat11=5'h10;
 parameter  dat11=5'h11;
 
 parameter  nul=4'hF; 
always @(posedge clk)      
 begin 
  counter=counter+1; 
  if(counter==16'h000f)  
  clkr=~clkr; 
end 
always @(posedge clkr) 
begin 
 
 //Mensaje estado 1
 current=next; 
  case(current) 
    set0:   begin  rs<=0; dat<=8'h0; next<=set1; end 
    set1:   begin  rs<=0; dat<=8'h1; next<=set2; end 
    set2:   begin  rs<=0; dat<=8'h1; next<=set3; end 
    set3:   begin  rs<=0; dat<=8'h2; next<=set4; end 
    set4:   begin  rs<=0; dat<=8'h4; next<=set5; end 
    set5:   begin  rs<=0; dat<=8'h5; next<=set6; end 
    set6:   begin  rs<=0; dat<=8'h6; next<=set7; end 
    set7:   begin  rs<=0; dat<=8'h7; next<=dat0; end
   
    dat0:   begin  rs<=1; dat<="B"; next<=dat1; end 
    dat1:   begin  rs<=1; dat<="I"; next<=dat2; end 
    dat2:   begin  rs<=1; dat<="E"; next<=dat3; end 
    dat3:   begin  rs<=1; dat<="N"; next<=dat4; end 
    dat4:   begin  rs<=1; dat<="V"; next<=dat5; end 
    dat5:   begin  rs<=1; dat<="E"; next<=dat6; end 
    dat6:   begin  rs<=1; dat<="N"; next<=dat7; end 
    dat5:   begin  rs<=1; dat<="I"; next<=dat8; end 
    dat6:   begin  rs<=1; dat<="D"; next<=dat9; end 
    dat7:   begin  rs<=1; dat<="0"; next<=dat10; end 

    dat7:   begin  rs<=1; dat<=8'h3E; next<=dat6; end 
    dat6:   begin  rs<=1; dat<="C"; next<=dat7; end 
    dat7:   begin  rs<=1; dat<="A"; next<=dat8; end 
    dat8:   begin  rs<=1; dat<="R"; next<=dat9; end 
    dat9:   begin  rs<=1; dat<="N"; next<=dat10; end 
    dat10:   begin  rs<=1; dat<="E"; next<=dat11; end 
    dat11:   begin  rs<=1; dat<="T"; next<=nul; end 
    dat12:   begin  rs<=1; dat<=8'h3E; next<=dat6; end 

     nul:   begin rs<=0;  dat<=8'h00;                    //��һ�� Ȼ�� ��Һ����E �� ��� 
              if(cnt!=2'h2)  
                  begin  
                       e<=0;next<=set0;cnt<=cnt+1;  
                  end  
                   else  
                     begin next<=nul; e<=1; 
                    end    
              end 
   default:   next=set0; 
    endcase 
 
  //Mensaje estado 2

 case(lcdC1) 
    set0:   begin  rs<=0; dat<=8'h0; next<=set1; end 
    set1:   begin  rs<=0; dat<=8'h1; next<=set2; end 
    set2:   begin  rs<=0; dat<=8'h1; next<=set3; end 
    set3:   begin  rs<=0; dat<=8'h2; next<=set4; end 
    set4:   begin  rs<=0; dat<=8'h4; next<=set5; end 
    set5:   begin  rs<=0; dat<=8'h5; next<=set6; end 
    set6:   begin  rs<=0; dat<=8'h6; next<=set7; end 
    set7:   begin  rs<=0; dat<=8'h7; next<=dat0; end
   
    dat0:   begin  rs<=1; dat<="P"; next<=dat1; end 
    dat1:   begin  rs<=1; dat<="O"; next<=dat2; end 
    dat2:   begin  rs<=1; dat<="N"; next<=dat3; end 
    dat3:   begin  rs<=1; dat<="E"; next<=dat4; end 
    dat4:   begin  rs<=1; dat<="R"; next<=dat5; end 
    dat5:   begin  rs<=1; dat<=8'h2; next<=dat6; end 
    dat6:   begin  rs<=1; dat<="S"; next<=dat7; end 
    dat7:   begin  rs<=1; dat<="U"; next<=dat8; end 
    dat8:   begin  rs<=1; dat<=8'h3; next<=dat9; end 
    dat9:   begin  rs<=1; dat<="M"; next<=dat10; end 
    dat10:   begin  rs<=1; dat<="A"; next<=dat11; end 
    dat11:   begin  rs<=1; dat<="N"; next<=dat12; end 
    dat12:   begin  rs<=1; dat<="O"; next<=dat13; end 
    dat13:   begin  rs<=1; dat<=8'h3E; next<=dat14; end 
  
  
    dat14:   begin  rs<=1; dat<=8'h3E; next<=dat15; end 
    dat15:   begin  rs<=1; dat<="A"; next<=dat16; end 
    dat16:   begin  rs<=1; dat<="L"; next<=dat17; end 
    dat17:   begin  rs<=1; dat<=8'h3E; next<=dat18; end 
    dat18:   begin  rs<=1; dat<="C"; next<=dat19; end 
    dat19:   begin  rs<=1; dat<="."; next<=dat20; end 
    dat20:   begin  rs<=1; dat<="T"; next<=dat21; end 
    dat21:   begin  rs<=1; dat<="E"; next<=dat22; end 
   dat22:   begin  rs<=1; dat<="M"; next<=dat23; end 
   dat23:   begin  rs<=1; dat<="P"; next<=dat24; end 
   dat24:   begin  rs<=1; dat<="E"; next<=dat25; end 
   dat25:   begin  rs<=1; dat<="R"; next<=dat26; end 
   dat26:   begin  rs<=1; dat<="A"; next<=dat27; end 
   dat27:   begin  rs<=1; dat<="T"; next<=dat28; end 
   dat28:   begin  rs<=1; dat<="U"; next<=dat29; end 
   dat29:   begin  rs<=1; dat<="R"; next<=dat30; end 
   dat30:   begin  rs<=1; dat<="A"; next<=dat31; end 
   
     nul:   begin rs<=0;  dat<=8'h00;                    //��һ�� Ȼ�� ��Һ����E �� ��� 
              if(cnt!=2'h2)  
                  begin  
                       e<=0;next<=set0;cnt<=cnt+1;  
                  end  
                   else  
                     begin next<=nul; e<=1; 
                    end    
              end 
   default:   next=set0; 
    endcase 
 
 
 
 end 
assign en=clkr|e; 
assign rw=0; 
endmodule  

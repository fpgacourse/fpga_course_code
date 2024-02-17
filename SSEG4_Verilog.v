module sevsegv(
    input clk,
    output segA,
    output segB,
    output segC,
    output segD,
    output segE,
    output segF,
    output segG,
    output segDP,
    output Enable1,
    output Enable2,
    output Enable3
    );
     
reg [23:0] cnt;

assign Enable1 = 0;  //turns 7-seg one on, active low
assign Enable2 = 1;  //turns 7-seg two off, active low
assign Enable3 = 1;  //turns 7-seg three off, active low

always @(posedge clk) cnt <= cnt + 1;//cnt+24'h1;
wire cntovf = &cnt;                  //"redeuction" - bitwise and cntovf activated on 24 bit flip..

//BCD is a counter that counts from 0 to 9
reg [3:0] BCD;

always @(posedge clk)
 if(cntovf) BCD <= (BCD==9 ? 0 : BCD +1); //condition ? if true : if false
                                          //increment if bcd/sseg <= 9 otherwise reset to 0
reg [7:0] SevenSeg;
always @(*)
case(BCD)
    4'h0   : SevenSeg = 8'b00000011; //0
    4'h1   : SevenSeg = 8'b10011111; //1
    4'h2   : SevenSeg = 8'b00100101; //2
    3      : SevenSeg = 8'b00001101; //3
    4      : SevenSeg = 8'b10011001; //4
    5      : SevenSeg = 8'b01001001; //5
    6      : SevenSeg = 8'b01000001; //6
    4'd7   : SevenSeg = 8'b00011111; //7
    4'd8   : SevenSeg = 8'b00000001; //8
    4'd9   : SevenSeg = 8'b00011001; //9
    default:
           SevenSeg = 8'b00000000; //lie all segments + dp
endcase

assign {segA, segB, segC, segD, segE, segF, segG, segDP} = SevenSeg;

endmodule

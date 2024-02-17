module buttons1(
    input but,
    input but1,
    input butext,
    input butext1,
    output led,
    output led1,
    output ledext,
    output ledext1
    );
	 
	 assign led =    ~but;
	 assign led1 =   ~but1;
	 assign ledext = ~butext;
	 assign ledext1 = ~butext1;

//added for clarity..\
endmodule

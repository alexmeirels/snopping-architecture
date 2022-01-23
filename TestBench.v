module TestBench(Clock, WriteRead, state1, state2);

	input Clock;
	
	reg [2:0] regState1[3:0], regState2[3:0];
	reg [1:0] regWriteRead[3:0]; //os que vão mudar
	//reg [2:0] busAjuda;
	
	wire [8:0] PC;
	reg PcEnable;
	
	integer cont;
	
	output reg [2:0] state1;
	output reg [2:0] state2;	// Estados 1 e 2.
	output reg [1:0] WriteRead; // saida com read ou write
	//001 - busrd
	//010 - busrdx
	//011 - busupgrd
	
	
	// Estados
	// I = 001, S = 010, M = 011, E = 100
	//WRITE READ
	// 00 read
	// 01 write
	initial begin // FAZER O CASO TESTE AINDA, ALTERAR A TAG
		cont = 0;
		
		regWriteRead[0] = 2'b00; 	
		regState1[0] = 3'b100;		// E    //EXCLUSIVE READ
		regState2[0] = 3'b010;		//	S
		
		regWriteRead[1] = 2'b01; 	
		regState1[1] = 3'b100;		//EXCLUSIVE WRITE
		regState2[1] = 3'b010;

		regWriteRead[2] = 2'b00; 	
		regState1[2] = 3'b010;		//SHARED HIT
		regState2[2] = 3'b010;		
		
		regWriteRead[3] = 2'b01; 	
		regState1[3] = 3'b010;		//SHARED WRITE
		regState2[3] = 3'b010;				
		
	end
	
	always@(posedge Clock) begin
		PcEnable = 0;
		if(PC!=7) begin
			PcEnable = 1;
			WriteRead = regWriteRead[cont];
			state1 = regState1[cont];
			state2 = regState2[cont];
		end
		else begin
			PcEnable = 1;
			//cont = cont + 1;
		end
		cont = cont + 1;
	end
	

		PCcounter pccounter (Clock, PcEnable, PC);

endmodule

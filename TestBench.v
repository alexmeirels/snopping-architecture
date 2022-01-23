module TestBench(Clock, WriteRead, state1, state2);

	input Clock;
	
	reg [2:0] regState1[14:0], regState2[14:0];
	reg [1:0] regWriteRead[14:0]; //os que vão mudar
	//reg [2:0] busAjuda;
	
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
		// INVALID READ - FIRST CASE - Muda O invalido para shared. Emite o sinal BusRd. CONFERIDO - CERTO
		regWriteRead[0] = 2'b00; 	// Read
		regState1[0] = 3'b001;		// I
		regState2[0] = 3'b010;		// S
		
		// INVALID READ - SECOND CASE - Muda o invalido do estado1 para exclusive. Emite o sinal BusRd. CONFERIDO - CERTO
		regWriteRead[1] = 2'b00; 	// Read
		regState1[1] = 3'b001;		//I
		regState2[1] = 3'b001;		//I
		
		// INVALID WRITE - FIRST CASE - Muda o invalidado para modified e o Shared é mudado para invalido. Emite o sinal BusRdX. CONFERIDO - CERTO
		regWriteRead[2] = 2'b01; 	// Write
		regState1[2] = 3'b001;		//I
		regState2[2] = 3'b010;		//S
		
		// INVALID WRITE - SECOND CASE - Muda apenas o invalido do estado1 para modified. Emite o sinal BusRdX. CONFERIDO - CERTO
		regWriteRead[3] = 2'b01; 	// Write
		regState1[3] = 3'b001;		//I
		regState2[3] = 3'b001;		//I
		
		// EXCLUSIVE READ - Os estados continuam os mesmos. - CONFERIDO - CERTO
		regWriteRead[4] = 2'b00; 	// Read
		regState1[4] = 3'b100;		//E
		regState2[4] = 3'b001;		//I
		
		// EXCLUSIVE WRITE - Muda o exclusive para Modified. - CONFERIDO - CERTO
		regWriteRead[5] = 2'b01; 	// Write
		regState1[5] = 3'b100;		//E
		regState2[5] = 3'b010;		//S
		
		// SHARED READ - Os estados continuam os mesmos. - CONFERIDO - CERTO
		regWriteRead[6] = 2'b00; 	// Read
		regState1[6] = 3'b010;		//S
		regState2[6] = 3'b001;		//I
		
		// SHARED WRITE - Muda o shared do estado1 para modified. Emite o sinal BusUpgr. - CONFERIDO - CERTO
		regWriteRead[7] = 2'b01; 	// Write
		regState1[7] = 3'b010;		//S
		regState2[7] = 3'b001;		//I
		
		// MODIFIED READ - Os estados continuam os mesmos. - CONFERIDO - CERTO
		regWriteRead[8] = 2'b00; 	// Read
		regState1[8] = 3'b011;		//M
		regState2[8] = 3'b001;		//I
		
		// SHARED WRITE - Os estados continuam os mesmos. - CONFERIDO - CERTO
		regWriteRead[9] = 2'b01; 	// Write
		regState1[9] = 3'b011;		//M
		regState2[9] = 3'b001;		//I
		
		// INVALID WRITE - BusRdX - O invalido se tornará Modified e o shared será invalidado. - CONFERIDO - CERTO
		regWriteRead[10] = 2'b01; 	// Write
		regState1[10] = 3'b001;		//I
		regState2[10] = 3'b010;		//S
		
		// EXCLUSIVE READ - BusRd - O invalido se tornará Shared e o exclusive se tornará shared. - CERTO - MAS CONFERIR COM O VITOR ESSE CASO.
		regWriteRead[11] = 2'b00; 	// Read
		regState1[11] = 3'b001;		//I
		regState2[11] = 3'b100;		//E
		
		// EXCLUSIVE WRITE - BusRdX - A lógica é testada do sinal BusRdX no teste: INVALID WRITE - BusRdX.
		
		// SHARED -BusRd -  não tem mudança de estado.
		
		// SHARED WRITE - BusUpgr - O shared do estado 1 se tornará Modified e o shared do estado2 será invalidado. - CONFERIDO - CERTO
		regWriteRead[12] = 2'b01; 	// Write
		regState1[12] = 3'b010;		//S
		regState2[12] = 3'b010;		//S
		
		// MODIFIED READ - BusRd - O invadido se tornará Shared e o modified se tornará shared. Acontece WriteBack. - CERTO - MAS CONFERIR COM O VITOR ESSE CASO.
		regWriteRead[13] = 2'b00; 	// Read
		regState1[13] = 3'b001;		//I
		regState2[13] = 3'b011;		//M

		// MODIFIED WRITE - BusRdX - O invalido se tornará Modified e o modificado será invalidado. Acontece WriteBack - CONFERIDO - CERTO
		regWriteRead[14] = 2'b01; 	// Write
		regState1[14] = 3'b001;		//I
		regState2[14] = 3'b011;		//M
		
		
		
		
		
		
		
		
	end
	
	always@(posedge Clock) begin

			WriteRead = regWriteRead[cont];
			state1 = regState1[cont];
			state2 = regState2[cont];
			cont = cont + 1;
			
	end
	


endmodule

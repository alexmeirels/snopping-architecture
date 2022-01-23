module MaquinasDeEstados(Clock, WriteRead, state1, state2, bus,acaoProcB,newStateB);

//Entradas:
//
	input Clock;
	input [2:0] state1;
	input[2:0] state2;	// Estados 1 e 2.
	input [1:0] WriteRead; // saida com read ou write
	
	//output reg [2:0] estadoProcB;
	//wire [2:0] EstadoProcB;
	//wire [1:0] Bus;
	// Estados
	// I = 001, S = 010, M = 011, E = 100
	output reg[2:0] bus;
	output reg[2:0] acaoProcB;
	output reg[2:0] newStateB;
	//output reg[2:0] acaoProcB;
	
	// Registradores:
	
	reg [1:0] hit; // 1 igual hit, 0 igual a miss
	reg [1:0] miss;
	
	//000 empty
	//001 ler 
	//010 writehit
	
	//bus
	//000 - vazio
	//001 - busrd
	//010 - busrdx
	//011 - busupgrd
	
	
	initial begin // FAZER O CASO TESTE AINDA, ALTERAR A TAG
		acaoProcB = 3'b000; // empty
		bus = 3'b000; //empty
		newStateB = 3'b000; // empty
		hit = 2'b00;
		miss = 2'b00;
	end
	
	
	
	always@(negedge Clock)begin
		
		// Máquina de estado 1
		if(state1 == 3'b100 && WriteRead == 2'b00) // EXCLUSIVE READ
			begin
				acaoProcB = 3'b001;
				bus = 3'b000;
				hit = 2'b01;
				miss = 2'b00;
			end
		if(state1 == 3'b100 && WriteRead == 2'b01) //EXCLUSIVE WRITE
			begin
				newStateB = 3'b011; // Modified
				acaoProcB = 3'b010;
				bus = 3'b000;
				hit = 2'b01;
				miss = 2'b00;
			end
			
		
		if(state1 == 3'b010 && WriteRead == 2'b00) //SHARED HIT
			begin
				acaoProcB = 3'b001;
				bus = 3'b000;
				hit = 2'b01;
				miss = 2'b00;
			end
		if(state1 == 3'b010 && WriteRead == 2'b01) //SHARED WRITE
			begin
				newStateB = 3'b011;
				acaoProcB = 3'b010;
				bus = 3'b011;
				hit = 2'b00;		//conferir se o hit e o miss está certo.
				miss = 2'b01;
			end
		if(state1 == 3'b011 && WriteRead == 2'b00) //MODIFIED READ CONFERIR
			begin
				//acaoProcB = 3'b010;
				bus = 3'b000;
				hit = 2'b01;
				miss = 2'b00;
			end
		if(state1 == 3'b011 && WriteRead == 2'b01) //MODIFIED WRITE CONFERIR
			begin
				//acaoProcB = 3'b010;
				bus = 3'b000;
				hit = 2'b00;		// conferir se o hit e o miss está certo.
				miss = 2'b01;
			end
			
			
		
		if(state1 == 3'b001 && WriteRead == 2'b00) //INVALID READ CONFERIR
			begin
				bus = 3'b001; 		// BusRd
				hit = 2'b00;		// conferir se o hit e o miss está certo.
				miss = 2'b01;
				
				if(state2 == 3'b010 || state2 == 3'b011)
					begin
						newStateB = 3'b010;
					end
				else
					begin
						newStateB = 3'b100;
					end
			end
			
		if(state1 == 3'b001 && WriteRead == 2'b01) //INVALID WRITE CONFERIR
			begin
				//acaoProcB = 3'b010;
				newStateB = 3'b011; // Modified
				bus = 3'b010; 		// BusRdX
				hit = 2'b00;		// conferir se o hit e o miss está certo.
				miss = 2'b01;
			end
	
		// Máquina de estado 2
		
		if(bus == 3'b010 && state1 == 3'b001 && newStateB = 3'b011) //INVALID WRITE CONFERIR
			begin
				//acaoProcB = 3'b010;
				// Criar nova variável
				newStateB = 3'b011; // Modified
				hit = 2'b00;		// conferir se o hit e o miss está certo.
				miss = 2'b01;
			end
			
			// I = 001, S = 010, M = 011, E = 100
		if(state2 == 3'b100 && bus == 3'b001) //INVALID WRITE CONFERIR
			begin
				//acaoProcB = 3'b010;
				newStateB = 3'b011; // Modified
				bus = 3'b010; 		// BusRdX
				hit = 2'b00;		// conferir se o hit e o miss está certo.
				miss = 2'b01;
			end
		
		
	end
	
	
	
	[]
	
/*

			//definando o bus
			if((state1 == 3'b001) && (WriteRead ==2'b00 ))
			begin
			busAjuda = 3'b001; //busrd
			end
			else if ((state1 == 3'b001) && (WriteRead ==2'b01 ))
			begin
			busAjuda = 3'b010; //busrdx
			end
			else if((state1 == 3'b010) && (WriteRead ==2'b01 ))
			begin
			busAjuda = 3'b011; //busupgrd
			end
			
			bus = busAjuda;
		*/


endmodule


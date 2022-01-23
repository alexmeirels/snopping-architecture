module MaquinasDeEstados(Clock, WriteRead, state1, state2, bus, newState1, newState2, WriteBack);

 
/* Instruções para melhor entendimento do código.
 -----------------------------------------
	Estados
	I = 001, S = 010, M = 011, E = 100
	bus
	000 - vazio
	001 - busrd
	010 - busrdx
	011 - busupgrd
 -----------------------------------------
 */

	//	Entradas:
	input Clock;
	input [2:0] state1;
	input[2:0] state2;	// Estados 1 e 2.
	input [1:0] WriteRead; // saida com read ou write
	
	// Saídas que receberam os valores para a simulação.
	output reg[2:0] bus;
	output reg[2:0] newState1;
	output reg[2:0] newState2;
	output reg[1:0] WriteBack;

	// Registradores:
	reg [1:0] hit;
	reg [1:0] miss;
	
	
	initial begin 
		
		bus = 3'b000; 
		newState1 = 3'b000; 
		newState2 = 3'b000;
		WriteBack = 2'b00;
		hit = 2'b00;
		miss = 2'b00;

	end
	
	
	
	always@(negedge Clock)begin
		WriteBack = 2'b00;
		
// --------------------------------------------------------------------------------------------
		// Máquina de estado 1
		
		if(state1 == 3'b100 && WriteRead == 2'b00) // EXCLUSIVE READ - CONFERIDO
			begin
				newState1 = state1;	// Continua os mesmos estados.
				newState2 = state2;
				bus = 3'b000;			// Não emite sinal.
				hit = 2'b01;			// Da hit.
				miss = 2'b00;			// Não da miss.
			end
		if(state1 == 3'b100 && WriteRead == 2'b01) //EXCLUSIVE WRITE - CONFERIDO
			begin
				newState1 = 3'b011; 	// Modified.
				newState2 = state2;	// Continua o mesmo estado.
				bus = 3'b000;			// Não emite sinal.
				hit = 2'b01;			// Da hit.
				miss = 2'b00;			// Não da miss.
			end
				
		if(state1 == 3'b010 && WriteRead == 2'b00) //SHARED HIT -  CONFERIDO
			begin
				newState1 = state1;	// Continua os mesmos estados.
				newState2 = state2;	
				bus = 3'b000;			// Não emite sinal.
				hit = 2'b01;			// Da hit.
				miss = 2'b00;			// Não dá miss.
			end
		if(state1 == 3'b010 && WriteRead == 2'b01) //SHARED WRITE - CONFERIDO
			begin
				newState1 = 3'b011;	// MODIFIED 
				bus = 3'b011;			// Emite sinal BusUpgr.
				hit = 2'b00;			// Não da hit.
				miss = 2'b01;			// Dá miss.
			end
		if(state1 == 3'b011 && WriteRead == 2'b00) //MODIFIED READ - CONFERIDO
			begin
				newState1 = state1;	// Continua os mesmos estados.
				newState2 = state2;
				bus = 3'b000;			// Não emite sinal.
				hit = 2'b01;			// Dá hit.
				miss = 2'b00;			// Não dá miss.
			end
		if(state1 == 3'b011 && WriteRead == 2'b01) //MODIFIED WRITE - CONFERIDO
			begin
				newState1 = state1;	// Continua os mesmos estados.
				newState2 = state2;
				bus = 3'b000;			//	Não emite sinal.
				hit = 2'b00;			// Não dá hit
				miss = 2'b01;			// Dá miss.
			end

		if(state1 == 3'b001 && WriteRead == 2'b00) //INVALID READ -CONFERIDO
			begin
				bus = 3'b001; 			// BusRd
				hit = 2'b00;			// Não dá hit.
				miss = 2'b01;			// Dá miss.
				newState2 = state2;	// Continua o mesmo estado.
				
				if(state2 == 3'b010 || state2 == 3'b011 || state2 == 3'b100) // Se shared ou modified
					begin
						newState1 = 3'b010; 	// SHARED

					end
				else //
					begin
						newState1 = 3'b100; 	// EXCLUSIVE

					end			
			end
			
		if(state1 == 3'b001 && WriteRead == 2'b01) //INVALID WRITE CONFERIDO
			begin
				
				newState1 = 3'b011; 	// Modified
				bus = 3'b010; 			// BusRdX
				hit = 2'b00;			// Não da hit.
				miss = 2'b01;			// Dá miss.
			end
//-------------------------------------------------------------------------------------------------------
		// Máquina de estado 2 
		
		if(bus == 3'b010 && state1 == 3'b001 && newState1 == 3'b011) //INVALID BusRdx CONFERIDO
			begin

				newState2 = 3'b001; // INVALID

			end
			
		if(state2 == 3'b100 && bus == 3'b001) // EXCLUSIVE BusRd
			begin

				newState2 = 3'b010; // SHARED

			end

		if(state2 == 3'b100 && bus == 3'b0010) // EXCLUSIVE BusRdX
			begin
				
				newState2 = 3'b001; // INVALID

			end
			
		if(state1 == 3'b010 && state2 == 3'b010 && bus == 3'b011 && WriteRead == 2'b01)	// SHARED BusUpgr
			begin
			
				newState2 = 3'b001; // INVALID
			
			end
			
		if(state2 == 3'b011 && bus == 3'b001)	// MODIFIED BusRd
			begin
			
				newState2 = 3'b010;	// SHARED
				WriteBack = 2'b01;	// Ocorreu WriteBack.
			end
			
		if(state2 == 3'b011 && bus == 3'b010)	// MODIFIED BusRdX
			begin
			
				newState2 = 3'b001;	// INVALID
				WriteBack = 2'b01;	// Ocorreu WriteBack.
			end
		
	end
// --------------------------------------------------------------------------------------------
endmodule


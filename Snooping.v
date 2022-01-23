module Snooping(Clock);

input Clock;

//testbench

	wire [2:0] state1;
	wire [2:0] state2;	// Estados 1 e 2.
	wire[1:0] WriteRead; // saida com read ou write
	wire [2:0] bus; // bus
	wire [2:0] acaoProcB;
	wire [2:0] newStateB;
	
 //TestBench test(Clock, WriteRead, state1, state2, bus);

//máquina de estados
	
 TestBench test(Clock, WriteRead, state1, state2);
 MaquinasDeEstados maquinaestado1(Clock, WriteRead, state1, state2, bus,acaoProcB,newStateB);


endmodule

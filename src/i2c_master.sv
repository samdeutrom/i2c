/*
    Module for master i2c communication
    created by: Sam Deutrom
    date last modified: 05/04/23
*/
//import uart_tx_pkg::*;

module i2c_master
    #(parameter	
        CLK_FREQ   = 100_000_000,
		I2C_FREQ    = 400_000
   )( 
        input logic  clk, 
        input logic  rst_n
		
	);
	
	// State machine state defined in uart_tx_pkg.sv
	//states_e state;
	//states_e next;
	
	/*-------------------------------------------
	|           I2C Clock Generation            |	 
	-------------------------------------------*/
    localparam int I2C_COUNTER_MAX = CLK_FREQ/I2C_FREQ; 
    localparam int I2C_HALF_COUNTER_MAX = I2C_COUNTER_MAX/2; 
    localparam int I2C_COUNTER_SZIE = $clog2(I2C_COUNTER_MAX);
	
    logic [I2C_COUNTER_SZIE-1:0]  i2c_counter;
    logic                         i2c_clk;
    logic                         i2c_counter_done; 
	
    always_ff @(posedge clk or negedge rst_n) begin 
        if (!rst_n)  i2c_counter <= '0;
        else begin
            if (i2c_counter_done)  i2c_counter <= '0;
            else                   i2c_counter <= i2c_counter +'d1;
        end
    end
	
    assign i2c_clk = (i2c_counter <= I2C_HALF_COUNTER_MAX-1) ? 0 : 1 ; 
    assign i2c_counter_done = (i2c_counter == I2C_COUNTER_MAX-1); 
	
endmodule
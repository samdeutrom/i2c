add wave -divider {uart_tx_test}
add wave -noupdate -expand -group i2c_master_test -radix hex \
{/i2c_master_tb/clk}\
{/i2c_master_tb/rst}\
{/i2c_master_tb/MUT.i2c_clk}\
{/i2c_master_tb/MUT.i2c_counter}


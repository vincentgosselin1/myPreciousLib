//Quad spi driver.sv

//include uvm header files
`include "uvm_macros.svh"
import uvm_pkg::*;

//Import quad spi sequence item
import quad_spi_pkg::*;

class quad_spi_driver extends uvm_driver #(quad_spi_sequence_item);

   //virtual interface
   virtual quad_spi_if spi_if;
   
   //constructor
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction // new

   //build phase
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      if(!uvm_config_db#(virtual quad_spi_if)::get(this, "", "vif", spi_if)) begin
	 `uvm_fatal("VIF_NOT_SET", "Virtual interface not set for Quad SPI Driver.");
      end
   endfunction // build_phase

   //Main run task: Drive transactions on the SPI interface
   virtual task run_phase(uvm_phase phase);

      quad_spi_sequence_item tx_item;

      forever begin
	 //get the next transaction from the sequencer
	 seq_item_port.get_next_item(tx_item);

	 //Perform SPI transaction
	 drive_transaction(tx_item);

	 //indicate the transaction is complete
	 seq_item_port.item_done();
      end
   endtask // run_phase


   //Drive transaction on the spi interface
   task drive_transaction(quad_spi_sequence_item tx_item);
      
      //Set chip select low to initiate transaction
      spi_if.cs_n <= 0;

      //send command byte
      send_spi_byte(tx_item.cmd);

      //Send address bytes (if applicable)
      if (tx_item.has_address) begin
	 send_spi_byte(tx_item.addr[23:16]);
	 send_spi_byte(tx_item.addr[15:8]);
	 send_spi_byte(tx_item.addr[7:0]);
      end

      //send dummy cycles (if applicable), this only waits for some cycles.
      if(tx_item.dummy_cycles > 0) begin
	 repeat(tx_item.dummy_cycles) @(posedge spi_if.clk);
      end

      //send or receive datax
      if(tx_item.direction == SPI_WRITE) begin
	 foreach(tx_item.data_out[i]) begin
	    send_spi_byte(tx_item.data_out[i]);
	 end
      end else if (tx_item.direction == SPI_READ) begin
	 foreach(tx_item.data_out[i]) begin
	    tx_item.data_in[i] = receive_spi_byte();
	 end
      end

      //set chip select high to end transaction
      spi_if.cs_n <= 1;
      
   endtask // drive_transaction

   //Task to send a single spi byte
   task send_spi_byte(byte data);
      for(int i = 7; i >= 0; i--) begin
	 spi_if.mosi <= data[i];
	 @(posedge spi_if.clk);
      end
   endtask // send_spi_byte

endclass // quad_spi_driver

   
      
   
      
      

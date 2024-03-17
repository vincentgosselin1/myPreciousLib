//                              -*- Mode: Verilog -*-
// Filename        : tb.sv<dff_assignment>
// Description     : Data flip-flop tb, yes the one and only!!!
// Author          : Vincent Gosselin
// Created On      : Sun Mar 17 18:21:10 2024
// Last Modified By: Vincent Gosselin
// Last Modified On: Sun Mar 17 18:21:10 2024
// Update Count    : 0
// Status          : Unknown, Use with caution!



`timescale 1ns / 1ps


/////////////////////////Transaction
`include "uvm_macros.svh"
import uvm_pkg::*;

//////////////////////////////////////////////////////////////interface
interface dff_if();
   logic 		      clk;
   logic		      rst;
   logic		      din;
   logic		      dout;
endinterface



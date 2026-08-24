`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.01.2025 18:12:45
// Design Name: 
// Module Name: rsa_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`include "rsa_decryption.v"
module rsa_2_tb;

    reg clk;
    reg rst;
    reg [31:0] encrypted_message;
//    reg encrypt;
    wire [31:0] decrypted_message;

    // Instantiate the RSA module
    rsa_decryption #(
        .public_k(7), // Public exponent
        .private_k(3), // Private exponent
        .mod(33)       // Modulus
    ) uut (
        .clk(clk),
        .rst(rst),
        .encrypted_message(encrypted_message),
//        .encrypt(encrypt),
        .decrypted_message(decrypted_message)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Test stimulus
    initial begin

        encrypted_message = 7; 

        rst = 1; // Apply reset
        #10 rst = 0;

        // Encryption test

         // Plaintext message
        #200;
        $display("Decrypted Message: %d", decrypted_message);

        // End simulation
        $finish;
    end



    initial begin
        $dumpfile("wave_dec.vcd");
        $dumpvars(0,uut);
    end
endmodule

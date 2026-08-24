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

`include "rsa_encryption.v"
module rsa_2_tb;

    reg clk;
    reg rst;
    reg [31:0] message;
//    reg encrypt;
    wire [31:0] encrypted_message;

    // Instantiate the RSA module
    rsa_encryption #(
        .public_k(7), // Public exponent
        .private_k(3), // Private exponent
        .mod(33)       // Modulus
    ) uut (
        .clk(clk),
        .rst(rst),
        .message(message),
//        .encrypt(encrypt),
        .encrypted_message(encrypted_message)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Test stimulus
    initial begin

        message = 13; 

        rst = 1; // Apply reset
        #10 rst = 0;

        // Encryption test

         // Plaintext message
        #200;
        $display("Encrypted Message: %d", encrypted_message);

        // Decryption test

        message = encrypted_message;  // Ciphertext
        #50;
        $display("Decrypted Message: %d", encrypted_message);

        // End simulation
        $finish;
    end



    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0,uut);
    end
endmodule

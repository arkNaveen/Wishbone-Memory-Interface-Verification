`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.01.2025 20:45:35
// Design Name: 
// Module Name: top_package
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


module top_package#(parameter public_k = 7, private_k = 3, mod = 33)(
    input clk, rst,
    input [31:0] message,   
    output [31:0] decrypted_message // Encrypted/Decrypted result
    );
    
    wire [31:0] encrypted_message;
    
    rsa_encryption rsa_en (
    clk, rst, message, encrypted_message // Encrypted/Decrypted result
    );
    
    
    rsa_decryption rsa_dec
    (
    .clk(clk), .rst(rst), .encrypted_message(encrypted_message), 
    .decrypted_message(decrypted_message) // Encrypted/Decrypted result
    );
    
endmodule

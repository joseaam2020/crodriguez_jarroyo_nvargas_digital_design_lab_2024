`timescale 1ns / 1ps

module byteRam_tb;

    // Signals
    logic clk;
    logic [31:0] address;
    logic [7:0] byteData;
    logic [31:0] wordData;
    logic byteWriteEnable;
    logic writeEnable;
    logic [31:0] q;

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk; // 10ns clock period

    // Instantiate the byteRam module
    byteRam uut (
        .clk(clk),
        .address(address),
        .byteData(byteData),
        .wordData(wordData),
        .byteWriteEnable(byteWriteEnable),
        .writeEnable(writeEnable),
        .q(q)
    );

    // Test Procedure
    initial begin
        // Test 1: Write and read from newRam (address < MAX)
        $display("Starting Test 1: Write/Read from newRam...");
        address = 32'h0000_0004;  // Address within newRam
        wordData = 32'hDEAD_BEEF;
        writeEnable = 1;
        byteWriteEnable = 0;
        #10; // Wait for the write to complete

        writeEnable = 0; // Disable write
        #10; // Wait for the read
        $display("Address: %h, Read Data: %h (Expected: %h)", address, q, 32'h0000_0000);

        // Test 2: Write and read a byte from newRam
        $display("Starting Test 2: Byte Write/Read from newRam...");
        address = 32'h0000_0004;  // Same address
        byteData = 8'hAA;
        byteWriteEnable = 1;
        writeEnable = 1;
        #10; // Wait for the write to complete

        writeEnable = 0; // Disable write
        #10; // Wait for the read
        $display("Address: %h, Read Data: %h (Expected: %h)", address, q, 32'h0000_00AA);

        // Test 3: Read from newRam2
        $display("Starting Test 3: Read from newRam2...");
        address = 32'h0001_0004;  // Same address
        byteWriteEnable = 0;
        writeEnable = 0;
        #10; // Wait for the write to complete

        writeEnable = 0; // Disable write
        #10; // Wait for the read

        // Test 4: Write and read from newRam2 (address > MAX)
        $display("Starting Test 4: Write/Read from newRam2...");
        address = 32'h0001_0004;  // Address within newRam2
        wordData = 32'hCAFEBABE;
        writeEnable = 1;
        byteWriteEnable = 0;
        #10; // Wait for the write to complete

        writeEnable = 0; // Disable write
        #10; // Wait for the read
        $display("Address: %h, Read Data: %h (Expected: %h)", address, q, wordData);

        // Test 5: Byte Write/Read from newRam2
        $display("Starting Test 5: Byte Write/Read from newRam2...");
        address = 32'h0001_0004;  // Same address
        byteData = 8'h55;
        byteWriteEnable = 1;
        writeEnable = 1;
        #10; // Wait for the write to complete

        writeEnable = 0; // Disable write
        #10; // Wait for the read
        $display("Address: %h, Read Data: %h (Expected: %h)", address, q, 32'h00000055);

        // End of Test
        $display("Test complete.");
        $stop;
    end

endmodule

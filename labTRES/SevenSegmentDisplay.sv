module SevenSegmentDisplay (
    input logic [3:0] binary_input, // 4-bit binary input
    output logic [6:0] display_output // 7-bit output for each segment
);
    // The 7-segment display output for each digit (active low)
    always_comb begin
        case(binary_input)
            4'b0000: display_output = 7'b1000000; // 0
				4'b0001: display_output = 7'b1111001; // 1
				4'b0010: display_output = 7'b0100100; // 2
				4'b0011: display_output = 7'b0110000; // 3
            4'b0100: display_output = 7'b0011001; // 4
				4'b0101: display_output = 7'b0010010; // 5
            4'b0110: display_output = 7'b0000010; // 6
            4'b0111: display_output = 7'b1111000; // 7
            4'b1000: display_output = 7'b0000000; // 8
            4'b1001: display_output = 7'b0010000; // 9
            default: display_output = 7'b1111111; // All segments off
        endcase
    end
endmodule
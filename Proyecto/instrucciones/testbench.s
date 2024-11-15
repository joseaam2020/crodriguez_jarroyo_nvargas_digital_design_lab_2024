.section .text
.global _start
_start:
    // Initialize values in registers
    MOV R0, #5          // Load 5 into R0
    MOV R1, #10         // Load 10 into R1
    MOV R2, #4          // Load 3 into R2
    MOV R3, #50         // Threshold for comparison

    // ADD R0 and R1
    ADD R4, R0, R1      // R4 = R0 + R1 = 5 + 10 = 15

    // Multiply the sum by R2
    MUL R5, R4, R2      // R5 = R4 * R2 = 15 * 3 = 45

    // Store the result in memory
    LDR R6, [R0]     // Load the address of `result` into R6
    STR R5, [R6]        // Store R5 (45) into memory at `result`

    // Compare the result with the threshold
    CMP R5, R3          // Compare R5 (45) with R3 (50)

    // Branch if result < threshold
    BLT below_threshold // If R5 < R3, branch to `below_threshold`

    // Code if the result is >= threshold
above_threshold:
    MOV R7, #1          // Set R7 to 1 to indicate R5 >= R3
    B end               // Jump to end

below_threshold:
    MOV R7, #0          // Set R7 to 0 to indicate R5 < R3

end:
    // Endless loop to halt the program
    B end
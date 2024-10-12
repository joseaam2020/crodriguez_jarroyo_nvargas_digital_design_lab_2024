        .text
        .global _start

_start:
        MOV R0, #4          
        B fibonacci               

fibonacci:
        CMP R0, #0          @ Comparar R0 con 0
        BEQ salir           @ Si R0 == 0, salir
        CMP R0, #1          @ Comparar R0 con 1
        BEQ exit1           @ Si R0 == 1, ir a exit1

        
        MOV R1, #0          @ R1 = 0 (F0)
        MOV R2, #1          @ R2 = 1 (F1)
        SUB R0, R0, #1      @ R0 = R0 - 1

loop:
        CMP R0, #0          @ Se comparar R0 con 0
        BEQ exit0           @ R0 == 0 ?, ir a exit0
        ADD R4, R1, R2      @ R4 = R1 + R2 (siguiente número de Fibonacci)
        MOV R1, R2          @ R1 = R1 toma el valor de R2
        MOV R2, R4          @ R2 = R2 toma el valor de R4
        SUB R0, R0, #1      @ R0 = R0 - 1
        B loop              @ Salta de nuevo a LOOP

exit1:
        MOV R0, #1          @ Fibonacci  1
        B store_result      @ almacenar el resultado

exit0:
        MOV R0, R4          @ resultado 

store_result:
        LDR R5, =0x1000     @ 0x1000  resultado
        STR R0, [R5]        @ Almacenar el valor de R0 en la memoria en 0x1000

salir:
        b salir

        .end

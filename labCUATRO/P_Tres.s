.section .text
        .global _start

_start:
        MOV r0, #0        @ r0 acumulador
        MOV r1, #0        @ r1 índice de columna
        MOV r2, #0        @ r2 índice de fila
		mov r3, #1
		mov r4, #2
		MOV r5, #0x2000
		MOV r6, #0x2010
		mov r7, #0x2020
	
@ Llena matriz 1	
matrix1: 				@int matriz1[4][4]
	cmp r1, #16 		@ ¿i = 16?
	moveq r1, #0		@ @ Reinicia i si i = 16
	moveq r2, #0		@ Reinicia j si i = 16
	beq matrix2 		@ Si es True vaya a matrix2
	cmp r2, #4			@ ¿j = 4?
	beq matrix1_aux		@ Si es True vaya a matrix1_aux
	add r0, r1, r2
	strb  r2, [r5, r0] 	@ Guardar lo que hay en r3 
	add r2, r2, #1		@  j++
	b matrix1

matrix1_aux:
	add r1, r1, #4		@ i++
	mov r2, #0			@ Reiniciar j
	b matrix1
	

@ Llenar matriz 2	
matrix2: 				@int matrix2[4][4]
	cmp r1, #16 		@ ¿i = 16?
	moveq r1, #0		@ @ Reinicia i si i = 16
	moveq r2, #0		@ Reinicia j si i = 16
	beq matrixResult	@ Si es True vaya a matrixResult
	cmp r2, #4			@ ¿j = 4?
	beq matrix2_aux		@ Si es True vaya a matrix2_aux
	add r0, r1, r2
	strb  r4, [r6, r0] 	@ Guardar lo que hay en r3 
	add r2, r2, #1		@  j++
	b matrix2

matrix2_aux:
	add r1, r1, #4		@ i++
	mov r2, #0			@ Reiniciar j
	b matrix2
	
@ Llenar matriz resultante
matrixResult: 				@int matriz2[4][4]
	cmp r1, #16 			@ ¿i = 4?
	beq exit 				@ Si es True vaya a matrix2
	cmp r2, #4				@ ¿j = 4?
	beq matrixResult_aux	@ Si es True vaya a matrix1_aux
	add r0, r1, r2			
	ldrb r9, [r5, r0]		@ Guardar en r9
	ldrb r10, [r6, r0]		@ Guardar en r10
	add r11, r9, r10		@ Guardar la suma de r9 y r10 en r11
	strb  r11, [r7, r0] 	@ Guardar lo que hay en r3 
	add r2, r2, #1			@  j++
	b matrixResult

matrixResult_aux:
	add r1, r1, #4		@ i++
	mov r2, #0			@ Reiniciar j
	b matrixResult
	
exit: 
 b exit

	
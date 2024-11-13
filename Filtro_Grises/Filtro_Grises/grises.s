.global _start
_start:
	
	mov r0, #0x1000       // Dirección donde se toma el pixel
	mov r1, #0            // Contador
	mov r2, #0x1ffc       // Dirección donde se guarda el valor de r6
	mov r3, #0x3000       // Dirección donde se guarda el valor de r7
	
loop:	
	// Primera multiplicación
	mov r5, #299
	ldrb r4, [r0, r1]
	mul r7, r4, r5
	add r1, r1, #1 

	// Segunda multiplicación
	mov r5, #299
	ldrb r4, [r0, r1]
	mul r8, r4, r5
	add r1, r1, #1 
	
	// Tercera multiplicación
	mov r5, #299
	ldrb r4, [r0, r1]
	mul r9, r4, r5
	add r1, r1, #1 

	// Sumar los resultados parciales
	add r10, r9, r8
	add r10, r10, r7
	
	// División aproximada de r10 por 1000
	mov r5, #0x4189       // Factor de aproximación para la división entre 1000
	mul r10, r10, r5      // Multiplica r10 por el factor de aproximación
	lsr r10, r10, #22     // Desplaza 22 bits para dividir entre 1000
	
	// Almacenar el resultado
	str r10, [r2, r1] 

	// Continuar el loop
	b loop


	
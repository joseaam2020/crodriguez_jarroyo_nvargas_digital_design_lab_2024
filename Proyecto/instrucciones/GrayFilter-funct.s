.global _start
_start:
	mov r0, #0x1000 	// Direción donde se encuentra el primer pixel
	mov r1, #0 			// Contador
	ldr r2, =0x32704 	// Dirección donde se guarda el pixel inicial convertido
	mov r3, #0 			// Guarda el resultado de la división
	//mov r11, #0			// Contador para llevar la cantidad de pixeles
	
	

gray_loop:
	mov r3, #0 //Reinicia el cociente
	// Primera multiplicación
	mov r5, #114
	ldrb r4, [r0, r1]
	mul r7, r4, r5
	add r1, r1, #1


	// Segunda multiplicación
	mov r5, #587
	ldrb r4, [r0, r1]
	mul r8, r4, r5
	add r1, r1, #1
	
	// Tercera multiplicación
	mov r5, #299
	ldrb r4, [r0, r1]
	mul r9, r4, r5
	add r1, r1, #1 

	// Sumar los resultados parciales
	mov r5, #1000
	add r10, r9, r8
	add r10, r10, r7 // Guarda los valores en r10
	b divide_loop

divide_loop: 
    cmp r10, r5           // Compara el dividendo con el divisor
    blt comp       // Si el dividendo es menor que el divisor, termina la división
    sub r10, r10, r5       // Resta el divisor del dividendo
    add r3, r3, #1       // Incrementa el cociente
    b divide_loop        // Repite el bucle
	
comp:
    // Compara si el cociente es mayor que 255
    cmp r3, #255
    blt result         // Si r3 es menor o igual a 255, no se hace ningún cambio
    mov r3, #255          // Si r3 es mayor que 255, asigna 255
	b result

	

// Añade el resultado 	
result:
    // Almacena el valor combinado en la memoria
    strb r3, [r2, #0]    
    strb r3, [r2, #1]    
    strb r3, [r2, #2]
	
	add r11, r11, #1 // Indica que un pixel completo ya se guardó
	
    b continue_loop
	
continue_loop:
	add r1, r1, #1     
    ldr r5, =50625          // Total de píxeles
    cmp r11, r5          // Compara r1 con r5
    beq end_loop        // Si r1 >= r5
	add r2, r2, #4
    b gray_loop         // Si r1 < r5
	
	


end_loop:
    b end_loop
	
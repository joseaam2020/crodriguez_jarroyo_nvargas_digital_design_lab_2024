.global _start
_start:

	mov r0, #16        	// Direción donde se encuentra el primer pixel
	mov r1, #0 			// Contador
	ldr r2, [r1,#4]
	mov r3, #0 			// Guarda el resultado de la división
    mov r4, #0
	mov r11, #0			// Contador para llevar la cantidad de pixeles
    mov r12, #0

    str r12, [r3,#12]
    ldr r3, [r3, #0]    //Condicion para saber cual algoritmo ejecutar

initial_loop:

    cmp r12, #1
    beq initial_loop

    ldr r3, [r3,#0]
    cmp r3, #1

    beq Sepialoop       //Si es igual a uno haga Sepialoop

    bgt gray_loop       //Si es mayor a uno haga gray_loop
    
    mov r12, #1

    mov r3, #0
    str r12, [r3,#12]

    blt _start          //Si es menor no haga nada
	
	//R5 constantes
	//r6 rojo
	//r7 verde
	//r8 azul 
	
Sepialoop:
	mov r3, #0
	
// Obtener valores 

	// Se saca el valor del azul para el pixel rojo
	mov r5, #189 
    ldrb r8, [r0, r1]
	mul r6, r8, r5
	
	// Se saca el valor del azul para el pixel verde
	mov r5, #168
	mul r7, r8, r5


	// Se saca el valor del azul para el pixel azul 
	mov r5, #131
	mul r9, r8, r5
	
	add r1, r1, #1
	
//--------------------------------------------------------------	
	
	// Se saca el valor del verde para el pixel rojo
	//mov r5, #769
    mov r5, #255
    add r5, r5, #255
    add r5, r5, #255
    add r5, r5, #4
    ldrb r8, [r0, r1]
	mul r10, r8, r5
	add r6, r6,r10
	
	// Se saca el valor del verde para el pixel verde
	//mov r5, #686
    mov r5, #255
    add r5, r5, #255
    add r5, r5, #176
	mul r10, r8, r5
	add r7, r7,r10
	
	// Se saca el valor del verde para el pixel azul 
	//mov r5, #534
    mov r5, #255
    add r5, r5, #255
    add r5, r5, #24
	mul r10, r8, r5
	add r9, r9,r10
	
	add r1, r1, #1
	
	
//--------------------------------------------------------------	
	
	// Se saca el valor del rojo para el rojo
	//mov r5, #393
    mov r5, #255
    add r5, r5, #138
    ldrb r8, [r0, r1]
	mul r10, r8, r5
	add r6, r6,r10
	
	// Se saca el valor del rojo para el pixel verde
	//mov r5, #349
    mov r5, #255
    add r5, r5, #94
	mul r10, r8, r5
	add r7, r7,r10
	
	// Se saca el valor del rojo para el pixel azul 
	//mov r5, #272
    mov r5, #255
    add r5, r5, #17
	mul r10, r8, r5
	add r9, r9,r10	
	
	add r1, r1, #1
	
	//mov r5, #1000	 
    mov r5, #255
    add r5, r5, #255
    add r5, r5, #255
    add r5, r5, #235

//-------------------Divide_Loop-------------------------------------------		
divide_loop1:
// Division para el pixel rojo
    cmp r6, r5           // Compara el dividendo con el divisor
    blt comp1       		 // Si el dividendo es menor que el divisor, termina la división
    sub r6, r6, r5       // Resta el divisor del dividendo
    add r3, r3, #1       // Incrementa el cociente
    b divide_loop1        // Repite el bucle	

comp1:
    // Compara si el cociente es mayor que 255
    cmp r3, #255
    blt seg_div        // Si r3 es menor o igual a 255, no se hace ningún cambio
    mov r3, #255          // Si r3 es mayor que 255, asigna 255
	b seg_div
	
divide_loop2:
// Division para el pixel rojo
    cmp r7, r5           // Compara el dividendo con el divisor
    blt comp2       		 // Si el dividendo es menor que el divisor, termina la división
    sub r7, r7, r5       // Resta el divisor del dividendo
    add r3, r3, #1       // Incrementa el cociente
    b divide_loop2        // Repite el bucle	
	
comp2:
    // Compara si el cociente es mayor que 255
    cmp r3, #255
    blt ter_div        // Si r3 es menor o igual a 255, no se hace ningún cambio
    mov r3, #255          // Si r3 es mayor que 255, asigna 255
	b ter_div
	
divide_loop3:
// Division para el pixel rojo
    cmp r9, r5           // Compara el dividendo con el divisor
    blt comp3       		 // Si el dividendo es menor que el divisor, termina la división
    sub r9, r9, r5       // Resta el divisor del dividendo
    add r3, r3, #1       // Incrementa el cociente
    b divide_loop3        // Repite el bucle
	
comp3:
    // Compara si el cociente es mayor que 255
    cmp r3, #255
    blt final_div        // Si r3 es menor o igual a 255, no se hace ningún cambio
    mov r3, #255          // Si r3 es mayor que 255, asigna 255
	b final_div
	
	
seg_div:
	
	add r6, r3, #0
	mov r3, #0
	b divide_loop2
	
ter_div:
	
	add r7, r3, #0
	mov r3, #0
	b divide_loop3

final_div:
	
	add r9, r3, #0
	mov r3, #0
	b store
	
//-------------------store-------------------------------------------			
store:
	// Almacena el valor combinado en la memoria
    strb r6, [r2, #2]    
    strb r7, [r2, #1]    
    strb r9, [r2, #0]
	
	add r11, r11, #1 // Indica que un pixel completo ya se guardó
	
    b continue_loop
	

//-------------------Continue_loop-------------------------------------------		
continue_loop:
	add r1, r1, #1     
	mov r5, #0
    ldr r5, [r5,#8]         // Total de píxeles
    cmp r11, r5          // Compara r1 con r5
    beq end_loop        // Si r1 >= r5
	add r2, r2, #4
    b Sepialoop        // Si r1 < r5

end_loop:
	mov r0, #16        	// Direción donde se encuentra el primer pixel
	mov r1, #0 			// Contador
	ldr r2, [r1,#4]
	mov r3, #0 			// Guarda el resultado de la división
    mov r4, #0
	mov r11, #0			// Contador para llevar la cantidad de pixeles
    mov r12, #1
    str r12, [r11,#12]
    b initial_loop

gray_loop:
	mov r3, #0 //Reinicia el cociente
	// Primera multiplicación
	mov r5, #114
	ldrb r4, [r0, r1]
	mul r7, r4, r5
	add r1, r1, #1


	// Segunda multiplicación
	//mov r5, #587
    mov r5, #255
    add r5, r5, #255
    add r5, r5, #77
	ldrb r4, [r0, r1]
	mul r8, r4, r5
	add r1, r1, #1
	
	// Tercera multiplicación
	//mov r5, #299
    mov r5, #255
    add r5, r5, #44
	ldrb r4, [r0, r1]
	mul r9, r4, r5
	add r1, r1, #1 

	// Sumar los resultados parciales
	//mov r5, #1000
    mov r5, #255
    add r5, r5, #255
    add r5, r5, #255
    add r5, r5, #235
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
	
    b continue_loopGray
	
continue_loopGray:
	add r1, r1, #1     
    //ldr r5, =50625          // Total de píxeles
	mov r5, #0
	ldr r5, [r5,#8]
    cmp r11, r5          // Compara r1 con r5
    beq end_loopGray        // Si r1 >= r5
	add r2, r2, #4
    b gray_loop         // Si r1 < r5
        
end_loopGray:
	mov r0, #16        	// Direción donde se encuentra el primer pixel
	mov r1, #0 			// Contador
	ldr r2, [r1,#4]
	mov r3, #0 			// Guarda el resultado de la división
    mov r4, #0
	mov r11, #0			// Contador para llevar la cantidad de pixeles
    mov r12, #1

    str r12, [r3,#12]
    b initial_loop
		
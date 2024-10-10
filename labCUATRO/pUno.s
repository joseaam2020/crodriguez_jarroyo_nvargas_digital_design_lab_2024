.global _start
_start:
    //int [10]array = {...}
        mov r0, #0x2000 // r0 = base address
        mov r1, #0          // r1 = i = 0
        mov r2, #0          // r2 = offset = 0 

    array:
        cmp r1, #10         // i = 10 
        beq endarray        // if i = 10, exit
        lsl r2, r1, #2      // offset = i*4
        str r1, [r0,r2]     // else array[offset] = i  
        add r1, r1, #1          // i++ 
        b array             // loop
    endarray:

        mov r4, #4          //y = 4

        //for(i = 0; i < 10; i++)
        mov r1, #0          //i = 0
        mov r2, #0          //offset = 0
    for: 
        cmp r1, #10          // i < 10 
        beq endfor          // if (i > 10) exit
        lsl r2, r1, #2      // offset = i*4
        ldr r3, [r0, r2]    //r3 = array[offset] 
        cmp r3, r4          // array[offset] > y
        bge cond1           //if (array[offset] >= y) multiplicar 
        add r3, r3, r4      //else sumar
    endif:
        str r3, [r0,r2]     //guardar en memoria
        add r1, r1, #1      // i++ 
        b for               //loop

    cond1:
        mul r3, r3, r4      //array[offset] = array[offset] * y
        b endif               //loop

    endfor:

        // Exit code
    exit:
        b exit 

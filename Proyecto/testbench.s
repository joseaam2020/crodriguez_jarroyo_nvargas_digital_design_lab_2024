.global _start
_start:

    add r0, r0, #1          // Sumar 1 a r0
    add r1, r1, #2          // Sumar 2 a r1
    add r3, r0, r1          // Sumar r0 y r1 y almacenar el resultado en r3
    ldr r5, =50624          // Cargar el valor 50624 en r5
    add r4, r4, r5          // Sumar el valor de r5 a r4
    str r3, [r4]            // Almacenar el valor de r3 en la dirección apuntada por r4

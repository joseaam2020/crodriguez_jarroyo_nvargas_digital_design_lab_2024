.global _start
_start:

	add r0, r0, #1          // Sumar 1 a r0
    add r1, r1, #2
	str r1, [r0,#0]
	ldr r3, [r0,#0]

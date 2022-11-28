.include "m16def.inc"

start:
	  ser r24
    out DDRB,r24
    clr r24
    out DDRC,r24

    in r25,PINC
    mov r26,r25
    com r25
    andi r25,0x01	;A'
    mov r24,r26
    andi r24,0x02	;B
    lsr r24
    and r25,r24		;A'B => r25
    com r24
    andi r24,0x01	;B'
    mov r23,r26
    andi r23,0x04	;C
    lsr r23
    lsr r23 
    and r24,r23		;B'C
    mov r23,r26
    andi r23,0x08	;D
    lsr r23 
    lsr r23 
    lsr r23 
    and r24,r23		;B'CD
    or r25,r24		;A'B+B'CD
    com r25
    andi r25,0x01	;F0 res
    mov r22,r25 

    mov r25,r26
    andi r25,0x01	;A
    mov r24,r26
    andi r24,0x04	;C
    lsr r24
    lsr r24
    and r25,r24		;AC
    mov r24,r26
    andi r24,0x02	;B
    lsr r24
    mov r23,r26
    andi r23,0x08	;D
    lsr r23
    lsr r23
    lsr r23
    or r24,r23		;B+D
    and r25,r24		;(AC)(B+D)
    lsl r25
    or r25,r22		;000000F1F0
    out PORTB,r25
    rjmp start
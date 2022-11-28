.include "m16def.inc"

.org 0x0
rjmp start
.org 0x4
rjmp ISR1


start:
	ldi r21, LOW(RAMEND)
	out SPL, r21
	ldi r21, HIGH(RAMEND)
	out SPH, r21
	clr r20			;counter for interrupts
	ldi r24, (1 << ISC11)|(1 << ISC10)
	out MCUCR, r24
	ldi r24, (1 << INT1)
	out GICR, r24
	sei 

	clr r26
	out DDRA, r26
	ser r26
	out DDRC, r26
	clr r26
	out PORTC, r26
loop:
	out PORTC, r26
	;ldi r24, low(100)
	;ldi r25, high(100)
	;rcall wait_msec
	inc r26
	rjmp loop
	
ISR1: 
	 in r23, PINA
	 andi r23, 0xC0 ;keep PA7 & PA6
	 cpi r23, 0xC0	;if PA7 != 1 or PA6 != 1 do nothing
	 brne return
	 inc r20
	 out PORTB, r20
return:
	reti
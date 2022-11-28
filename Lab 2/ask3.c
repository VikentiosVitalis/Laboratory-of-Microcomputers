#include <avr/io.h>
#include <avr/interrupt.h>

unsigned char x, y, counter, dips;
ISR (INT0_vect) {
	dips = 0x00;
	x = PINA & 0x04;
	y = PINB;
	while (y!=0) {
		counter += y & 0x01;
		y = y>>1;
	}
	if (x == 0x00)	{
		while(counter > 0) {
			dips = dips<<1;
			dips = dips + 0x01;
			counter -= 1;
		}
	}
	else {
		dips = counter;
	}
	PORTC = dips;
}	

int main(void)
{
	DDRC = 0xFF;
	DDRB = 0x00;
	DDRA = 0x00;
	GICR = (1<<INT0);
	MCUCR = (1<<ISC00) | (1<<ISC01);
	asm("sei");
    while (1) 
    {
		asm("nop");
    }
}

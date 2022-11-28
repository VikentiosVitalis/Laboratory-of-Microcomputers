/*
 * ask2.1C.c
 *
 * Created: 29/10/2021 4:29:46 μμ
 * Author : Pan-Vagg
 */ 

#include <avr/io.h>

char F0, F1, x, A, B, C, D;

int main(void)
{
    DDRB = 0xFF;
	DDRC = 0x00;
    while (1) 
    {
		x = PINC;
		A = x & 0x01;
		B = (x & 0x02) >> 1;
		C = (x & 0x04) >> 2;
		D = (x & 0x08) >> 3;
		
		F0 = ~((~A&B) | (~B&C&D)) & 0x01;
		F1 = (A&C)&(B|D) & 0x01;
		F1 = (F1 << 1)|F0;
		PORTB = F1;
    }
}

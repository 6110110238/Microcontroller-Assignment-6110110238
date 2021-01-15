.INCLUDE "m328Pdef.inc"

.EQU ALL_PIN_IN = 0x00
.EQU ALL_PIN_OUT = 0xff
.DEF VAR_A = r16
.DEF VAR_B = r17

.CSEG	; code segment
.ORG 0x0000
		ldi VAR_A,ALL_PIN_OUT 	
		out DDRB,VAR_A			; set PORT_B as OUTPUT

		ldi VAR_A,ALL_PIN_IN 	
		out DDRD,VAR_A			; set PORT_D as INPUT1

		ldi VAR_B,ALL_PIN_IN 	
		out DDRC,VAR_B			; set PORT_C as INPUT2

MAIN:	; ----------------------- main ------------------------
		in VAR_A,PIND 	; READ PORT_D #INPUT1
		in VAR_B,PINC 	; READ PORT_C #INPUT2
		andi VAR_A,0x0F ; Keep lower 4 bits as INPUT 1 in VAR_A
		andi VAR_B,0x0F ; Keep lower 4 bits as INPUT 2 in VAR_B
		;------------------------------------------------------
		; if A>B will plus A with B
		; but if A<B will subtract A with B
		; and if A=B will do nothing
		; show the result via LED
		;------------------------------------------------------
		cp VAR_A,VAR_B 	; Compair VAR_A and VAR_B
		brlo MINUS 		; if VAR_A is lower than VAR_B jump to line MINUS
		breq A_EQ_B 	; if VAR_A equals to VAR_B jump to line A_EQ_B
		
POS: 	; this line will Add VAR_A and VAR_B and keep the result in VAR_A
		add VAR_A,VAR_B
		rjmp OUTPUT 	; jump to line OUTPUT for sending result to LED
		
MINUS: 	; this line will Subtract VAR_A and VAR_B and keep the result in VAR_A
		sub VAR_A,VAR_B
		rjmp OUTPUT 	; jump to line OUTPUT for sending result to LED
		
A_EQ_B:	; this line will load 0xFF to VAR_A in case VAR_A equals with VAR_B
		ldi VAR_A,0xFF

OUTPUT: out PORTB,VAR_A ; sending result to PORTB
		rjmp MAIN 		; jump to line MAIN

.DSEG	; data segment
.ESEG	; EEPROM segment




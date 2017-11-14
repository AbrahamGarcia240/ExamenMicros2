        .include "p30F4013.inc"

        .global _datoLCD
	.global _comandoLCD
	.global _busyFlag
	.global _iniLCD8bits
	.global _printLCD
	
	.EQU	RS_LCD,	    RD0
	.EQU	RW_LCD,	    RD1
	.EQU	E_LCD,	    RD2 
	.EQU	BF_LCD,	    RB7
_printLCD:
    PUSH W0
    PUSH W1
    
    MOV W0, W1
    CICLO:
	MOV.B [W1++], W0
	CP0.B W0
	BRA Z, FIN
	CALL _busyFlag
	CALL _datoLCD
	goto CICLO
	
    FIN:
    POP W1
    POP W0
    RETURN
    
    
;/**@brief ESTA RUTINA MANDA UN DATO A UN LCD 
; */
_datoLCD:
    BSET    PORTD,	#RD0
    NOP
    BCLR    PORTD,	#RD1
    NOP
    BSET    PORTD,	#E_LCD
    NOP
    MOV.B   WREG	,	PORTB
    NOP
    BCLR    PORTD,	#E_LCD
    NOP
    return


;/**@brief ESTA RUTINA MANDA UN COMANDO A UN LCD 
; */
_comandoLCD:
    BCLR    PORTD,	#RS_LCD
    NOP
    BCLR    PORTD,	#RW_LCD
    NOP
    BSET    PORTD,	#E_LCD
    NOP
    MOV.B   WREG	,	PORTB
    NOP
    BCLR    PORTD,	#E_LCD
    NOP
    return

    
 ;/**@brief ESTA RUTINA VERFICA LA BANDERA BUSY FLAG LCD 
; */
_busyFlag:
    SETM.B    TRISB
    NOP
    BSET      PORTD,	#RW_LCD
    NOP
    BCLR     PORTD,	#RS_LCD
    NOP
    BSET      PORTD,	#E_LCD
    NOP
    
PROCESA:
    BTSC    PORTB,	#RB7
    GOTO    PROCESA
    
    BCLR    PORTD,	#E_LCD
    NOP
    BCLR    PORTD,	#RW_LCD
    NOP
    CLR.B   TRISB
    NOP
    
    return
    
    
 ;/**@brief ESTA RUTINA 
 ;*/
_iniLCD8bits:
    CALL    _RETARDO15ms
    MOV	    #0X30,	W0
    CALL    _comandoLCD
    
    CALL    _RETARDO15ms
    MOV	    #0X30,	W0
    CALL    _comandoLCD
    
    CALL    _RETARDO15ms
    MOV	    #0X30,	W0
    CALL    _comandoLCD
    
    CALL    _busyFlag
    MOV	    #0X38,	W0
    CALL    _comandoLCD
    
    CALL    _busyFlag
    MOV	    #0X08,	W0
    CALL    _comandoLCD
    
    CALL    _busyFlag
    MOV	    #0X01,	W0
    CALL    _comandoLCD
    
    CALL    _busyFlag
    MOV	    #0X06,	W0
    CALL    _comandoLCD
    
    CALL    _busyFlag
    MOV	    #0X0F,	W0
    CALL    _comandoLCD
    
    return
        .include "p30F4013.inc"

        .global _RETARDO1S
	.global _RETARDO15ms
  
;/**@brief ESTA RUTINA GENERA UN RETARDO DE 1 SEG APROX
; */
_RETARDO1S: ;comenzar con guion bajo en asm para que pueda ser usada en otros modulos
	PUSH	W0  ; PUSH.D W0
	PUSH	W1
	
	MOV	#10,	    W1
CICLO2_1S:
    
	CLR	W0	
CICLO1_1S:	
	DEC	W0,	    W0
	BRA	NZ,	    CICLO1_1S	
    
	DEC	W1,	    W1
	BRA	NZ,	    CICLO2_1S
	
	POP	W1  ; POP.D W0
	POP	W0
	RETURN

_RETARDO15ms:
	PUSH W0
	PUSH W1
	
	MOV #0X240A, W0
	CICLO:
	    DEC W0, W0
	    CP0 W0
	    BRA NZ, CICLO
    
	POP W1
	POP W0
	RETURN
    



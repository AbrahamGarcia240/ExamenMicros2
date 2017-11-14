.include "p30F4013.inc"
 
.global _datoLCD
.global __INT0Interrupt

.global _uni
.global _dec
.global _cen
    
__INT0Interrupt:
    PUSH W0
    INC.B  _uni
    MOV.B  #10, W0
    CP.B   _uni
    BRA NZ, FIN_ISR_INT0
    CLR.B _uni
    INC.B _dec
    MOV.B  #10, W0
    CP.B   _dec
    BRA NZ, FIN_ISR_INT0
    CLR.B _dec
    INC.B _cen
    MOV.B  #10, W0
    CP.B   _cen
    BRA NZ, FIN_ISR_INT0
    CLR.B _cen
FIN_ISR_INT0:
    BCLR IFS0, #INT0IF
    POP W0
RETFIE



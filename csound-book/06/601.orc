sr      =      	44100
kr    	=     	4410
ksmps  	=     	10
nchnls	=		1

        instr   601     
iatt    =       p3*.1                   ; ATTACK IS 10% OF DURATION
idec    =       p3*.1                   ; DECAY IS 10% OF DURATION
ifc1    =       200                     ; Fc OF RESON 1
iq1     =       5                       ; Q OF RESON 1
ifc2    =       550                     ; Fc OF RESON 2
iq2     =       3                       ; Q OF RESON 2
kenv    linen   p4, iatt, p3, idec      ; AMPLITUDE ENVELOPE
asig    oscil   kenv, cpspch(p5), p6    ; OSCILLATOR
ares1   reson   asig, ifc1, ifc1/iq1    ; RESON1 - BANDWIDTH = Fc/Q
ares2   reson   asig, ifc2, ifc2/iq2    ; RESON2 - BANDWIDTH = Fc/Q
areso   =       ares1+ares2             ; ADD FILTERED SIGNALS
aout    balance areso, asig             ; BALANCE AGAINST ORIGINAL
        out     aout    
        endin       

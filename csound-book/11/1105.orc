
;1105.ORC   USE OF RAND AND BUZZ
;             (C) RAJMIL FISCHMAN, 1997

sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

;-------------------------------------- 
        instr 1105              ; USES RAND TO GENERATE WHITE NOISE
;-------------------------------; PARAMETER LIST
;p4  : AMPLITUDE
;p5  : NOT USED
;p6  : ATTACK
;p7  : DECAY
;-------------------------------
kenv    linen   p4,p6,p3,p7     ; ENVELOPE
asig    rand    kenv            ; NOISE SOURCE
        out     asig            ; OUTPUT
        endin


        instr 1106              ; USES BUZZ TO GENERATE A TRAIN OF PULSES
;-------------------------------; PARAMETER LIST
;p4  : AMPLITUDE
;p5  : FUNDAMENTAL
;p6  : ATTACK
;p7  : DECAY
;-------------------------------
iinh     =      int(sr/2/p5)    ; MAXIMUM NUMBER OF HARMONICS
kenv    linen   p4,p6,p3,p7     ; ENVELOPE
asig    buzz    kenv,p5,iinh,1  ; OSCILLATOR
        out     asig            ; OUTPUT
        endin




; 1109.ORC   AMPLITUDE MODULATOR
;             (C) RAJMIL FISCHMAN, 1997
sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1


;--------------------------------------
        instr 1108              ; USED TO PLAY PURE SINEWAVES
;-------------------------------; PARAMETER LIST
;p4  :AMPLITUDE
;p5  :CARRIER
;p6  :ATTACK
;p7  :DECAY
;p8  :FUNCTION TABLE
;-------------------------------
kenv    linen   p4, p6, p3, p7  ; ENVELOPE
asig    oscili  kenv, p5, p8    ; OSCILLATOR
;-------------------------------; OUTPUT
        out     asig
        endin


        instr 1109              ; SIDE BANDS ONLY
;-------------------------------; PARAMETER LIST
;p4  : AMPLITUDE
;p5  : CARRIER
;p6  : ATTACK
;p7  : DECAY
;p8  : MODULATOR
;p9  : FUNCTION
;-------------------------------
kenv    linen   p4, p6, p3, p7  ; ENVELOPE
acarr   oscili  1, p5, p9       ; CARRIER
amod    oscili  1, p8, p9       ; MODULATOR
asig    =       acarr*amod      ; MODULATION
        out     kenv*asig       ; OUTPUT
        endin

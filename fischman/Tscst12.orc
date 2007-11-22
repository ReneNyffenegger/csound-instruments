; TSCST12.ORC
;             (c) Rajmil Fischman, 1997
;-------------------------------------- 
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 13            ; DYNAMIC WAVESHAPING INSTRUMENT
                              ; TWO BEATING SOURCES
                              ; DISTORTION INDEX CHANGES ACCORDING TO
                              ; FUNCTION INDICATED BY P11
;-------------------------------             ;PARAMETER LIST
; p4 : AMPLITUDE
; p5 : PITCH
; p6 : OSCILLATOR FUNCTION
; p7 : WAVESHAPING FUNCTION
; p8 : ENVELOPE (DISTORTION INDEX) FUNCTION
;-------------------------------             ; INITIALIZATION BLOCK
  ifr       =  cpspch(p5)                         ; PITCH TO FREQ
  ioffset   =  .5                                 ; OFFSET
  ibeatfb   =  1.01*ifr                           ; BEGINNING VALUE OF BEATING FREQUENCY
  ibeatff   =  0.99*ifr                           ; FINAL VALUE OF BEATING FREQUENCY
  inobeat   =  0.8                                ; PROPORTION OF NON-BEATING OSCILLATOR
  ibeat     =  0.2                                ; PROPORTION OF NON-BEATING OSCILLATOR
;---------------------------------------
  kenv      oscil1i   0,1,p3,p8                   ; ENVELOPE (DISTORTION INDEX)
  kfreq2    line      ibeatfb, p3, ibeatff        ; FREQUENCY CHANGE       
  ain1      oscili    ioffset,ifr,p6              ; FIRST OSCILLATOR
  awsh1     tablei    kenv*ain1,p7,1,ioffset      ; WAVESHAPING OF FIRST OSCILLATOR
  ain2      oscili    ioffset, kfreq2, p6         ; SECOND OSCILLATOR
  awsh2     tablei    kenv*ain2,p7,1,ioffset      ; WAVESHAPING OF SECOND OSCILLATOR
  aout      =  kenv*p4*(inobeat*awsh1+ibeat*awsh2) ; MIX
            out       aout                        ; OUTPUT
endin

;MB2.ORC       Simple oscillator with envelope
;              Produces RISSET'S pulsating harmonics 
;              (c) Rajmil Fischman, 1997
;--------------------------------------------------- 
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 2 
;-----------------------------------         ; PARAMETER LIST
; p4: AMPLITUDE
; p5: FUNDAMENTAL
; p6: ATTACK
; p7: DECAY
; p8: FUNCTION
;-----------------------------------         ; BLOCK INITIALIZATION
  idur      =  p3                                 ; DURATION
  iamp      =  p4                                 ; AMPLITUDE
  ifreq     =  p5                                 ; FREQUENCY
  iatt      =  p6                                 ; ATTACK
  idec      =  p7                                 ; DECAY
  ifunc     =  p8                                 ; FUNCTION TABLE
;--------------------------------------------------
  kenv      linen     iamp,iatt,idur,idec         ; ENVELOPE
  aout      oscili    kenv,ifreq,ifunc            ; OSCILLATOR
            out       aout
endin

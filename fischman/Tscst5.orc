;TSCST5.ORC   Use of RAND and BUZZ
;              (c) Rajmil Fischman, 1997
;-------------------------------------- 
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr     5                             ; USES RAND TO GENERATE WHITE NOISE
;-------------------------------                       ; PARAMETER LIST
;P4  : AMPLITUDE
;P5  : NOT USED
;P6  : ATTACK
;P7  : DECAY
;-------------------------------
  kenv      linen     p4,p6,p3,p7                 ; ENVELOPE
  aout      rand      kenv                        ; NOISE SOURCE
            out       aout                        ; OUTPUT
endin


instr     6                             ;USES BUZZ TO GENERATE A TRAIN OF PULSES
;-------------------------------                       ;PARAMETER LIST
;p4  : amplitude
;p5  : fundamental
;p6  : attack
;p7  : decay
;-------------------------------
  inh1      =  int(sr/2/p5)                       ; MAXIMUM NUMBER OF HARMONICS
  kenv      linen     p4,p6,p3,p7                 ; ENVELOPE
  aout      buzz      kenv,p5,inh1,1              ; OSCILLATOR
            out       aout                        ; OUTPUT
endin



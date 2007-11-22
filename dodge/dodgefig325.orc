
;;; GENERATION OF NOISE BANDS BY RING MODULATION ;;; FIGURE 3.25 FROM DODGE & JERSE, P.92 

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  kramp     linseg    0,p3/2,p4,p3/2,0
  krcps     =  p5*.05
  kamp      randi     kramp,krcps
  kfreq     =  p5
  aosc      oscil     kamp,kfreq,1
  aout      =  aosc
            out       aout
endin


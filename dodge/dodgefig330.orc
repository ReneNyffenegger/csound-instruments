;;; RING-MODULATION INSTRUMENT BASED ON RISSET ;;; FIGURE 3.30 FROM DODGE & JERSE, P.98 

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1
  kamp1     linseg    0,p3/2,p4,p3/2,0
  kfreq1    =  p5
  asig1     oscil     kamp1,kfreq1,1
  kamp2     =  p6
  kfreq2    =  p7
  asig2     oscil     kamp2,kfreq2,2
  aout      =  asig1*asig2
            out       aout
endin


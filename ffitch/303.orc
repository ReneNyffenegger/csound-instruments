  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr     33
  iamp      =  p4
  ifrq      =  cpspch(p5)
;                   AMP,   FREQ,  JET, ATT, DTK, NGAIN,  VFRQ, VAMT,TAB, LFRQ
  asig      wgflute   iamp,  ifrq, 0.32, 0.1, 0.1,   0.15, 5.925, 0.05,  1,  50
            out       asig
endin                     

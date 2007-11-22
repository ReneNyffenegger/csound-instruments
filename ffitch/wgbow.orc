  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr   3
  kv        linseg    0, 0.5, 0, 1, 1, p3-0.5, 1
;                   AMP,     FREQ,PRES,RAT,    VFRQ,    VGN, TAB, LFREQ
  a1        wgbow     ampdb(p4), cpspch(p5), p6, p7, p8, kv*p9,  p10, p11
            out       a1
endin

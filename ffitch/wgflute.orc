  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr   2
;                   AMP,       FREQ,        JET,  ATT, DTK, NGAIN, VFRQ, VAMT, TAB, LFRQ
  a1        wgflute   ampdb(p4), cpspch(p5),   p6,   p7,  p8,  p9,     p10,  p11, p12,  p13
            out       a1
endin  

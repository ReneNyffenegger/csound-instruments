  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1

  kenv      oscil     p4, 1 / p3, 2
  kpenv     line      p6, p3, 1

  a1        oscil     kenv,   p5 * kpenv, 1
            out       a1
endin

instr 2

  ke1       linseg    0,p4,p5,p6,p7,p8,p9,p10,p11
  ke2       expseg    p12,p13,p14,p15,p16
    
  a1        oscil     ke1,ke2,1
            out       a1
endin



instr   5
  a1        linseg    0,0.01,20000,p3-0.01,20000,0.01,0,1,0
  a2        expon     20,p3,176400
  a3        oscil     a1,a2,p4
            out       a3
endin

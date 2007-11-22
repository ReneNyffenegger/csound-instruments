instr 4
  iharm     =  p6
  a1        linseg    0,0.05,10000,p3-0.1,10000,0.05,0,1,0
  afreq     expon     p4,p3,p5
  a2        buzz      1,afreq,iharm,1,-1
            out       a1*a2
endin

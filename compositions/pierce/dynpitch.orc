; Dynamic pitch shift instrument

instr 1  


  kenv      oscil     20000,1/p3,2
  aindx     line      p4,p3,p3+p4
  asig      tablei    aindx*sr,1

            outs      asig*kenv ,  asig*kenv
        
endin

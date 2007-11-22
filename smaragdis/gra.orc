  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1

  kgl1      oscil     cpspch(p4),1/p3,2
  kv        randh     1,      10

  a         fof       20000,kgl1+kv,650,1,40,.003,.01,.007,4,1,1,p3
        
            out       a/2
endin

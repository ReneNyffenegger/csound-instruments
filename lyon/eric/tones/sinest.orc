  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

;i1 0 dur freq ampDb
instr 1
  igain     =  10000
  a1        oscil     10000,440,1
  a2        oscil     10000,731,1
            outs      a1, a2
endin

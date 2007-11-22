  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

  i1        ftgen     1, 0, 1024, 10, 1

instr 1
  a1        oscil     32000, 400, 1
            outs      a1, a1
endin

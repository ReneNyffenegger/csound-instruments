
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  asig1     soundin   1,0
  asig2     soundin   2,0
  amod      =  asig1*(asig2/32768.)
            out       amod
endin

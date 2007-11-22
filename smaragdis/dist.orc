  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  igain     =  1.5
  ims       =  100

  ag1       oscil     igain, 1/9.05, 1
  ag2       table     ag1+igain/2, 2, 1
  a1        butterlp  ag2*30000, sr/4
            out       a1
endin

  sr        =  48000
  kr        =  480
  ksmps     =  100
  nchnls    =  1

instr 1
  ampenv    linseg    1,p3,0
  ampenv    =  ampenv ^ .5
  a1        oscili    1,p5,1
            out       a1*ampenv*p4
endin

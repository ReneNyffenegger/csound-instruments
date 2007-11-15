
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1


instr 1
  aenv      oscili    p5, 1./p3, 2
  asig      oscili    aenv, p4, 1, p6
            out       asig
endin

  sr        =  44100
  kr        =  4410
  ksmps     =  10

instr 1
  ifile     =  p9
  iincr     =  p4 * (sr/(ftlen(ifile)))
  iamp      =  p5
  iphase    =  p6
  iatk      =  p7
  idk       =  p8
  isust     =  p3-(iatk+idk)
  aenv      linseg    0,iatk, iamp, isust, iamp, idk, 0
  asig      oscili    aenv, iincr, ifile, iphase
            out       asig
endin

instr 2
  ifile     =  p4
  iatk      =  .01
  idk       =  .01
  isust     =  p3-(iatk+idk)
  iincr     =  p6 * (sr/(ftlen(ifile)))
  iamp      =  p5
        ;aenv oscili iamp,1/p3, 99
  aenv      linseg    0,iatk, iamp, isust, iamp, idk, 0
  asig      oscili    aenv, iincr, ifile
            out       asig
endin

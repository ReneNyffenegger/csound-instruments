  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  ifile     =  p4
  iskip     =  p5
  igain     =  p6
  garaw     soundin   ifile, iskip
  garaw     =  garaw * igain
endin

instr 2
  igain     =  1.0
  idel      =  p4
  idepth    =  p5
  imax      =  idel*2
  iatk      =  .05
  idk       =  .05
  isust     =  p3-(iatk+idk)

  aenv      linseg    0, iatk, igain, isust, igain, idk, 0.0
  asig      =  garaw
  addl      delayr    imax
  atap      deltap    idel
  asig      =  asig + (atap*idepth)
            delayw    asig
            out       asig*aenv
endin
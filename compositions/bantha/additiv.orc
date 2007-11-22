  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  2

instr 1
  iamp      =  p6
  ifrq      =  p4
  ipan      =  p5
  kenv      oscil1i   0, 1, p3, 10
  a1        oscili    iamp*kenv, ifrq, 1
  ilt       tablei    (1 - ipan), 100, 1
  irt       tablei    ipan, 100, 1
            outs      a1*ilt, a1*irt
endin

instr          1
  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc/2, 0, .2, .01
  a1        expseg    .2,2.3,1,1-.01,.001
  a1        oscili    a1,knote,3

  a2        oscili    10000,1500,2
            out       (a1*a2)*kgate
endin

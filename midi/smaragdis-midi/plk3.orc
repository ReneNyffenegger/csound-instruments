instr     2
  icps      cpsmidi   
  k1        linen     4000, 0, 1, .1
  k2        line      0, 1, 10
  a1        oscil     k1, icps-k2, 1
  a2        tone      a1, 110
  a3        pluck     1000, icps-k2, 440, 0, 3, .5
  imax      ampmidi   1, 100
  kgate     linenr    imax, 0, 1, .01
            out       a2+a3*kgate
endin

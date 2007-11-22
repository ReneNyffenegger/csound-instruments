instr 1                                 ; SLOW STRINGS (SUB)
  kfreq     cpsmidib  
  iveloc    veloc     
  kgate     linenr    iveloc/128, 0, .5, .1

  k1        linseg    0, .5, 32000, .5, 25000
  k2        oscil     kfreq*.005, 3, 1
  a1        oscil     k1, kfreq + k2, 3
  a2        oscil     k1, kfreq + k2 + 1, 3
  a3        oscil     k1, 2*(kfreq + k2), 3
  a1        butterlp  a1 + a2 + a3, 1200
            out       a1/4 * kgate
endin

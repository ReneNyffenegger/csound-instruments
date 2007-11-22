; RISSET "HARMONY/TIMBRE" #550
instr          1
  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc/2, 0, .2, .01
  k1        envlpx    36, .01, .6, .6, 1, 1, .01
  a1        oscili    k1, knote, 2
  a2        oscili    1000, knote+7, 3
            out       (a1 * a2)*kgate
endin

instr          2
  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc/2, 0, .2, .01
  i1        =  1/10
  k1        oscil     4000, i1, 4
  a1        oscili    k1, knote, 2
            out       a1*kgate
endin

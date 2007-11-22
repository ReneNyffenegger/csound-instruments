instr          1
  icps      cpsmidi   
  iamp      ampmidi   512, 100
  iscale    =  iamp * 30
  kamp      linseg    0, .25, iamp, .25, iamp-100, 5, 0
  awtosc    oscil     kamp, icps, 1
  aout      table     awtosc + 512, 2
  aeg       linenr    iscale, .01, .5, .01
            out       aout * aeg
endin

instr     2
  icps      cpsmidi   
  iamp      ampmidi   8192, 100
  iscale    =  iamp * .5
  k1        expseg    .01, .1, iamp, .03, iamp-1000, 5, .01
  a1        oscili    k1, icps, 1
  a1        tablei    a1, 3
  aeg       linenr    iscale, .01, .5, .01
            out       a1 * aeg
endin

instr     3
  icps      cpsmidi   
  iamp      ampmidi   256, 100
  iscale    =  iamp*20
  kamp      linseg    0, .01, iamp, .35, iamp-30, 5, 0
  ktabmov   linseg    0, .01,  512, .35, 1024, 2, 1536, 5, 0
  awtosc    oscil     kamp, icps, 1
  aout      table     awtosc + 256 + ktabmov, 4, 0, 0, 1
  aeg       linenr    iscale, .01, .5, .01
            out       aout * aeg
endin

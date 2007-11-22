instr   1                                    ; WAVESHAPING
  icps      cpsmidi   
  iamp      ampmidi   256, 100
  iscale    =  iamp*20
  kamp      linseg    0, .01, iamp, .35, iamp-30, 5, 0
  ktabmov   linseg    0, .01,  512, .35, 1024, 2, 1536, 5, 0
  awtosc    oscil     kamp, icps, 1
  asig      table     awtosc + 256 + ktabmov, 5, 0, 0, 1
  aeg       linenr    iscale, .01, .5, .01
            out       asig * aeg
endin

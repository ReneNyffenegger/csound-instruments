instr   1                                         ;FM SQUARE SYNTH
  icps      cpsmidi   
  iamp      ampmidi   10000, 100
  iscale    =  iamp / 2000
  iattk     =  .1
  keg       expseg    .001, iattk, 1, .1, .6, .2, .9, .3, .6, 1, .001, 999, .001
  keg       linenr    iamp * keg, iattk, .5, .25
  kmeg      expseg    .001, iattk, iscale, .3, .9, .1, .6, 1, .001, 999, .001
  asig      foscil    keg, icps, 1, 2.002, kmeg, 1
            out       asig
endin

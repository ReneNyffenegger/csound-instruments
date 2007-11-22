instr          1
  icps      cpsmidi   
  iamp      ampmidi   5000, 4
  kamp      expon     iamp, 5, iamp/icps          ;FREQ-DEPENDENT OVERALL DECAY
  amp       linenr    kamp, .01, .333, .05
  asig      oscil     amp, icps, 1
            out       asig
endin

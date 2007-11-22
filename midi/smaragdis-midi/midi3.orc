instr 1                            ; MIDI ORGAN WITH VIBRATO
  icps      cpsmidi   
  iamp      ampmidi   10000, 100
  aeg       linenr    iamp, .2, 2, .01
  kvib      oscil     icps * .017, 6, 1
  asig      oscil     aeg, icps + kvib, 2             
            out       asig
endin

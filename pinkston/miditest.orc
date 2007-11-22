;===================================
;Example of a simple MIDI instrument
;===================================
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

            massign   1,10                        ;map midi channel 1 to instr 10
        
instr 10
  iamp      ampmidi   5000
  icps      cpsmidi   
  agate     linenr    iamp,.01,.1,.01
  asig      oscil     agate,icps,1
            out       asig
endin

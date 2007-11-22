;=======================================
;A slightly more complex MIDI instrument
;that uses continuous controller 7 to 
;adjust the final signal amplitude
;===================================
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

            massign   1,10                        ;assign MIDI channel 1 to instrument 10
;       ctrlinit        1,7,80  ;initialize controller 7 on chan 1 to 80        
        
instr           10
  kvol      midictrl  7,0,1                       ;scale MIDI ctrl 7 to between 0-1
  kscale    table     kvol,2,1                    ;map on an exponential curve (fn2)
  iamp      ampmidi   5000
  icps      cpsmidi   
  agate     linenr    iamp,.01,.1,.01
  asig      oscil     agate,icps,1
            out       asig*kscale
endin

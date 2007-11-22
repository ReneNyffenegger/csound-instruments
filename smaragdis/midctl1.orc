;MIDI CONTROLLERS - EXAMPLE.ORC

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

instr 1
                    
  kval1     midictrl  1
          
  kcps      cpsmidib  
  icps      cpsmidi   
  iamp      ampmidi   5000, 2
  kbend     pchbend   100  
  kamp      expon     iamp, 5, iamp/icps          ; FREQ-DEPENDENT OVERALL DECAY
  amp       linenr    kamp, .01, .333, .05
  a1        oscil     amp, kcps+kval1, 1

            outs      a1*(kval1/127), a1*(1-(kval1/127))

endin


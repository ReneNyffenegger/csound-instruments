  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1


instr     2012                ; AM SCI-FI VOICE EXAMPLE
  afmod     expseg    8000, p3, 40                ; VARY CARRIER FREQUENCY
  a1        soundin   "Hamlet.aif"
  a2        oscil     1, afmod, 1                 ; GENERATE CARRIER
            out       a1*a2                       ; MODULATE
endin
                                

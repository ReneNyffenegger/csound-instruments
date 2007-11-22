instr     12        ; AM SCI-FI VOICE EXAMPLE
  afmod     expseg    8000,p3,40                  ; VARY CARRIER FREQUENCY
  a1        soundin   "hamlet.aif"
  a2        oscil     1,afmod,1                   ; GENERATE CARRIER
            out       a1*a2                       ; MODULATE
endin

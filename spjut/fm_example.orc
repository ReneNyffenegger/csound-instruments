
instr     11 ;FM SCI-FI VOICE EXAMPLE
  a1        soundin   "hamlet.aif"
  a3        line      0,p3,0.4                    ; MODULATION INDEX
  a2        oscil     10000,256-a3*a1,1           ; MODULATE
            out       a2
endin                    


sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr      2011               ; FM SCI-FI VOICE EXAMPLE
a1        soundin   "Hamlet.aif"
a3        line      0, p3, 0.4           ; MODULATION INDEX
a2        oscil     10000, 256-a3*a1, 1 ; MODULATE
          out       a2
          endin

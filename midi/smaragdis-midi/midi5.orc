  ginsr     =  44100
  gisize65  =  ginsr/65536

instr 1                                                     ; WAVETABLE EL. PIANO
  inote     cpsmidi                               ; GET NOTE
  ivel      veloc                                 ; GET VELOCITY
  kgate     linenr    ivel/127, 0, .2, .01        ; GATE
  a1        oscil     10000, (inote/440) * gisize65, 11
            out       a1 * kgate
endin

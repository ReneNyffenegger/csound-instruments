  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr    1 ; Rhythmic Gate / DJ 'Transformer'

  ilevl     =  p4                                 ; Output level
  itabl1    =  p5                                 ; Gate pattern table no.
  itabl2    =  p6                                 ; Gate shape table no.
  itime     =  1/p3                               ; Note length

  ain       soundin   "sample1.wav"

  kind      phasor    itime                       ; 0 to 1 index ramp
  kgate1    table     kind, 1, itabl1             ; Read gate pattern
  kgate     oscil     kgate1, 16*itime, itabl2    ; Read gate shape
  kgate     port      kgate, .0001                ; Slew gate edges
            out       ain*kgate                   ; Gate output

endin
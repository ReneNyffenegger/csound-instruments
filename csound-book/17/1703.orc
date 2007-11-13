  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1


instr     1703 
  kphrase   linen     1, p3*.5, p3, p3*.5         ; GRADUAL RISE&FALL IN AMP OVER p3
  kdur      line      .1, p3, 1                   ; kdur CHANGES FROM .1 TO 1 OVER p3
start:
            timout    0, i(kdur), continue        ; BRANCH TO CONTINUE FOR kdur SECS,
            reinit    start                       ; THEN REINIT ALL, BEGINNING WITH
continue:
                                    ; ... THE TIMOUT
  kgate     oscil1    0, p4, .1, 2                ; f2 HAS ENVSHAPE; DUR FIXED AT .1 
  asig      oscili    kgate, 1000, 1              ; MAKE a1 KHz BEEP TONE, USING f1
            out       asig*kphrase                ; APPLY THE OVERALL PHRASE DYNAMIC
endin                              ; REINITIALIZATION STOPS HERE

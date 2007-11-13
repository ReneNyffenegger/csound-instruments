  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1


instr     1701 
start:
            timout    0, .25, continue            ; BRANCH TO CONTINUE FOR .25secs, THEN...
            reinit    start                       ; REINIT ALL, BEGINNING WITH THE TIMOUT
continue:           
  kgate     linen     p4, .02, .25, .1            ; MAKE A .25-SECOND LINEAR ENVELOPE
  asig      oscili    kgate, 1000, 1              ; MAKE A 1 kHz BEEP TONE, USING f1
            out       asig 
endin                         ; REINIT WILL END HERE, IF NO RIRETURN

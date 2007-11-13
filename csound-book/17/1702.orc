sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr     1702      
kgate     oscil     p4, 4, 2            ; ifn 2 HAS LINEAR ENVELOPE SHAPE; AMP=p4
asig      oscili    kgate, 1000, 1      ; MAKE A 1 KHz BEEP TONE, USING FUNCTION 1
          out       asig 
          endin


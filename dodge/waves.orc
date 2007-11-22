; INSTRUMENT FOR THE WAVES

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

;p4            =         freq expressed in octave.point.decimal notation
;p5            =         amp

instr     1
  i1        =  cpsoct(p4)                         ;CONVERT OCT.NOTATION TO HZ
  a1        oscili    p5,i1,1                     ;USE OSCILI FOR CLEAN SOUND
  aenv      linseg    0,p3/2,1,p3/2,0,.01,0       ;TACK ON GUARD POINTS TO AVOID CLICKS
            out       aenv*a1                     ;MULTIPLY AUDIO SIGNAL BY AMP ENVELOPE
endin


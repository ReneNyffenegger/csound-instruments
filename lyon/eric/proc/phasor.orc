  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 2
  gax1      =  0
  gax2      =  0
  gay1      =  0
  gay2      =  0
endin

instr 1
  ispeed    =  5.0
  ifreqband =  1500
  iq        =  30
  ipi       =  3.14159265359
  impi      =  ipi * -1.0
  itwopi    =  ipi * 2.0
  imtwopi   =  itwopi * -1.0
  ain       soundin   p4,p5
  kf        oscil     .4, ispeed, 1
  kf        =  (kf + .6) * ifreqband
  ka        =  2 * cos( itwopi * kf) * exp( (impi * kf)/iq )
  kb        =  exp( (imtwopi * kf)/iq )
            display   ka, .5
  aout      =  ain + (gax1*ka) + (gax2 * -kb) + (gay1*kb) + (gay2* -ka)
  gax1      delay1    ain
  gay1      delay1    aout        
  gax2      delay1    gax1
  gay2      delay1    gay1
            out       aout
endin
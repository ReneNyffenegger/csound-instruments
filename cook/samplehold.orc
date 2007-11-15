  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  1

instr    1 ; Audio rate Sample & Hold

  ilevel    =  p4                                 ; Output level
  irate1    =  p5                                 ; Start S&H rate
  irate2    =  p6                                 ; End S&H rate

  krate     line      irate1, p3, irate2
  ain       soundin   "sample1.wav"
  agate     oscil     1, krate, 1
  ash       samphold  ain, agate

            out       ash*ilevel

endin
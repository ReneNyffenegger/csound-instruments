  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr    1 ; lowpass (+)Signal, highpass (-)Signal (Unusual distortion)

  ilevl     =  p4                                 ; Output level
  ifreq     =  p5                                 ; Crossover frequency in Hz

  ain       soundin   "sample1.wav"

  aflt1     butterlp  ain, ifreq
  aflt2     butterhp  ain, ifreq

  apos      limit     aflt1, 0, 32768
  aneg      limit     aflt2,-32768, 0

  amix      =  apos + aneg

            out       amix*ilevl
  
endin

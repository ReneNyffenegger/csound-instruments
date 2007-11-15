  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr    1 ; Audio FM Of Sample.

  p3        =  p3 + .1                            ; Adjust length to compensate for delay
  ilevl     =  p4                                 ; Output level
  idepth    =  p5/1000                            ; Convert depth to ms
  ifreq1    =  p6                                 ; Start mod freq
  ifreq2    =  p7                                 ; End mod freq
  iwave     =  p8                                 ; Modulation waveform
  ifm       =  p9/100000                          ; Self-modulation

  ain       soundin   "sample1.wav"

  ksweep    expseg    ifreq1, p3, ifreq2
  afm1      oscili    idepth, ksweep, iwave
  afm2      =  ain*ifm
  ax        delayr    .1
  aout      deltapi   .05 + afm1 + afm2
            delayw    ain
            out       aout*ilevl

endin

  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  2

instr    1 ; Stereo Flanger with normal and cross feedback

  ilevl     =  p4                                 ; Output level
  idelay    =  p5/1000                            ; Delay in ms
  idepth    =  p6/2000                            ; LFO depth in ms
  irate1    =  p7                                 ; L LFO rate
  irate2    =  p8                                 ; R LFO rate
  iphase    =  p9/360                             ; R LFO phase
  iwave     =  p10                                ; LFO waveform
  ifdbk1    =  p11                                ; L feedback
  ifdbk2    =  p12                                ; R feedback
  ixfdbk    =  p13                                ; X feedback
  imix      =  p14                                ; Mix: 0=Input 1=Flange
  imax      =  idepth + idelay + .1
  adel1     init      0
  adel2     init      0

  ain       soundin   "sample1.wav"

  asig1     =  ain + ixfdbk*adel2
  asig2     =  ain + ixfdbk*adel1
  alfo1     oscili    idepth, irate1, iwave
  alfo1     =  alfo1 + idepth
  alfo2     oscili    idepth, irate2, iwave, iphase
  alfo2     =  alfo2 + idepth
  aflange1  flanger   asig1, alfo1 + idelay, ifdbk1, imax
  aflange2  flanger   asig2, alfo2 + idelay, ifdbk2, imax
            outs1     (aflange1*imix + ain*(1 - imix))*ilevl
            outs2     (aflange2*imix + ain*(1 - imix))*ilevl

endin

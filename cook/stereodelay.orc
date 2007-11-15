  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  2

instr    1 ; Stereo delay with cross-feedback

  ilevl     =  p4                                 ; Output level
  idelay1   =  p5/1000                            ; L delay in ms
  idelay2   =  p6/1000                            ; R delay in ms
  ifdbk1    =  p7                                 ; L feedback
  ifdbk2    =  p8                                 ; R feedback
  ifdbkx    =  p9                                 ; X Feedback
  ifreq1    =  p10                                ; L cutoff
  ifreq2    =  p11                                ; R cutoff
  imix      =  p12                                ; Mix: 0=Dry 1=Delay
  afdbk1    init      0
  afdbk2    init      0

  ain       soundin   "sample1.wav"

  ain1      =  ain + afdbk1*ifdbk1 + afdbk2*ifdbkx
  ain2      =  ain + afdbk2*ifdbk2 + afdbk1*ifdbkx
  adelay1   delay     ain1, idelay1
  adelay2   delay     ain2, idelay2
  adelay1   butterlp  adelay1, ifreq1
  adelay2   butterlp  adelay2, ifreq2
  afdbk1    =  adelay1
  afdbk2    =  adelay2
  aout1     =  adelay1*imix + ain*(1 - imix)
  aout2     =  adelay2*imix + ain*(1 - imix)
            outs1     aout1*ilevl
            outs2     aout2*ilevl

endin

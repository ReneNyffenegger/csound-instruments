  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

instr    1 ; Stereo Harmoniser with Cross Feedback

  ilevl     =  p4                                 ; Output level
  ishift1   =  p5/120                             ; L Shift in 1/100th semitones +/-
  idelay1   =  p6/1000                            ; L Delay in ms
  ifdbk1    =  p7                                 ; L feedback
  ishift2   =  p8/120                             ; R Shift in 1/100th semitones +/-
  idelay2   =  p9/1000                            ; R Delay in ms
  ifdbk2    =  p10                                ; R feedback
  ifdbkx    =  p11                                ; X feedback
  idelay    =  p12/1000                           ; Base delay time in ms
  imix      =  p13                                ; Mix: 0=Dry 1=Harmonized
  imin      =  1/kr                               ; Minimum delay
  p3        =  p3 + idelay                        ; Compensate for base delay
  afdbk1    init      0                           ; Initialize L feedback
  afdbk2    init      0                           ; Initialize R feedback

  ain       soundin   "speech1.wav"

  ain1      =  ain + afdbk1*ifdbk1 + afdbk2*ifdbkx ; Sum L input sources
  ain2      =  ain + afdbk2*ifdbk2 + afdbk1*ifdbkx ; Sum R input sources
  asaw1     phasor    ishift1, 1                  ; L Saw   0 degrees
; asaw2    phasor  ishift1, 1, .5            ; L Saw 180 degrees
  asaw2     phasor    ishift1, .5                 ; L Saw 180 degrees
  asaw3     phasor    ishift2, 1                  ; R Saw   0 degrees
; asaw4    phasor  ishift2, 1, .5            ; R Saw 180 degrees
  asaw4     phasor    ishift2, .5                 ; R Saw 180 degrees
  ax        delayr    imin + idelay               ; Create delay line
  atap1     deltap3   imin + asaw1*idelay         ; L Tap 1
  atap2     deltap3   imin + asaw2*idelay         ; L Tap 2
            delayw    ain1                        ; Write L input into delay
  ay        delayr    imin + idelay               ; Create delay line
  atap3     deltap3   imin + asaw3*idelay         ; R Tap 1
  atap4     deltap3   imin + asaw4*idelay         ; R Tap 2
            delayw    ain2                        ; Write R input into delay
  awin1     oscili    1, ishift1, 1               ; L Window   0 degrees
  awin2     oscili    1, ishift1, 1, .5           ; L Window 180 degrees
  awin3     oscili    1, ishift2, 1               ; R Window   0 degrees
  awin4     oscili    1, ishift2, 1, .5           ; R Window 180 degrees
  ahrm1     =  atap1*awin1 + atap2*awin2          ; Sum L taps
  ahrm2     =  atap3*awin3 + atap4*awin4          ; Sum R taps
  adelay1   delay     ahrm1, idelay1              ; L Delay
  adelay2   delay     ahrm2, idelay2              ; R Delay
  afdbk1    =  adelay1                            ; L feedback
  afdbk2    =  adelay2                            ; R feedback
  aout1     =  ahrm1*imix + ain*(1 - imix)        ; L mix
  aout2     =  ahrm2*imix + ain*(1 - imix)        ; R mix
            outs1     aout1*ilevl                 ; L level and output
            outs2     aout2*ilevl                 ; R level and output

endin
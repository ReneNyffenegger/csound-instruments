  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr    1 ; Waveshape Distortion Animator

            seed      0                           ; Seed random nuber generators
  ilevl     =  p4*4096                            ; Output level
  idepth    =  p5                                 ; Modulation depth

  ain       soundin   "sample1.wav"

  ain       =  ain/4096                           ; Scale input
  a01       limit     ain, -8, -7                 ; Isolate  1st 16th of input
  a02       limit     ain, -7, -6                 ; Isolate  2nd 16th of input
  a03       limit     ain, -6, -5                 ; Isolate  3rd 16th of input
  a04       limit     ain, -5, -4                 ; Isolate  4th 16th of input
  a05       limit     ain, -4, -3                 ; Isolate  5th 16th of input
  a06       limit     ain, -3, -2                 ; Isolate  6th 16th of input
  a07       limit     ain, -2, -1                 ; Isolate  7th 16th of input
  a08       limit     ain, -1,  0                 ; Isolate  8th 16th of input
  a09       limit     ain,  0,  1                 ; Isolate  9th 16th of input
  a10       limit     ain,  1,  2                 ; Isolate 10th 16th of input
  a11       limit     ain,  2,  3                 ; Isolate 11th 16th of input
  a12       limit     ain,  3,  4                 ; Isolate 12th 16th of input
  a13       limit     ain,  4,  5                 ; Isolate 13th 16th of input
  a14       limit     ain,  5,  6                 ; Isolate 14th 16th of input
  a15       limit     ain,  6,  7                 ; Isolate 15th 16th of input
  a16       limit     ain,  7,  8                 ; Isolate 16th 16th of input
  k01       randi     idepth, 3.00                ; Generate random modulation
  k02       randi     idepth, 3.70                ; Generate random modulation
  k03       randi     idepth, 4.21                ; Generate random modulation
  k04       randi     idepth, 5.21                ; Generate random modulation
  k05       randi     idepth, 3.55                ; Generate random modulation
  k06       randi     idepth, 4.71                ; Generate random modulation
  k07       randi     idepth, 4.44                ; Generate random modulation
  k08       randi     idepth, 8.07                ; Generate random modulation
  k09       randi     idepth, 5.01                ; Generate random modulation
  k10       randi     idepth, 7.70                ; Generate random modulation
  k11       randi     idepth, 5.55                ; Generate random modulation
  k12       randi     idepth, 6.75                ; Generate random modulation
  k13       randi     idepth, 8.33                ; Generate random modulation
  k14       randi     idepth, 7.11                ; Generate random modulation
  k15       randi     idepth, 2.88                ; Generate random modulation
  k16       randi     idepth, 6.66                ; Generate random modulation
  kpos      =  8/(k01 + k02 + k03 + k04 + k05 + k06 + k07 + k08 + 8*idepth)
  kneg      =  8/(k09 + k10 + k11 + k12 + k13 + k14 + k15 + k16 + 8*idepth)
  a01       =  (a01 + 7)*(k01 + idepth)           ; Remove offset and modulate
  a02       =  (a02 + 6)*(k02 + idepth)           ; Remove offset and modulate
  a03       =  (a03 + 5)*(k03 + idepth)           ; Remove offset and modulate
  a04       =  (a04 + 4)*(k04 + idepth)           ; Remove offset and modulate
  a05       =  (a05 + 3)*(k05 + idepth)           ; Remove offset and modulate
  a06       =  (a06 + 2)*(k06 + idepth)           ; Remove offset and modulate
  a07       =  (a07 + 1)*(k07 + idepth)           ; Remove offset and modulate
  a08       =  a08*(k08 + idepth)                 ; Modulate
  a09       =  a09*(k09 + idepth)                 ; Modulate
  a10       =  (a10 - 1)*(k10 + idepth)           ; Remove offset and modulate
  a11       =  (a11 - 2)*(k11 + idepth)           ; Remove offset and modulate
  a12       =  (a12 - 3)*(k12 + idepth)           ; Remove offset and modulate
  a13       =  (a13 - 4)*(k13 + idepth)           ; Remove offset and modulate
  a14       =  (a14 - 5)*(k14 + idepth)           ; Remove offset and modulate
  a15       =  (a15 - 6)*(k15 + idepth)           ; Remove offset and modulate
  a16       =  (a16 - 7)*(k16 + idepth)           ; Remove offset and modulate
  apos      =  (a01 + a02 + a03 + a04 + a05 + a06 + a07 + a08)*kpos
  aneg      =  (a09 + a10 + a11 + a12 + a13 + a14 + a15 + a16)*kneg
            out       (apos + aneg)*ilevl         ; Sum, level and output

endin
; PANNING TAP BASED STEREO REVERB : MONO INPUT ONLY

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

  gigain    =  1
  gipiotwo  =  1.571

  gil1      =  sin(0)
  gil2      =  sin((1/5) * gipiotwo)
  gil3      =  sin((2/5) * gipiotwo)
  gil4      =  sin((3/5) * gipiotwo)
  gil5      =  sin((4/5) * gipiotwo)
  gil6      =  sin((1) * gipiotwo)
  gir1      =  cos(0)
  gir2      =  cos((1/5) * gipiotwo)
  gir3      =  cos((2/5) * gipiotwo)
  gir4      =  cos((3/5) * gipiotwo)
  gir5      =  cos((4/5) * gipiotwo)
  gir6      =  cos((1) * gipiotwo)

instr 1

  iorig     =  p7
  irev      =  1-iorig
  arawsig   soundin   p4,p5
  arawsig   =  arawsig * p6 * gigain
  aline1    delayr    1.2
  atap1     deltap    .1
  atap2     deltap    .3
  atap3     deltap    .5
  atap4     deltap    .4
  atap5     deltap    .2
            delayw    arawsig
  kenv1     randi     .49,3,.666
  kenv2     randi     .49,3.1,.555
  kenv3     randi     .49,3.2,.444
  kenv4     randi     .49,3.3,.333
  kenv5     randi     .49,3.4,.222
  kenv1     =  kenv1 + .5
  kenv2     =  kenv2 + .5
  kenv3     =  kenv3 + .5
  kenv4     =  kenv4 + .5
  kenv5     =  kenv5 + .5
  atap1     =  atap1 * kenv1
  atap2     =  atap2 * kenv1
  atap3     =  atap3 * kenv1
  atap4     =  atap4 * kenv1
  atap5     =  atap5 * kenv1
  aleft     =  (atap1*gil1)+(atap2*gil2)+(atap3*gil3)+(atap4*gil4)+(atap5*gil5)
  aright    =  (atap1*gir1)+(atap2*gir2)+(atap3*gir3)+(atap4*gir4)+(atap5*gir5)
  aleftout  =  (aleft*irev)+(arawsig*iorig)
  arightout =  (aright*irev)+(arawsig*iorig)
            outs      aleftout,arightout
endin

instr 100
endin

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2
  gipiotwo  =  1.571
; mono in, stereo out - allpass reverb with spatialized resonance
instr 1
  il1       =  .55
  il2       =  .15
  il3       =  .65
  il4       =  .25
  il5       =  .75
  il6       =  .35
  il7       =  .85
  il8       =  .45

  gil1      =  sin(il1 * gipiotwo)
  gil2      =  sin(il2 * gipiotwo)
  gil3      =  sin(il3 * gipiotwo)
  gil4      =  sin(il4 * gipiotwo)
  gil5      =  sin(il5 * gipiotwo)
  gil6      =  sin(il6 * gipiotwo)
  gil7      =  sin(il7 * gipiotwo)
  gil8      =  sin(il8 * gipiotwo)
  gir1      =  cos(il1 * gipiotwo)
  gir2      =  cos(il2 * gipiotwo)
  gir3      =  cos(il3 * gipiotwo)
  gir4      =  cos(il4 * gipiotwo)
  gir5      =  cos(il5 * gipiotwo)
  gir6      =  cos(il6 * gipiotwo)
  gir7      =  cos(il7 * gipiotwo)
  gir8      =  cos(il8 * gipiotwo)

  icf1      =  100
  icf2      =  200
  icf3      =  400
  icf4      =  800
  icf5      =  1600
  icf6      =  3200
  icf7      =  6400
  icf8      =  12800
  ibfac     =  .6
  ibw1      =  icf1 * ibfac
  ibw2      =  icf2 * ibfac
  ibw3      =  icf3 * ibfac
  ibw4      =  icf4 * ibfac
  ibw5      =  icf5 * ibfac
  ibw6      =  icf6 * ibfac
  ibw7      =  icf7 * ibfac
  ibw8      =  icf8 * ibfac
  ilpt1     =  .037
  ilpt2     =  .047
  ilpt3     =  .0513
  ilpt4     =  .0638
  ilpt5     =  .0821
  ilpt6     =  .0916
  ilpt7     =  .114
  ilpt8     =  .237
  irvt1     =  3.
  irvt2     =  2.13
  irvt3     =  2.27
  irvt4     =  1.56
  irvt5     =  1.1
  irvt6     =  .8
  irvt7     =  .4
  irvt8     =  .2
  amono     soundin   p4,p5
  arev1     alpass    amono, irvt1, ilpt1
  arev2     alpass    amono, irvt2, ilpt2
  arev3     alpass    amono, irvt3, ilpt3
  arev4     alpass    amono, irvt4, ilpt4
  arev5     alpass    amono, irvt5, ilpt5
  arev6     alpass    amono, irvt6, ilpt6
  arev7     alpass    amono, irvt7, ilpt7
  arev8     alpass    amono, irvt8, ilpt8
  ares1     reson     arev1, icf1, ibw1, 1
  ares2     reson     arev2, icf2, ibw2, 1
  ares3     reson     arev3, icf3, ibw3, 1
  ares4     reson     arev4, icf4, ibw4, 1
  ares5     reson     arev5, icf5, ibw5, 1
  ares6     reson     arev6, icf6, ibw6, 1
  ares7     reson     arev7, icf7, ibw7, 1
  ares8     reson     arev8, icf8, ibw8, 1
  alsub1    =  (ares1*gil1)+(ares2*gil2)+(ares3*gil3)+(ares4*gil4)
  alsub2    =  (ares5*gil5)+(ares6*gil6)+(ares7*gil7)+(ares8*gil8)
  aleft     =  alsub1 + alsub2
  arsub1    =  (ares1*gir1)+(ares2*gir2)+(ares3*gir3)+(ares4*gir4)
  arsub2    =  (ares5*gir5)+(ares6*gir6)+(ares7*gir7)+(ares8*gir8)
  aright    =  arsub1 + arsub2
            outs      aleft, aright
endin
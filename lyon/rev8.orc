  sr        =  44100
  kr        =  2205
  ksmps     =  20
  nchnls    =  2
;MONO -> MONO OR STEREO REVERB
;WITH RESONANCE MOVING
;f1 0 16384 10 1
;i1 0 dur file skip srcdur gain iorig ; mono input
;i2 0 dur file skip srcdur gain iorig ; stereo input

instr          1
  irvt      =  1.5
  ifile     =  p4
  iskip     =  p5
  indur     =  p6
  igain     =  p7
  iorig     =  p8
  itail     =  p3 - indur
  irev      =  1. - iorig
                                        ;NEXT LINE ONLY FOR STEREO OUTPUT
  iorig     =  iorig * .707
  ibfac     =  .15
  idev      =  .3
  icf1      =  4000
  icf2      =  2000
  icf3      =  1000
  icf1amp   =  icf1*idev
  icf2amp   =  icf2*idev
  icf3amp   =  icf3*idev
  irspeed1  =  .61
  irspeed2  =  .72
  irspeed3  =  .819
  icmbres1  =  37.5
  icmbres2  =  39.1352
  icmbres3  =  30.8677
  icmbres4  =  32.7032
  icmbres5  =  34.6478
  icmbres6  =  36.7081
  ilp1      =  1./icmbres1
  ilp2      =  1./icmbres2
  ilp3      =  1./icmbres3
  ilp4      =  1./icmbres4
  ilp5      =  1./icmbres5
  ilp6      =  1./icmbres6
  idev2     =  .5
  ibfac2    =  .5
  icf4      =  3000
  icf5      =  5000
  icf4amp   =  icf4*idev2
  icf5amp   =  icf5*idev2
  irspeed4  =  .21
  irspeed5  =  .389
            timout    indur, itail, contin
  araw      soundin   ifile,iskip
  araw      =  araw * igain
contin:
  kcfdev1   oscil     icf1amp,irspeed1,1
  kcf1      =  icf1 + kcfdev1
  kbw1      =  kcf1 * ibfac
  ares1     reson     araw, kcf1, kbw1, 1
  kcfdev2   oscil     icf2amp,irspeed2,1
  kcf2      =  icf2 + kcfdev2
  kbw2      =  kcf2 * ibfac
  ares2     reson     araw, kcf2, kbw2, 1
  kcfdev3   oscil     icf3amp,irspeed3,1
  kcf3      =  icf3 + kcfdev3
  kbw3      =  kcf3 * ibfac
  ares3     reson     araw, kcf3, kbw3, 1
  acomb1    comb      ares1, irvt, ilp1
  acomb2    comb      ares1, irvt, ilp2
  acomb3    comb      ares2, irvt, ilp3
  acomb4    comb      ares2, irvt, ilp4
  acomb5    comb      ares3, irvt, ilp5
  acomb6    comb      ares3, irvt, ilp6
  acsum1    =  acomb1+acomb3+acomb5
  acsum2    =  acomb2+acomb4+acomb6
  kcfdev4   oscil     icf4amp,irspeed4,1
  kcf4      =  icf4 + kcfdev4
  kbw4      =  kcf4 * ibfac
  ares4     reson     acsum1, kcf4, kbw4, 1
  kcfdev5   oscil     icf5amp,irspeed5,1
  kcf5      =  icf5 + kcfdev5
  kbw5      =  kcf5 * ibfac
  ares5     reson     acsum2, kcf5, kbw5, 1
     ; STEREO OUTPUT
  amono     =  araw * iorig
  aleft     =  ares4*irev + amono
  aright    =  ares5*irev + amono
            outs      aleft, aright
     ; MONO OUTPUT
     ;arev     =         ares4 + ares5
     ;         out       (iorig*araw)+(irev*arev)
endin

instr          2
  irvt      =  1.5
  ifile     =  p4
  iskip     =  p5
  indur     =  p6
  igain     =  p7
  iorig     =  p8
  itail     =  p3 - indur
  irev      =  1. - iorig
     ;NEXT LINE ONLY FOR STEREO OUTPUT
  iorig     =  iorig * .707
  ibfac     =  .15
  idev      =  .3
  icf1      =  4000
  icf2      =  2000
  icf3      =  1000
  icf1amp   =  icf1*idev
  icf2amp   =  icf2*idev
  icf3amp   =  icf3*idev
  irspeed1  =  .61
  irspeed2  =  .72
  irspeed3  =  .819
  icmbres1  =  37.5
  icmbres2  =  39.1352
  icmbres3  =  30.8677
  icmbres4  =  32.7032
  icmbres5  =  34.6478
  icmbres6  =  36.7081
  ilp1      =  1./icmbres1
  ilp2      =  1./icmbres2
  ilp3      =  1./icmbres3
  ilp4      =  1./icmbres4
  ilp5      =  1./icmbres5
  ilp6      =  1./icmbres6
  idev2     =  .5
  ibfac2    =  .5
  icf4      =  3000
  icf5      =  5000
  icf4amp   =  icf4*idev2
  icf5amp   =  icf5*idev2
  irspeed4  =  .21
  irspeed5  =  .389
            timout    indur, itail, contin
  a1,a2     soundin   ifile,iskip
  a1        =  a1 * igain
  a2        =  a2 * igain
contin:
  kcfdev1   oscil     icf1amp,irspeed1,1
  kcf1      =  icf1 + kcfdev1
  kbw1      =  kcf1 * ibfac
  ares1     reson     a1, kcf1, kbw1, 1
  kcfdev2   oscil     icf2amp,irspeed2,1
  kcf2      =  icf2 + kcfdev2
  kbw2      =  kcf2 * ibfac
  ares2     reson     a2, kcf2, kbw2, 1
  kcfdev3   oscil     icf3amp,irspeed3,1
  kcf3      =  icf3 + kcfdev3
  kbw3      =  kcf3 * ibfac
  ares3     reson     a1+a2, kcf3, kbw3, 1
  acomb1    comb      ares1, irvt, ilp1
  acomb2    comb      ares1, irvt, ilp2
  acomb3    comb      ares2, irvt, ilp3
  acomb4    comb      ares2, irvt, ilp4
  acomb5    comb      ares3, irvt, ilp5
  acomb6    comb      ares3, irvt, ilp6
  acsum1    =  acomb1+acomb3+acomb5
  acsum2    =  acomb2+acomb4+acomb6
  kcfdev4   oscil     icf4amp,irspeed4,1
  kcf4      =  icf4 + kcfdev4
  kbw4      =  kcf4 * ibfac
  ares4     reson     acsum1, kcf4, kbw4, 1
  kcfdev5   oscil     icf5amp,irspeed5,1
  kcf5      =  icf5 + kcfdev5
  kbw5      =  kcf5 * ibfac
  ares5     reson     acsum2, kcf5, kbw5, 1
     ; STEREO OUTPUT
  aleft     =  ares4*irev + (a1*iorig)
  aright    =  ares5*irev + (a2*iorig)
            outs      aleft, aright
     ; MONO OUTPUT
     ;arev     =         ares4 + ares5
     ;         out       (iorig*araw)+(irev*arev)
endin

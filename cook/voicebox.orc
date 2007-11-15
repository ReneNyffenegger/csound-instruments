  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr    1 ; Random Vowel Reson Filter.

  ilevl     =  p4/550                             ; Output level, roughly scaled
  irate     =  p5                                 ; Rate

  ain       soundin   "sample1.wav"

  iseed     =  rnd(1)
  krnd      randi     .5, irate, iseed
  krnd      =  krnd + .5
  k1f       table     krnd, 11, 1
  k2f       table     krnd, 12, 1
  k3f       table     krnd, 13, 1
  k4f       table     krnd, 14, 1
  k5f       table     krnd, 15, 1
  k1b       table     krnd, 21, 1
  k2b       table     krnd, 22, 1
  k3b       table     krnd, 23, 1
  k4b       table     krnd, 24, 1
  k5b       table     krnd, 25, 1
  a1        reson     ain, k1f, k1b
  a2        reson     ain, k2f, k2b
  a3        reson     ain, k3f, k3b
  a4        reson     ain, k4f, k4b
  a5        reson     ain, k5f, k5b
  aout      sum       a1, a2, a3, a4, a5
            out       aout*ilevl

endin
  sr        =  44100
  kr        =  2205
  ksmps     =  20
  nchnls    =  1

instr    1 ; Soprano Mk 1.

  ileng     =  abs(p3)
  ilevl     =  p4*.4
  inote     =  cpspch(p5)
  ivowl1    =  p6/4 + 1
  ivowl2    =  p7/4 + 1
  ivibdel   =  p8
  iport     =  p9
  iseed     =  frac(p2 + .123/inote)
  iviblev   =  inote/50 + 9

  istied    tival     
            tigoto    tieinit
  ibegp     =  inote
  iprev     =  inote
            goto      cont
tieinit:
  ibegp     =  iprev
  iprev     =  inote
cont:
  kpitch    linseg    ibegp, iport, inote, ileng, inote ; Pitch Env
  ibegl     =  (istied == 1 ? 1 : 0)
  iendl     =  (p3 < 0 ? 1 : 0)
  kenv      linseg    ibegl, .25, 1, ileng-.5, 1, .25, iendl ; Legato Amp Env
  kn1       randi     25, 5, iseed                ; 25% Vibrato Depth Randomiser
  kn1       =  (kn1 + 100)/100
  kn2       randi     10, 7, iseed                ; 10% Vibrato Rate Randomiser
  kn2       =  (kn2 + 100)/100
  kn3       randi     .25, 8, iseed               ; 1/4% Pitch Randomiser
  kn3       =  (kn3 + 100)/100
  k0        linseg    1, ileng-.25, 1, .25, 1.5   ; Vibrato Rate
  k1        linseg    0, ivibdel, 1, ileng-ivibdel, 1 ; Vibrato Delay
  k1        oscil     iviblev*kn1*k1*k0, 6*kn2*k0, 3 ; Vibrato LFO
;kenv     linseg  0, .25, 1, ileng-.35, 1, .1, 0         ; Non Legato Amp Env
  kpitch    =  kpitch*kn3 + k1
  kn5       randi     40, 2
  kn6       randi     50, 3.4
  kn7       randi     60, 4.3
  kn8       randi     70, 5.2
  kn9       randi     80, 6.1
  i1f1      table     ivowl1, 11, 1
  i2f1      table     ivowl1, 12, 1
  i3f1      table     ivowl1, 13, 1
  i4f1      table     ivowl1, 14, 1
  i5f1      table     ivowl1, 15, 1
  i1f2      table     ivowl2, 11, 1
  i2f2      table     ivowl2, 12, 1
  i3f2      table     ivowl2, 13, 1
  i4f2      table     ivowl2, 14, 1
  i5f2      table     ivowl2, 15, 1
  k1f       line      i1f1, ileng, i1f2
  k2f       line      i2f1, ileng, i2f2
  k3f       line      i3f1, ileng, i3f2
  k4f       line      i4f1, ileng, i4f2
  k5f       line      i5f1, ileng, i5f2
  i1b1      table     ivowl1, 21, 1
  i2b1      table     ivowl1, 22, 1
  i3b1      table     ivowl1, 23, 1
  i4b1      table     ivowl1, 24, 1
  i5b1      table     ivowl1, 25, 1
  i1b2      table     ivowl2, 21, 1
  i2b2      table     ivowl2, 22, 1
  i3b2      table     ivowl2, 23, 1
  i4b2      table     ivowl2, 24, 1
  i5b2      table     ivowl2, 25, 1
  k1b       line      i1b1, ileng, i1b2
  k2b       line      i2b1, ileng, i2b2
  k3b       line      i3b1, ileng, i3b2
  k4b       line      i4b1, ileng, i4b2
  k5b       line      i5b1, ileng, i5b2
  i2l1      table     ivowl1, 32, 1
  i3l1      table     ivowl1, 33, 1
  i4l1      table     ivowl1, 34, 1
  i5l1      table     ivowl1, 35, 1
  i2l2      table     ivowl2, 32, 1
  i3l2      table     ivowl2, 33, 1
  i4l2      table     ivowl2, 34, 1
  i5l2      table     ivowl2, 35, 1
  k2l       line      i2l1, ileng, i2l2
  k3l       line      i3l1, ileng, i3l2
  k4l       line      i4l1, ileng, i4l2
  k5l       line      i5l1, ileng, i5l2
  k1l       init      32000
  k2l       =  ampdb(90 - k2l)
  k3l       =  ampdb(90 - k3l)
  k4l       =  ampdb(90 - k4l)
  k5l       =  ampdb(90 - k5l)
  a1        fof       k1l, kpitch, k1f + kn5, 0, k1b, .003, .02, .007, 1000, 1, 2, ileng
  a2        fof       k2l, kpitch, k2f + kn6, 0, k2b, .003, .02, .007, 1000, 1, 2, ileng
  a3        fof       k3l, kpitch, k3f + kn7, 0, k3b, .003, .02, .007, 1000, 1, 2, ileng
  a4        fof       k4l, kpitch, k4f + kn8, 0, k4b, .003, .02, .007, 1000, 1, 2, ileng
  a5        fof       k5l, kpitch, k5f + kn9, 0, k5b, .003, .02, .007, 1000, 1, 2, ileng
  aout      sum       a1, a2, a3, a4, a5
            out       aout*kenv

endin
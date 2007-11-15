  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

;basic waveform
;gen5 -L2K 1 1 0 2 .5 0 3 .25 0 4 .125 0 5 .0625 0>/snd/eric/soundin.60
;pitch contour
;gen4 -L2K 0 .95 3  .1 1.0 -3  X-.05 .975  -3  X .667 >/snd/eric/soundin.61

;f1 0 4096 10 1 ; sine
;f2 0 2048 -1 60 0
;f3 0 2048 -1 61 0
;i1 0 dur (min = .5) freq amp
instr 1
  ifreq     =  cpspch( p4 )
  iamp      =  p5 * 10000
  iamp2     =  iamp*.707
  iamp3     =  iamp*.15
  in1down1  =  .1
  in1down2  =  p3 - in1down1
  in2up     =  .35
  in2down   =  p3-in2up
  iatk      =  .085
  idk1      =  .2
;idk1 = .05  ; for shorter durations
  idk       =  .1
  isust     =  p3-(iatk+idk1+idk)
  imod1     =  2.03
  imod2     =  0.98
  io3       =  1/p3

  kfreq     oscili    ifreq, io3, 3
  aenv      linseg    0, iatk, iamp, idk1, iamp2, isust, iamp3, idk, 0
  kindex1   linseg    ifreq, in1down1, ifreq*.75, in1down2, 0
  kindex2   linseg    ifreq*.01, in2up, ifreq*1.0, in2down, ifreq*.01
  amod1     oscili    kindex1, kfreq*imod1, 1
  amod2     oscili    kindex2, kfreq*imod2, 2
  afreq     =  kfreq + amod1 + amod2
  aout      oscili    aenv, afreq, 2
            out       aout
endin

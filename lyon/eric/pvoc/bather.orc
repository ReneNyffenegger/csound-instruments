  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  2
;strident tone - useful as bass or nasty treble
;f1 0 4096 10 1 0 .3 0 .5 0 .1 0 .05
;f2 0 4096 10 1 .3 0 .5 0 .1 0 .05
;f3 0 4096 10 1
;f4 0 16384 13 1 1 .1 .2 .4 .3 .01 .03 .05
;i1 0 dur freqpch panspeed amp
  gipotoo   =  1.570796
  gip       =  gipotoo/2
  gin       =  16384
  gin2      =  gin/2
  gimult    =  gin2/32767
  giemp1    =  20000.
  giemp2    =  giemp1*.6
  giemp3    =  giemp1*.3


instr 1
  ispeed    =  (1/p3)
  iampfunc  =  p4
  ifreqfunc =  p5
  ipts      =  p6
  ispeed    =  p7


  kdx       phasor    ispeed
  kamp      table     kdx*ipts, iampfunc
  kfreq     table     kdx*ipts, ifreqfunc
  kamp      =  kamp * 5000
  a1        oscil     kamp, kfreq, 1
  a2        oscil     kamp, kfreq*1.001, 2

  kloc      oscili    gip, ispeed, 3              ;f3 is a sine
  kloc      =  kloc+gip
  kleft     =  sin(kloc)
  kright    =  cos(kloc)
  aleft     =  kleft*a1+kright*a2
  aright    =  kleft*a2+kright*a1
  andx1     =  gin2+(gimult*aleft)
  aws1      tablei    andx1, 4
  andx2     =  gin2+(gimult*aright)
  aws2      tablei    andx2, 4
  aout1     atone     aws1, 25
  aout2     atone     aws2, 25
            outs      aout1 * 5000, aout2 * 5000
endin

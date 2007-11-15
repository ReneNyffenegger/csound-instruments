  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2
;strident tone - useful as bass or nasty treble
;f1 0 4096 10 1 0 .3 0 .5 0 .1 0 .05
;f2 0 4096 10 1 .3 0 .5 0 .1 0 .05
;f3 0 4096 10 1
;f4 0 16384 13 1 1 .1 .2 .4 .3 .01 .03 .05
;i1 0 dur freqpch panspeed amp
instr 1

  ipotoo    =  1.570796
  ip        =  ipotoo/2
  ifreq     =  p4
  ispeed    =  p5
  iamp      =  p6 * 5000.
  iatk      =  .025
  idk       =  .015
  irelease  =  .15
  isust     =  p3-(iatk+idk+irelease)
  ilpt      =  1/ifreq
  irvt      =  .05
  inn       =  16384
  in2       =  inn/2
  imult     =  in2/32767
  iemp1     =  20000.
  iemp2     =  iemp1*.6
  iemp3     =  iemp1*.3

  a1        oscil     iamp, ifreq, 1
  a2        oscil     iamp, ifreq*1.001, 2
  aenv      linseg    0, iatk, iemp1, idk, iemp2, isust, iemp3, irelease, 0.

  kloc      oscili    ip, ispeed, 3               ;f3 is a sine
  kloc      =  kloc+ip
  kleft     =  sin(kloc)
  kright    =  cos(kloc)
  aleft     =  kleft*a1+kright*a2
  aright    =  kleft*a2+kright*a1
  andx1     =  in2+(imult*aleft)
  aws1      tablei    andx1, 4
  andx2     =  in2+(imult*aright)
  aws2      tablei    andx2, 4
  aout1     atone     aws1, 25
  aout2     atone     aws2, 25
            outs      aout1*aenv, aout2*aenv
endin

instr 2 ; func freq

  ipotoo    =  1.570796
  ip        =  ipotoo/2
  ifreq     =  p4
  ispeed    =  p5
  iamp      =  p6 * 20000.
  iatk      =  .06
  idk       =  .015
  irelease  =  .15
  isust     =  p3-(iatk+idk+irelease)
  ilpt      =  1/ifreq
  irvt      =  .05
  inn       =  16384
  in2       =  inn/2
  imult     =  in2/32767
  iemp1     =  20000.
  iemp2     =  iemp1*.6
  iemp3     =  iemp1*.3

  kfreq     oscil     1.0, 1/p3, 5

  a1        oscil     iamp, kfreq, 1
  a2        oscil     iamp, kfreq*1.001, 2
  aenv      linseg    0, iatk, iemp1, idk, iemp2, isust, iemp3, irelease, 0.

  kloc      oscili    ip, ispeed, 3               ;f3 is a sine
  kloc      =  kloc+ip
  kleft     =  sin(kloc)
  kright    =  cos(kloc)
  aleft     =  kleft*a1+kright*a2
  aright    =  kleft*a2+kright*a1
  andx1     =  in2+(imult*aleft)
  aws1      tablei    andx1, 4
  andx2     =  in2+(imult*aright)
  aws2      tablei    andx2, 4
  aout1     atone     aws1, 25
  aout2     atone     aws2, 25
            outs      aout1*aenv, aout2*aenv
endin

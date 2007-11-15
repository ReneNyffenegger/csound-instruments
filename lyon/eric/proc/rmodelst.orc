;ringmod predelay
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2
;i1 0 dur file skip res1 res2 del1 del2 sfgain rmgain
instr 1
  irg       =  .4
  if1       =  p6
  if2       =  p7
  idel1     =  p8
  idel2     =  p9
  iatk      =  .001
  idk       =  .01
  iamp      =  p10
  irmgain   =  p11
  isust     =  p3-(iatk+idk)
;idelraw = p12
        ;kenv linseg 0,iatk,iamp,isust,iamp,idk,0
  a1,a2     soundin   p4,p5
  amod1     oscil     a1,if1,1
  amod2     oscil     a2,if2,1
  atap1     delay     amod1,idel1
  atap2     delay     amod2,idel2
  a1        =  a1*iamp
  a2        =  a2*iamp
  aleft     =  (atap1*irmgain)+a1
  aright    =  (atap2*irmgain)+a2
            outs      aleft,aright
endin
instr 100
endin

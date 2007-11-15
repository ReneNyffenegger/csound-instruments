;ringmod predelay
  sr        =  44100
  kr        =  4410
;sr=22050
;kr=2205
  ksmps     =  10
  nchnls    =  1
;f1 0 4096 10 1
;i1 0 dur file skip res1 res2 res3 del1 del2 del3 amp
instr 1
  irg       =  .4
  if1       =  p6
  if2       =  p7
  if3       =  p8
  idel1     =  p9
  idel2     =  p10
  idel3     =  p11
  iatk      =  .05
  idk       =  .05
  iamp      =  p12
  isust     =  p3-(iatk+idk)
  idelraw   =  p12
  kenv      linseg    0,iatk,iamp,isust,iamp,idk,0
  araw      soundin   p4,p5
  amod1     oscil     araw,if1,1
  amod2     oscil     araw,if2,1
  amod3     oscil     araw,if3,1
  atap1     delay     amod1,idel1
  atap2     delay     amod2,idel2
  atap3     delay     amod3,idel3
  adel      delay     araw,idelraw
        ;include raw signal
  aout      =  araw+(atap1*irg)+(atap2*irg)+(atap2*irg)
        ;dont include raw signal
        ;aout = (atap1*irg)+(atap2*irg)+(atap2*irg)
            out       aout*kenv
endin
instr 100
endin

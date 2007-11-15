  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2
;i1 0 dur freq amp
;f1 0 2048 -1 1 30
;f2 0 2048 -1 1 31
;f3 0 2048 -1 1 32
;f4 0 2048 -1 1 33
;f5 0 2048 -1 1 34
instr 1
  iamp      =  (p5/3)*30000
  if1       =  cpspch( p4 )
  if2       =  if1*7*(1.013)
  if3       =  if1*3*(1.005)
  if4       =  if1*1.01
  iup       =  p3*.6
  idown     =  p3*.4
  iatk      =  .005
  idk       =  p3-iatk
  iop3      =  1/p3
  aenv      oscili    iamp,iop3,5
  ke1       line      1,p3,.1
  ke2       linseg    .005,iup,.01,idown,.005
  ke3       line      .1,p3,1
  ke4       linseg    1,iatk,.005,idk,0
  as1       oscili    ke1,if1,1
  as2       oscili    ke2,if2,2
  as3       oscili    ke3,if4,3
  as4       oscili    ke4,if3,4
  asig      =  (as1+as2+as3+as4)*aenv
  at1       delay     asig,.003
  at2       delay     asig,.005
  asigdown  =  asig*.5
  ae1       =  (at1+asigdown)*.7
  ae2       =  (at2+asigdown)*.7
  ae3       delay     ae1,.011
  ae4       delay     ae2,.007
  aleft     =  ae1+(ae2*.5)+(ae3*.25)
  aright    =  ae4+(ae3*.5)+(ae2*.25)
            outs      aleft,aright
endin

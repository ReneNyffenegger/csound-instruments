  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2
  gipo      =  1.570796
;i1 0 dur file skip atk dk amp stereo_loc [chan1 input from stereo]
;raw readin

instr 1
  iatk      =  p6
  idk       =  p7
  iamp      =  p8
  is        =  p9
  isust     =  p3-(iatk+idk)
  ileft     =  (cos(gipo*is))*iamp
  iright    =  (sin(gipo*is))*iamp
  amono, ajunk soundin  p4,p5
  aenv      linseg    0,iatk,1,isust,1,idk,0
  aout      =  amono*aenv
            outs      aout*ileft,aout*iright
endin
instr 2
  iatk      =  p6
  idk       =  p7
  iamp      =  p8
  is        =  p9
  isust     =  p3-(iatk+idk)
  ileft     =  (cos(gipo*is))*iamp
  iright    =  (sin(gipo*is))*iamp
  ajunk, amono soundin  p4,p5
  aenv      linseg    0,iatk,1,isust,1,idk,0
  aout      =  amono*aenv
            outs      aout*ileft,aout*iright
endin
instr 3
  aleft,aright soundin  p4,p5
  aleft     =  aleft*p6
  aright    =  aright*p6
            outs      aleft,aright
endin

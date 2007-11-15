  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2
  gipo      =  1.570796
;i1 0 dur file skip  ; raw read
;i2 0 dur file skip atk dk gain ; env with gain
;i3 0 dur file skip gain ; mono 2 left
;i4 0 dur file skip gain ; mono 2 right
;i5 0 dur file skip gain ; gain without envelope
;i6 0 dur ; mono 2 mono
;i8 0 dur file skip ; channel cross
;i9 0 dur file skip gain  ; mono 2 mono with gain
;i10 0 dur file skip atk dk amp stereo_loc [mono input]
;i11 0 dur file skip gain stereolocation
;i12 0 dur file skip chan1_gain chan2_gain
;i13 0 dur file skip gain new_position_for_chan1 n_p_f_chan2
;raw readin
instr 1
  aleft,aright soundin  p4,p5
            outs      aleft,aright
endin

;envelope with gain control
;file skip atktime dktime amp

instr 2
  iatk      =  p6
  idk       =  p7
  iamp      =  p8
  isust     =  p3-(iatk+idk)
  aleft,aright soundin  p4,p5
  aenv      linseg    0,iatk,iamp,isust,iamp,idk,0
            outs      aleft*aenv,aright*aenv
endin
;mono to right
instr 4
  igain     =  p6
  araw      soundin   p4,p5
  araw      =  araw*igain
            outs2     araw
endin
;mono to left
instr 3
  igain     =  p6
  araw      soundin   p4,p5
  araw      =  araw*igain
            outs1     araw
endin
;mono to mono
instr 6
  araw      soundin   p4,p5
            outs      araw,araw
endin
;amp but no env
instr 5
  aleft,aright soundin  p4,p5
  aleft     =  aleft*p6
  aright    =  aright*p6
            outs      aleft,aright
endin
instr 7
  aleft,aright soundin  p4,p5
  amono     =  (aleft+aright)*p6
            outs      amono,amono
endin
;cross channels
instr 8
  aleft,aright soundin  p4,p5
            outs      aright,aleft
endin
;mono->mono with gain
instr 9
  araw      soundin   p4,p5
  araw      =  araw*p6
            outs      araw,araw
endin
;mono -> mono 
;envelope with gain control
;file skip atktime dktime amp

instr 10
  iatk      =  p6
  idk       =  p7
  iamp      =  p8
  is        =  p9
  isust     =  p3-(iatk+idk)
  ileft     =  (cos(gipo*is))*iamp
  iright    =  (sin(gipo*is))*iamp
  amono     soundin   p4,p5
  aenv      linseg    0,iatk,1,isust,1,idk,0
  aout      =  amono*aenv
            outs      aout*ileft,aout*iright
endin
instr 11
  igain     =  p6
  is        =  p7
  ileft     =  (cos(gipo*is))*igain
  iright    =  (sin(gipo*is))*igain
  amono     soundin   p4,p5
            outs      amono*ileft,amono*iright
endin
instr 12
        ;a1,a2 soundin p4,p5
  amono     soundin   p4,p5
  a1        =  amono*p6
  a2        =  amono*p7
            outs      a1,a2
endin
;i13 0 dur file skip gain new_position_for_chan1 n_p_f_chan2
instr 13
  igain     =  p6
  is1       =  p7
  is2       =  p8
  ileft1    =  (cos(gipo*is1))*igain
  iright1   =  (sin(gipo*is1))*igain
  ileft2    =  (cos(gipo*is2))*igain
  iright2   =  (sin(gipo*is2))*igain
  ain1,ain2 soundin   p4,p5
  aout1     =  (ileft1*ain1)+(ileft2*ain2)
  aout2     =  (iright1*ain1)+(iright2*ain2)
            outs      aout1, aout2
endin
;mono 2 stereo w/ envelope
instr 14
  iatk      =  p6
  idk       =  p7
  iamp      =  p8
  isust     =  p3-(iatk+idk)
  amono     soundin   p4,p5
  aenv      linseg    0,iatk,iamp,isust,iamp,idk,0
  aout      =  amono*aenv
            outs      aout,aout
endin

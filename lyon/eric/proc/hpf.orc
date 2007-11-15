  sr        =  44100
  kr        =  44100
  ksmps     =  1

;mono in
;i1 0 dur file skip rolloff gain
;i2 0 dur file skip rolloff gain atk dk
instr 1
  irolloff  =  p6
  igain     =  p7
  araw      soundin   p4,p5
  araw      =  araw * igain
  alp       atone     araw,irolloff
            out       alp
endin

instr 2
  irolloff  =  p6
  igain     =  p7
  iatk      =  p8
  idk       =  p9
  isust     =  p3-(iatk+idk)
  araw      soundin   p4,p5
  araw      =  araw * igain
  alp       atone     araw,irolloff
  aenv      linseg    0,iatk,igain,isust,igain,idk,0
            out       alp*aenv
endin

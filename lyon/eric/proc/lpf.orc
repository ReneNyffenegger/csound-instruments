  sr        =  44100
  kr        =  4410
  ksmps     =  10
;i1 0 dur file skip rolloff gain atk dk
;i2 0 dur file skip 
;mono in
instr 100
endin

instr 1
  irolloff  =  p6
  igain     =  p7
  iatk      =  p8
  idk       =  p9
  isust     =  p3-(iatk+idk)
  araw      soundin   p4,p5
  alp       tone      araw,irolloff
  aenv      linseg    0,iatk,igain,isust,igain,idk,0
            out       alp*aenv
endin


instr 2
  irolloff  =  p6
  araw      soundin   p4,p5
  alp       tone      araw,irolloff
            out       alp
endin



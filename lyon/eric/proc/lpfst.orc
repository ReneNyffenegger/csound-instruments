  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2
;mono in
instr 100
endin
;stereo in
;i1 0 dur file skip rolloff gain atk dk
;i2 0 dur file skip rolloff gain
;i3 0 dur file skip rolloff
;i4 0 dur file skip

instr 1
  igain     =  p7
  irolloff  =  p6
  iatk      =  p8
  idk       =  p9
  isust     =  p3-(iatk+idk)
  aenv      linseg    0,iatk,igain,isust,igain,idk,0
  a1,a2     soundin   p4,p5
  a1        =  a1*aenv
  a2        =  a2*aenv
  alp1      tone      a1,irolloff
  alp2      tone      a2,irolloff
            outs      alp1,alp2
endin

instr 2
  irolloff  =  p6
  igain     =  p7
  a1,a2     soundin   p4,p5
  a1        =  a1*igain
  a2        =  a2*igain
  alp1      tone      a1,irolloff
  alp2      tone      a2,irolloff
            outs      alp1,alp2
endin

instr 3
  irolloff  =  p6
  a1,a2     soundin   p4,p5
  alp1      tone      a1,irolloff
  alp2      tone      a2,irolloff
            outs      alp1,alp2
endin

;function control
instr 4
  a1,a2     soundin   p4,p5
  kroll     oscili    1.0, 1./p3, 1
  alp1      tone      a1,kroll
  alp1      tone      alp1,kroll

  alp2      tone      a2,kroll
  alp2      tone      alp2,kroll

            outs      alp1,alp2
endin

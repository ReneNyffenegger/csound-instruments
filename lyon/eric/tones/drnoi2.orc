  sr        =  44100
  kr        =  4410
  ksmps     =  10
; double resonated noise


;i1 0 dur res1 res2 amp seed
instr 1
  iamp      =  32767 * 1 
  iatk      =  p4
  kenv      linseg    0,iatk,1.0,p3-iatk,0
  anoise    randi     iamp, 13000, .33
  kbw       linseg    6000,4,20,p3-4, 6
  ares      reson     anoise,1000,kbw,1
            out       ares*kenv
endin


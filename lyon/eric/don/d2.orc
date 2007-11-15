  sr        =  44100
  kr        =  441
  ksmps     =  100

instr 1
  garaw     soundin   p4,p5
endin

; MULTI BAND FILTER INSTRUMENT
instr 2
  ibw       =  .07
  ires1     =  p4
  ires2     =  p4*2.
  ires3     =  p4*4.
  ires4     =  p4*8.
  ires5     =  p4*16.
  ires6     =  p4*32.
  ires7     =  p4*64
  iamp1     =  ampdb( p5 )
  iamp2     =  ampdb( p6 )
  iamp3     =  ampdb( p7 )
  iamp4     =  ampdb( p8 )
  iamp5     =  ampdb( p9 )
  iamp6     =  ampdb( p10 )
  iamp7     =  ampdb( p11 )
;iamp1 = p5
;iamp2 = p6
;iamp3 = p7
;iamp4 = p8
;iamp5 = p9
;iamp6 = p10
;iamp7 = p11

  ibw1      =  ires1 * ibw 
  ibw2      =  ires2 * ibw 
  ibw3      =  ires3 * ibw 
  ibw4      =  ires4 * ibw 
  ibw5      =  ires5 * ibw 
  ibw6      =  ires6 * ibw 
  ibw7      =  ires7 * ibw 
  iatk      =  .1
  idk       =  .1
  iamp      =  1.0
  isust     =  p3-(iatk+idk)
  kenv      linseg    0,iatk,iamp,isust,iamp,idk,0
  ares1     reson     garaw,ires1,ibw1,1
  ares2     reson     garaw,ires2,ibw2,1
  ares3     reson     garaw,ires3,ibw3,1
  ares4     reson     garaw,ires4,ibw4,1
  ares5     reson     garaw,ires5,ibw5,1
  ares6     reson     garaw,ires6,ibw6,1
  ares7     reson     garaw,ires7,ibw7,1
  ares1     =  ares1 * iamp1
  ares2     =  ares2 * iamp2
  ares3     =  ares3 * iamp3
  ares4     =  ares4 * iamp4
  ares5     =  ares5 * iamp5
  ares6     =  ares6 * iamp6
  ares7     =  ares7 * iamp7
  asum      =  ares1+ares2+ares3+ares4+ares5+ares6+ares7
  garaw     =  asum * kenv
endin
; MULTI BAND FILTER INSTRUMENT
instr 3
  ibw       =  .2
  ires1     =  p4
  ires2     =  p4*2.
  ires3     =  p4*4.
  ires4     =  p4*8.
  ires5     =  p4*16.
  ires6     =  p4*32.
  ires7     =  p4*64
;iamp1 = ampdb( p5 )
;iamp2 = ampdb( p6 )
;iamp3 = ampdb( p7 )
;iamp4 = ampdb( p8 )
;iamp5 = ampdb( p9 )
;iamp6 = ampdb( p10 )
;iamp7 = ampdb( p11 )
  iamp1     =  p5
  iamp2     =  p6
  iamp3     =  p7
  iamp4     =  p8
  iamp5     =  p9
  iamp6     =  p10
  iamp7     =  p11

  ibw1      =  ires1 * ibw 
  ibw2      =  ires2 * ibw 
  ibw3      =  ires3 * ibw 
  ibw4      =  ires4 * ibw 
  ibw5      =  ires5 * ibw 
  ibw6      =  ires6 * ibw 
  ibw7      =  ires7 * ibw 
  iatk      =  .1
  idk       =  .1
  iamp      =  1.0
  isust     =  p3-(iatk+idk)
  kenv      linseg    0,iatk,iamp,isust,iamp,idk,0
  ares1     reson     garaw,ires1,ibw1,1
  ares2     reson     garaw,ires2,ibw2,1
  ares3     reson     garaw,ires3,ibw3,1
  ares4     reson     garaw,ires4,ibw4,1
  ares5     reson     garaw,ires5,ibw5,1
  ares6     reson     garaw,ires6,ibw6,1
  ares7     reson     garaw,ires7,ibw7,1
  ares1     reson     ares1,ires1,ibw1,1
  ares2     reson     ares2,ires2,ibw2,1
  ares3     reson     ares3,ires3,ibw3,1
  ares4     reson     ares4,ires4,ibw4,1
  ares5     reson     ares5,ires5,ibw5,1
  ares6     reson     ares6,ires6,ibw6,1
  ares7     reson     ares7,ires7,ibw7,1

  ares1     =  ares1 * iamp1
  ares2     =  ares2 * iamp2
  ares3     =  ares3 * iamp3
  ares4     =  ares4 * iamp4
  ares5     =  ares5 * iamp5
  ares6     =  ares6 * iamp6
  ares7     =  ares7 * iamp7
  asum      =  ares1+ares2+ares3+ares4+ares5+ares6+ares7
  garaw     =  asum * kenv
endin

instr 4
            out       garaw
endin
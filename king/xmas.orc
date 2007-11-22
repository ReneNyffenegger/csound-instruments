  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

; SOUNDS LIKE A WHISTLE... FROM A MOUTH WITH NO TEETH AT ALL 
; )))

instr 1
  ifrq      =  cpspch(p5)
  iamp      =  ampdb(p4)
  kenv      linseg    0,p3/3,iamp,2*p3/3,0
  a1        rand      kenv,1
  a2        atone     a1,3000,1
  aflt      reson     a2*.3,ifrq,10,0,1
            outs      aflt*p6,aflt*(1-p6)
endin


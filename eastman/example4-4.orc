  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  amp       expseg    1,.2*p3,8000,.7*p3,3000,.3*p3,1 ; amplitude envelope

; glissando :
  ipitch1   =  (p4 > 0 ? cpspch(p4) : abs(p4))    ; negative values = cps
  ipitch2   =  (p5 > 0 ? cpspch(p5) : abs(p5))    ; negative values = cps
  kgliss    expseg    ipitch1 ,.2*p3, ipitch1, .6*p3, ipitch2, .2*p3, ipitch2

  krenv     expseg    p8, .5*p3, p9, .5*p3,  p8   ; gbuzz kr brightness envelope

  a1        gbuzz     amp,  kgliss,  p7,  p6,  krenv,  1
  a1        tone      a1,  1500                   ; filter out spurious high frequncies
            out       a1
endin


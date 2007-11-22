;=================================================================
; Simple comb demonstration instrument created in class 11/01/2001
; RP
;=================================================================

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

instr   1
  ilpt      =  (p6 > 1 ? 1/cpspch(p6) : p6)       ;p6 is either lpt or pch 
  iscale    =  (p7 == 0 ? 1 : p7)                 ;optional final scaling factor
  asig1,asig2  soundin  "drummer.wav"             ;output of drummer.orc/drummer.sco
  asig1     =  asig1*p4                           ;initial gain factor
  asig2     =  asig2*p4
  asum      =  asig1+asig2                        ;mono mix for comb
  acomb     comb      asum,p5,ilpt                ;p5 is reverb time
  acomb     =  acomb*iscale                       ;final scaling
  kenv      linen     1,.3,p3,.7                  ;overall envelope
  asigl     =  asig1+acomb                        ;add in the effect
  asigr     =  asig2+acomb
            outs      asigl*kenv,asigr*kenv
endin

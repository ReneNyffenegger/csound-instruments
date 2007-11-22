
;;; THREE WAYS OF ARTICULATING PITCHES FROM RISSET'S "MUTATIONS" 
;;; FIGURE 3.29 FROM DODGE & JERSE, p.97 

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1   ; A
  kamp1     linen     p4,.01,p3,.07
  kfreq1    =  p5
  asig1     oscil     kamp1,kfreq1,1
  kamp2     =  p6
  kfreq2    =  p7
  asig2     oscil     kamp2,kfreq2,2
  aout      =  asig1*asig2
            out       aout
endin


instr     2    ; B
  kamp1     linseg    0,p3/2,p4,p3/2,0
  kfreq1    =  p5
  asig1     oscil     kamp1,kfreq1,1
  kamp2     =  p6
  kfreq2    =  p7
  asig2     oscil     kamp2,kfreq2,2
  aout      =  asig1*asig2
            out       aout
endin

instr     3    ; C
  iphsoff   =  (65/5)*.01

  ka1       =  p4
  kf1       =  1/p3
  iph1      =  0
  kamp1     oscil     ka1,kf1,3,iph1
  kfreq1    =  p5
  asig1     oscil     kamp1,kfreq1,1

  ka2       =  p4
  kf2       =  1/p3
  iph2      =  iph1+iphsoff
  kamp2     oscil     ka2,kf2,3,iph2
  kfreq2    =  p5*2
  asig2     oscil     kamp2,kfreq2,1

  ka3       =  p4
  kf3       =  1/p3
  iph3      =  iph2+iphsoff
  kamp3     oscil     ka3,kf3,3,iph3
  kfreq3    =  p5*3
  asig3     oscil     kamp3,kfreq3,1

  ka4       =  p4
  kf4       =  1/p3
  iph4      =  iph3+iphsoff
  kamp4     oscil     ka4,kf4,3,iph4
  kfreq4    =  p5*4
  asig4     oscil     kamp4,kfreq4,1

  ka5       =  p4
  kf5       =  1/p3
  iph5      =  iph4+iphsoff
  kamp5     oscil     ka5,kf5,3,iph5
  kfreq5    =  p5*5
  asig5     oscil     kamp5,kfreq5,1

  ka6       =  p4
  kf6       =  1/p3
  iph6      =  iph5+iphsoff
  kamp6     oscil     ka6,kf6,3,iph6
  kfreq6    =  p5*6
  asig6     oscil     kamp6,kfreq6,1

  ka7       =  p4
  kf7       =  1/p3
  iph7      =  iph6+iphsoff
  kamp7     oscil     ka7,kf7,3,iph7
  kfreq7    =  p5*7
  asig7     oscil     kamp7,kfreq7,1

  ka8       =  p4
  kf8       =  1/p3
  iph8      =  iph7+iphsoff
  kamp8     oscil     ka8,kf8,3,iph8
  kfreq8    =  p5*8
  asig8     oscil     kamp8,kfreq8,1
     
  ka9       =  p4
  kf9       =  1/p3
  iph9      =  iph8+iphsoff
  kamp9     oscil     ka9,kf9,3,iph9
  kfreq9    =  p5*9
  asig9     oscil     kamp9,kfreq9,1

  ka10      =  p4
  kf10      =  1/p3
  iph10     =  iph9+iphsoff
  kamp10    oscil     ka10,kf10,3,iph10
  kfreq10   =  p5*10
  asig10    oscil     kamp10,kfreq10,1

  add1      =  asig1+asig2+asig3+asig4+asig5
  add2      =  asig6+asig7+asig8+asig9+asig10
  add       =  add1+add2
  kenv      linseg    0,p3/2,2,p3/2,0
  aout      =  add*kenv
            out       aout
endin

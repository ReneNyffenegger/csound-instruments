
;;; DESIGN TO PRODUCE GRADUAL CHANGE OF OCTAVE, FROM RISSET 
;;; FIGURE 3.31 FROM DODGE & JERSE, p.99 


  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  iphsoff   =  (65/5)*.01

  ka1       =  p4
  kf1       =  1/p3
  iph1      =  0
  kamp1     oscil     ka1,kf1,2,iph1
  kfreq1    =  p5
  asig1     oscil     kamp1,kfreq1,1

  ka2       =  p4
  kf2       =  1/p3
  iph2      =  iph1+iphsoff
  kamp2     oscil     ka2,kf2,2,iph2
  kfreq2    =  p5*2
  asig2     oscil     kamp2,kfreq2,1

  ka3       =  p4
  kf3       =  1/p3
  iph3      =  iph2+iphsoff
  kamp3     oscil     ka3,kf3,2,iph3
  kfreq3    =  p5*3
  asig3     oscil     kamp3,kfreq3,1

  ka4       =  p4
  kf4       =  1/p3
  iph4      =  iph3+iphsoff
  kamp4     oscil     ka4,kf4,2,iph4
  kfreq4    =  p5*4
  asig4     oscil     kamp4,kfreq4,1

  ka5       =  p4
  kf5       =  1/p3
  iph5      =  iph4+iphsoff
  kamp5     oscil     ka5,kf5,2,iph5
  kfreq5    =  p5*5
  asig5     oscil     kamp5,kfreq5,1

  add       =  asig1+asig2+asig3+asig4+asig5
  kenv      linseg    0,p3/2,1,p3/2,0
  aout      =  add*kenv
            out       aout
endin

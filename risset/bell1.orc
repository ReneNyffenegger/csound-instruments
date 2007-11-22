;;; BELL INSTRUMENT BASED ON RISSET
;;; FIGURE 3.27 FROM DODGE & JERSE, P.94 

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1

  ka1       =  p4
  ka2       =  p4*.67
  ka3       =  p4
  ka4       =  p4*1.8
  ka5       =  p4*2.67
  ka6       =  p4*1.67
  ka7       =  p4*1.46
  ka8       =  p4*1.33
  ka9       =  p4*1.33
  ka10      =  p4
  ka11      =  p4*1.33

  kd1       =  p3
  kd2       =  p3*.9
  kd3       =  p3*.65
  kd4       =  p3*.55
  kd5       =  p3*.325
  kd6       =  p3*.35
  kd7       =  p3*.25
  kd8       =  p3*.2
  kd9       =  p3*.15
  kd10      =  p3*.1
  kd11      =  p3*.075

  kf1       =  p5*.56
  kf2       =  p5*.56+1
  kf3       =  p5*.92
  kf4       =  p5*.92+1.7
  kf5       =  p5*1.19
  kf6       =  p5*1.7
  kf7       =  p5*2
  kf8       =  p5*2.74
  kf9       =  p5*3
  kf10      =  p5*3.76
  kf11      =  p5*4.07

  kamp1     oscil     ka1,1/kd1,2
  kamp2     oscil     ka2,1/kd2,2
  kamp3     oscil     ka3,1/kd3,2
  kamp4     oscil     ka4,1/kd4,2
  kamp5     oscil     ka5,1/kd5,2
  kamp6     oscil     ka6,1/kd6,2
  kamp7     oscil     ka7,1/kd7,2
  kamp8     oscil     ka8,1/kd8,2
  kamp9     oscil     ka9,1/kd9,2
  kamp10    oscil     ka10,1/kd10,2
  kamp11    oscil     ka11,1/kd11,2

  asig1     oscil     kamp1,kf1,1
  asig2     oscil     kamp2,kf2,1
  asig3     oscil     kamp3,kf3,1
  asig4     oscil     kamp4,kf4,1
  asig5     oscil     kamp5,kf5,1
  asig6     oscil     kamp6,kf6,1
  asig7     oscil     kamp7,kf7,1
  asig8     oscil     kamp8,kf8,1
  asig9     oscil     kamp9,kf9,1
  asig10    oscil     kamp10,kf10,1
  asig11    oscil     kamp11,kf11,1

  add1      =  asig1+asig2+asig3+asig4+asig5+asig6
  add2      =  asig7+asig8+asig9+asig10+asig11
  add       =  add1+add2
  aout      =  add
            out       aout
endin

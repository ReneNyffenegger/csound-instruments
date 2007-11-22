;;; DRUM INSTRUMENT BASED ON RISSET
;;; FIGURE 3.26 FROM DODGE & JERSE, P.93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr     1
  kamp      =  p4
  kfreq     =  p5

  ka1       =  kamp/2
  kf1       =  1/p3
  kamp1     oscil     ka1, kf1, 2
  krand     randi     kamp1, 400
  asig1     oscil     krand, 500, 4

  ka2       =  kamp/6
  kf2       =  1/p3
  kamp2     oscil     ka2, kf2, 2
  kfreq2    =  kfreq/10
  asig2     oscil     kamp2, kfreq2, 3

  ka3       =  kamp/2.5
  kf3       =  1/p3
  kamp3     oscil     ka3, kf3, 1
  asig3     oscil     kamp3, kfreq, 4

  aout      =  asig1+asig2+asig3
            out       aout
endin

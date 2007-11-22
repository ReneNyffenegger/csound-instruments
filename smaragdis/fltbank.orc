  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  ibw       =  5
;a1       oscil     30000, 1/1.3113, 1
  a1        rand      30000
  kamp      expon     10, p3, 1
  kmov      randi     10, 20
  af1       butterbp  a1, 500+kmov, ibw
  af2       butterbp  a1, 1000+kmov, ibw
  af3       butterbp  a1, 1200+kmov, ibw
  af4       butterbp  a1, 1500+kmov, ibw
  af5       butterbp  a1, 2000+kmov, ibw
            out       (af1+af2+af3+af4+af5)*kamp
endin

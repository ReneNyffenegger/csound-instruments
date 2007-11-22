

                                   ; toot1.orc 
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr     1
  kenv      oscil     p4,  1 / p3 , 2             ; p4=max, p3=note dur
  kven      oscil     p6,  1 / p3,   3            ; p6=max
  kpen      line      p8, p3, p9                  ;p8,p9=start/stop line lvl
  klfo      oscil     p10, p11, 1                 ;p10=chorus detune p11=chorus freq
  amod      oscil     kven, p7 + kpen, 1          ; p7=modf
  a1        oscil     kenv, p5 + kpen + amod, 1   ; p5=note freq 
  a2        oscil     p12 * kenv, p5 + kpen + amod + klfo, 1
            out       a1 + a2
endin

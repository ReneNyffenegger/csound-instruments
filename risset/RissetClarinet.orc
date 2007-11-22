  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

; RISSET'S WAVESHAPING CLARINET

instr 1

  i1        =  cpspch(p4)
  i2        =  .64
if        p3 > .75 igoto start
  i2        =  p3-.085

start:
  a1        linen     255,.085,p3,i2
  a1        oscili    a1,i1,3
  a1        tablei    a1+256,1
            out       p5*a1
endin

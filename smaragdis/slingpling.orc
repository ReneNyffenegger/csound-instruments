  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2


instr 1
  iwave     =  2
  ienvp     =  1
  inote     =  cpspch( p4)

  kamp      linseg    p5, p3/2, 1000, p3/2, 500

  kop1      oscil     kamp, 2,   ienvp
  kop2      oscil     kamp, 2.2, ienvp
  kop3      oscil     kamp, 7.2, ienvp
  kop4      oscil     kamp, 5.2, ienvp
  kop5      oscil     kamp, 3.2, ienvp
  kop6      oscil     kamp, 4.2, ienvp

  aop1      oscil     kop1, inote,   iwave
  aop2      oscil     kop2, inote*2, iwave
  aop3      oscil     kop3, inote*3, iwave
  aop4      oscil     kop4, inote*4, iwave
  aop5      oscil     kop5, inote*5, iwave
  aop6      oscil     kop6, inote*6, iwave

  aout      =  (aop1+aop2+aop3+aop4+aop5+aop6)
  apan      oscil     .5, 1, 1
  apan      =  (apan + .5)*1.3

            outs      aout*apan, aout*(1-apan)
endin

instr 2
  knos      linseg    1, .01, 0, p3-.01, 0
  kamp      expon     10000, .5, .0001
  a1        oscil     kamp/2, 100, 3
  a2        oscil     kamp, 50, 3
  a3        rand      5000
  aout      =  (a1+a2+knos*a3)/2
            outs      aout, aout
endin

instr 3
  kamp      line      1, p3, 0
  ans       rand      10000
  a1        oscil     2000*kamp, 180, 3
  a2        oscil     2000*kamp, 200, 3
  afn1      reson     ans, 500, 100
  afn2      reson     ans, 1000, 200
  afn3      reson     ans, 1500, 400
     
  anss      =  kamp*(afn1 + afn2 + afn3 + 10*ans)
  aout      =  (anss + a2 + a1)/75
            outs      aout, aout
endin

instr 4
  kamp      expon     1, p3, .000000001
  ans       rand      10000
  afn1      reson     ans, 2500, 100
  afn2      reson     ans, 3000, 200
  afn3      reson     ans, 4000, 400

  aout      =  kamp*(afn1 + afn2 + afn3)/75
            outs      aout, aout
endin

instr 5
  inote     =  cpspch(p4)

  kamp      line      1000, p3, 0

  aop1      foscil    10*kamp, 1, inote, inote, 1, 4
  afil      tone      aop1, kamp

  aout      =  afil/4
            outs      aout, aout
endin

instr 6
  inote     =  cpspch(p4)

  kamp      linseg    p5, p3/4, 10000, 3*p3/4, 5000

  aop1      foscil    kamp, 1, inote, inote, 2, 4
  aop2      foscil    kamp, 1, inote+2, inote+2, 2, 4
  aop3      foscil    kamp, 1, inote-2, inote-2, 2, 4

  aouf      =  aop1 + aop2 + aop3
  kfrs      oscil     200, .2, 3
  kfr       =  kfrs + 500
  aoul      tone      aouf, kfr
  aour      reson     aouf, kfr*4, 100
     
  aout      =  (aour/3 + aoul)/60

            outs      aout, aout
endin

instr 7
  kp        expon     p4, p3, 240
  ka        line      5000, p3, 0
  a1        oscil     ka, kp, 3
            outs      a1, a1
endin

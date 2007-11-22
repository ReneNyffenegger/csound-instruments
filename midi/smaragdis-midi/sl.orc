  nchnls    =  2

instr 1
  iwave     =  2
  ienvp     =  1
  icps      cpsmidi   
  iamp      ampmidi   2000, 100
  kamp      linenr    iamp, .1, .333, .5

  kop1      oscil     kamp, 2,   ienvp
  kop2      oscil     kamp, 2.2, ienvp
  kop3      oscil     kamp, 7.2, ienvp
  kop4      oscil     kamp, 5.2, ienvp
  kop5      oscil     kamp, 3.2, ienvp
  kop6      oscil     kamp, 4.2, ienvp

  aop1      oscil     kop1, icps,   iwave
  aop2      oscil     kop2, icps*2, iwave
  aop3      oscil     kop3, icps*3, iwave
  aop4      oscil     kop4, icps*4, iwave
  aop5      oscil     kop5, icps*5, iwave
  aop6      oscil     kop6, icps*6, iwave

  aout      =  (aop1+aop2+aop3+aop4+aop5+aop6)
  apan      oscil     .5, 1, 1

  apan      =  (apan + .5)*1.3

            outs      aout*apan, aout*(1-apan)

endin

instr               2
  inote     cpsmidi   
  iamp      ampmidi   10000, 100
  kamp      linenr    iamp, .2, 2, .01

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

instr               3
  knos      linseg    1, .01, 0, 10, 0
  kamp      expon     10000, .5, .0001
  a1        oscil     kamp/2, 100, 3
  a2        oscil     kamp, 50, 3
  a3        rand      5000
  aout      =  (a1+a2+knos*a3)

  iamp      ampmidi   1, 100
  kamp      linenr    iamp, 0, 2, .01
            outs      kamp*aout, kamp*aout
endin

instr 4
  kamp      linseg    1, .2, 0, 10, 0
  ans       rand      10000
  a1        oscil     2000*kamp, 180, 3
  a2        oscil     2000*kamp, 200, 3
  afn1      reson     ans, 500, 100
  afn2      reson     ans, 1000, 200
  afn3      reson     ans, 1500, 400
     
  anss      =  kamp*(afn1 + afn2 + afn3 + 10*ans)
  aout      =  (anss + a2 + a1)/75

  iamp      ampmidi   1, 100
  kamp      linenr    iamp, 0, .1, .01
            outs      kamp*aout, kamp*aout
endin

instr               5
  kamp      expon     1, 1, .00001
  ans       rand      10000
  afn1      reson     ans, 2500, 100
  afn2      reson     ans, 3000, 200
  afn3      reson     ans, 4000, 400

  aout      =  kamp*(afn1 + afn2 + afn3)/75
  iamp      ampmidi   1, 100
  kamp      linenr    iamp, 0, .1, .01
            outs      kamp*aout, kamp*aout
endin

instr 6
  inote     cpsmidi   
  kamp      line      1000, .5, 0

  aop1      foscil    10*kamp, 1, inote, inote, 1, 4
  afil      tone      aop1, kamp

  aout      =  afil
  iamp      ampmidi   1, 100
  kamp      linenr    iamp, 0, .5, .01
            outs      kamp*aout, kamp*aout
endin

instr               7
  inote     cpsmidi   
  iamp      ampmidi   1, 100
  kamp      linenr    iamp, 0, .5, .01

  kp        expon     inote, .5, 240
  ka        line      5000, 1, 0
  a1        oscil     ka, kp, 3

            outs      kamp*a1, kamp*a1
endin


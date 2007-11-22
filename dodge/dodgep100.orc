; THIS IS THE INSTRUMENT FROM DODGE&JERSE P.100, RISSET'S INHARMONIQUE 

  sr        =  44100
  kr        =  8820
  ksmps     =  5
  nchnls    =  1

instr 1
  a1        oscil     1,1/p3,5

          ; P3 DURATION

  a2        =  ampdb(p4)*a1

          ; P4 PEAK AMPLITUDE

  a3        oscil     100,1/p3,7
  a4        randh     1,a3
  a5        =  .2*a1
  a6        =  a5*a4
  a7        =  1+a6
  a8        =  a7*p5

          ; P5 BANDWIDTH

  a9        randi     a2,a8

  a10       =  a4*.2
  a11       =  1+a10
  a12       oscil     p6,1/p3,8

          ; P6 CENTER FREQ

  a13       =  a12*a11
  a14       oscil     a9,a13,1
            out       a14
endin





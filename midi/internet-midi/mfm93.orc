  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2


            massign   1,1

instr          1

  inote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc,0,2,.01

  kenv      linseg    0,0.1,1,2-0.3,1,0.2,0
  kramp     linseg    0.8,2/2,1.25,2/2,0.8
  k1        =  2 * (kramp - 1/kramp)/2
  k2a       =  2 * (kramp + 1/kramp)/2
  k2b       =  200 * k2a
  k3a       table     k1*2,1,0,0,0
  k3b       =  k3a * (-1/2)
  a1        oscil     k2b,200,3
  a2        oscil     k1,200,3
  a3        =  kenv * 10000 * exp(a2+k3b)
  asig      oscil     a3,inote+a1,2
            outs      asig*kgate,asig*kgate
  ga1       =  asig*kgate
endin

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  ims       =  1.1
  a1        oscil     10000, 1737, 1
  k2        oscil     ims, 1/p3, 2
  a4        vdelay    a1, k2, ims
            out       a4
endin

instr 2
  ims       =  100
  a1        oscil     10000, 1737, 1
  a2        oscil     ims/2, 1/p3, 1
  a2        =  a2 + ims/2
  a3        vdelay    a1, a2, ims
            out       a3
endin

instr 3
  k1        linseg    10000, .1, 0, p3-.1, 0
  a1        oscil     k1, 1373, 1
  a2        multitap  a1, .4, 1, .1, .5           ;, .6, .24, .5, .73, .9
            out       a2
endin

instr 4
  ims       =  10
  a1        oscil     10000, 1737, 3
  ams       oscil     ims, 1/p3, 2
  a4        vdelay    a1, ams, ims
            out       a4
endin


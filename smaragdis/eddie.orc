  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 6
  inote     =  cpspch( p4)
  kamp      linen     .2, .1, p3, .1
  a1        oscil     10000, inote - .5, 2
  a2        oscil     10000, inote + .5, 2
  a3        oscil     10000, inote / 2 , 2
  kfreq     line      4000, 4.1, 100
  afil      butterlp  (a1 + a2 + a3), kfreq
  afil2     butterbp  afil, kfreq, 50
            out       kamp * (5 * afil2 + afil)
endin

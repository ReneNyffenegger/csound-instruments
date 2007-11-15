  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  infile    =  p4
  inskip    =  p5
  imodf     =  p6
  ilpt      =  p7
  irvt      =  p8
  icf       =  p9
  ibw       =  p9 * .2
  araw      soundin   infile, inskip
  amod      oscil     araw,imodf,1
  acomb     comb      amod, irvt, ilpt
  ares      reson     acomb, icf, ibw, 1
            out       ares
endin

instr 2
  infile    =  p4
  inskip    =  p5
  igain     =  p6
  iatk      =  .01
  idk       =  .03
  isust     =  p3 - (iatk+idk)
  gkenv     linseg    0, iatk, igain, isust, igain, idk, 0
  garaw     soundin   infile, inskip
endin
instr 3
  iorig     =  p8
  ieffect   =  1.0 - p8
  imodf     =  p4
  ilpt      =  p5
  irvt      =  p6
  icf       =  p7
  ibw       =  p7 * .2
  iatk      =  .01
  idk       =  .03
  isust     =  p3 - (iatk+idk)
  amod      oscil     garaw,imodf,1
  amod      =  (amod*ieffect)+(garaw*iorig)
  acomb     comb      amod, irvt, ilpt
  ares      reson     acomb, icf, ibw, 1
            out       ares*gkenv
endin
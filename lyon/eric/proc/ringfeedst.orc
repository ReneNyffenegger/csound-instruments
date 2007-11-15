  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

instr 1
  infile    =  p4
  inskip    =  p5
  imodf     =  p6
  ilpt      =  p7
  irvt      =  p8
  icf       =  p9
  ibw       =  p9 * .2
  a1,a2     soundin   infile, inskip
  amod1     oscil     a1,imodf,1
  acomb1    comb      amod1, irvt, ilpt
  ares1     reson     acomb1, icf, ibw, 1
  amod2     oscil     a2,imodf,1
  acomb2    comb      amod2, irvt, ilpt
  ares2     reson     acomb2, icf, ibw, 1
            outs      ares1,ares2
endin

instr 2
  infile    =  p4
  inskip    =  p5
  igain     =  p6
  iatk      =  .01
  idk       =  .03
  isust     =  p3 - (iatk+idk)
  gkenv     linseg    0, iatk, igain, isust, igain, idk, 0
  garaw1, garaw2      soundin                     infile, inskip
endin
instr 3
  iorig     =  p8
  ieffect   =  1.0 - p8
  imodf     =  p4
  ilpt      =  p5
  irvt      =  p6
  icf       =  p7
  ibw       =  p7 * .2
  amod1     oscil     garaw1,imodf,1
  amod1     =  (amod1*ieffect)+(garaw1*iorig)
  acomb1    comb      amod1, irvt, ilpt
  ares1     reson     acomb1, icf, ibw, 1
  amod2     oscil     garaw2,imodf,1
  amod2     =  (amod2*ieffect)+(garaw2*iorig)
  acomb2    comb      amod2, irvt, ilpt
  ares2     reson     acomb2, icf, ibw, 1
            outs      ares1*gkenv,ares2*gkenv
endin
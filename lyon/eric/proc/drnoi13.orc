  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  2
  gipo      =  1.570796
  gigain    =  2.
instr 10
  ga1,ga2   soundin   p4,p5
endin

instr 1
  ires1     =  p4
  ires2     =  p4 * 2
  ires3     =  p4 * 4
  iamp      =  p5 * gigain
  ispeed    =  p6
  iloc1     =  p7
  iloc2     =  p8
  iloc3     =  p9
  ibf       =  p10                                ;
  ibw1      =  ires1*ibf
  ibw2      =  ires2*ibf
  ibw3      =  ires3*ibf
  il1       =  (cos(gipo*iloc1))
  il2       =  (cos(gipo*iloc2))
  il3       =  (cos(gipo*iloc3))
  ir1       =  (sin(gipo*iloc1))
  ir2       =  (sin(gipo*iloc2))
  ir3       =  (sin(gipo*iloc3))


  kamp1     oscil     1., ispeed, 1, 0
  kamp2     oscil     1., ispeed, 1, .3333
  kamp3     oscil     1., ispeed, 1, .6666

  kenv      linseg    0,p3/5,iamp,p3/2,iamp,p3/5,0
  ares1     reson     ga1, ires1, ibw1, 1
  ares2     reson     (ga2+ga1)*.707, ires2, ibw2, 1
  ares3     reson     ga2, ires3, ibw3, 1
  ares1     =  ares1 * kamp1
  ares2     =  ares2 * kamp2
  ares3     =  ares3 * kamp3
  a1        =  (ares1*il1)+(ares2*il2)+(ares3*il3)
  a2        =  (ares1*ir1)+(ares2*ir2)+(ares3*ir3)
        ;a1 balance a1, ga1
        ;a2 balance a2, ga2
            outs      a1*kenv,a2*kenv
endin

instr 20
  ga1       soundin   p4,p5
endin

instr 2
  ires1     =  p4
  ires2     =  p4 * 2
  ires3     =  p4 * 4
  iamp      =  p5 * gigain
  ispeed    =  p6
  iloc1     =  p7
  iloc2     =  p8
  iloc3     =  p9
  il1       =  (cos(gipo*iloc1))
  il2       =  (cos(gipo*iloc2))
  il3       =  (cos(gipo*iloc3))
  ir1       =  (sin(gipo*iloc1))
  ir2       =  (sin(gipo*iloc2))
  ir3       =  (sin(gipo*iloc3))

  ibf       =  p10                                ;
  ibw1      =  ires1*ibf
  ibw2      =  ires2*ibf
  ibw3      =  ires3*ibf

  kamp1     oscil     1., ispeed, 1, 0
  kamp2     oscil     1., ispeed, 1, .3333
  kamp3     oscil     1., ispeed, 1, .6666


  kenv      linseg    0,p3/5,iamp,p3/2,iamp,p3/5,0
  ares1     reson     ga1, ires1, ibw1, 1
  ares2     reson     ga1, ires2, ibw2, 1
  ares3     reson     ga1, ires3, ibw3, 1
  ares1     =  ares1 * kamp1
  ares2     =  ares2 * kamp2
  ares3     =  ares3 * kamp3
  a1        =  (ares1*il1)+(ares2*il2)+(ares3*il3)
  a2        =  (ares1*ir1)+(ares2*ir2)+(ares3*ir3)
        ;a1 balance a1,ga1
        ;a2 balance a2,ga1
            outs      a1*kenv,a2*kenv
endin

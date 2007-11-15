  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  2
  gipo      =  1.570796

instr 10
  ga1,ga2   soundin   p4,p5
endin

instr 1
  ires1     =  p4
  ires2     =  p4 * 2
  ires3     =  p4 * 4
  iamp      =  p5 
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

  iminf     =  .005
  imaxf     =  .1
  iminbw1   =  iminf * ires1
  iminbw2   =  iminf * ires2
  iminbw3   =  iminf * ires3
  imaxbw1   =  imaxf * ires1
  imaxbw2   =  imaxf * ires2
  imaxbw3   =  imaxf * ires3

  kbw1      oscil     imaxbw1-iminbw1, ispeed, 1, 0
  kbw2      oscil     imaxbw2-iminbw2, ispeed, 1, .3333
  kbw3      oscil     imaxbw2-iminbw2, ispeed, 1, .6666
  kbw1      =  kbw1 + iminbw1
  kbw2      =  kbw2 + iminbw2
  kbw3      =  kbw3 + iminbw3

  kenv      linseg    0,p3/5,iamp,p3/2,iamp,p3/5,0
  ares1     reson     ga1, ires1, kbw1, 1
  ares2     reson     (ga2+ga1)*.707, ires2, kbw2, 1
  ares3     reson     ga2, ires3, kbw3, 1
  a1        =  (ares1*il1)+(ares2*il2)+(ares3*il3)
  a2        =  (ares1*ir1)+(ares2*ir2)+(ares3*ir3)
            outs      a1*kenv,a2*kenv
endin

instr 20
  ga1       soundin   p4,p5
endin

instr 2
  ires1     =  p4
  ires2     =  p4 * 2
  ires3     =  p4 * 4
  iamp      =  p5 
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

  iminf     =  .005
  imaxf     =  .1
  iminbw1   =  iminf * ires1
  iminbw2   =  iminf * ires2
  iminbw3   =  iminf * ires3
  imaxbw1   =  imaxf * ires1
  imaxbw2   =  imaxf * ires2
  imaxbw3   =  imaxf * ires3

  kbw1      oscil     imaxbw1-iminbw1, ispeed, 1, 0
  kbw2      oscil     imaxbw2-iminbw2, ispeed, 1, .3333
  kbw3      oscil     imaxbw2-iminbw2, ispeed, 1, .6666
  kbw1      =  kbw1 + iminbw1
  kbw2      =  kbw2 + iminbw2
  kbw3      =  kbw3 + iminbw3

  kenv      linseg    0,p3/5,iamp,p3/2,iamp,p3/5,0
  ares1     reson     ga1, ires1, kbw1, 1
  ares2     reson     ga1, ires2, kbw2, 1
  ares3     reson     ga1, ires3, kbw3, 1
  a1        =  (ares1*il1)+(ares2*il2)+(ares3*il3)
  a2        =  (ares1*ir1)+(ares2*ir2)+(ares3*ir3)
            outs      a1*kenv,a2*kenv
endin

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  2
  gipo      =  1.570796
  gisinefunc   =      77
instr 1 ; gliss instr

  ifunc     =  p4
  istpch    =  p5
  iendpch   =  p6
  istloc    =  p7
  iendloc   =  p8
  igain     =  p9 * 20000
  iatk      =  .05
  idk       =  .2
  isust     =  p3 - (iatk+idk) 

  kenv      linseg    0,iatk,igain,isust,igain,idk,0
  kpch      line      istpch, p3, iendpch
  asig      oscil     kenv, kpch, ifunc
  kloc      line      istloc, p3, iendloc
  kloc      =  kloc * gipo
  kleftg    =  cos(kloc)
  krightg   =  sin(kloc)
            outs      asig*kleftg, asig*krightg
endin

instr 2
  ifunc     =  p4
  ifreq     =  p5
  igain     =  p6 * 20000
  iloc      =  p7
  itremspeed   =      p8
  ileft     =  cos(gipo*iloc)
  iright    =  sin(gipo*iloc)

  itremdepth   =      .2
  itrembase =  1. - itremdepth
  iatk      =  .025
  idk       =  p3 - iatk
  kenv      linseg    0,iatk,igain,idk,0
  ktrem     oscil     itremdepth, itremspeed, gisinefunc
  ktrem     =  ktrem + itrembase
  asig      oscil     kenv*ktrem, ifreq, ifunc
            outs      asig * ileft, asig * iright
endin

instr 3 ; melody instr
  ifunc     =  p4
  ifreq     =  p5
  igain     =  p6 * 15000
  itremspeed   =      p7
  iloc      =  p8
  ileft     =  cos(gipo*iloc)
  iright    =  sin(gipo*iloc)
  iatk      =  .1
  idk       =  .1
  isust     =  p3 - (iatk+idk) 
  kenv      linseg    0,iatk,igain,isust,igain,idk,0
  kpch      linseg    ifreq*1.05, .02, ifreq, p3-.02, ifreq
  ktrem     oscil     1., itremspeed, 78
  asig1     oscil     ktrem, kpch, ifunc
  asinsig   oscil     1.0, kpch, gisinefunc
  armod     =  asinsig * asinsig
  asig2     tone      armod, 2000
  amix      =  asig1 + asig2
  asig      =  amix*kenv
            outs      asig * ileft, asig * iright
endin

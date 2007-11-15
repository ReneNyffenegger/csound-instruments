  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1
  iampfunc  =  p4
  ifreqfunc =  p5
  ipts      =  p6
  ispeed    =  1/p3

  kdx       phasor    ispeed
  kamp      tablei    kdx*ipts, iampfunc
  kfreq     tablei    kdx*ipts, ifreqfunc
  kdex      line      4,p3,10
  kmod      line      1,p3,1.01
  kcar      linseg    1,p3/2,.98,p3/2,1
  afosc     foscil    kamp, kfreq, kcar, kmod, kdex, 1
            out       afosc
endin

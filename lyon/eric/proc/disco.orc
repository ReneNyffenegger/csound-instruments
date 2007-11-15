  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1
  gisr      =  sr
  gigain    =  1.0
instr 100
  gitl      =  ftlen( 1 )
  giincr    =  gisr/gitl
endin
instr 2
  ipulsespeed  =      p4
  irndspeed =  p4*2
  itopincr  =  giincr*1.2
  ibotincr  =  giincr*.8
  itbincr   =  itopincr-ibotincr
  iseed     =  p5

  kpls      oscili    1.0,ipulsespeed,2
  gkincr    randh     itbincr,irndspeed,iseed
  gkincr    =  (gkincr + ibotincr)*kpls
endin
;dj spinfuck 
;p4=speed;p5=jitterfac;p6=incfac
instr 3
  ijitter   =  p4/p5
  iincvar   =  giincr/p6
  ispd      =  p4*2
  iseed1    =  p7
  iseed2    =  p8

  kjit      randi     ijitter,ispd,iseed1
  kivar     randi     iincvar,ispd,iseed2
  kamp      =  giincr+kivar
  kspeed    =  p4+kjit
  gkincr    oscili    kamp,kspeed,4
endin
instr 4 
  ivarincr  =  giincr/2
  ivarincrspeed       =   3
  iminspeed =  .025
  imaxspeed =  1.1
  idifspeed =  imaxspeed - iminspeed
  irndspeed =  .5
  iseed1    =  p4
  iseed2    =  p5

  kspeed    randi     idifspeed,irndspeed,iseed1
  kspeed    =  kspeed + iminspeed
  gkincr    oscili    giincr,kspeed,4
  kvincr    randi     ivarincr,ivarincrspeed,iseed2
  gkincr    =  gkincr + kvincr
endin
instr 5
  iseed     =  p5
  gkincr    randi     giincr,p4,iseed
endin
instr 1
  aread     oscili    gigain,gkincr,1
        ;aread tone aread,6000
        ;averb reverb aread,.2
        ;display gkincr, .2

        ;out aread+averb
            out       aread
endin

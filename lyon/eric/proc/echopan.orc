  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  2
  gipo      =  1.570796
; f1 is raised sine
instr 1
  ifile     =  p4
  iskip     =  p5
  ispeed    =  p6
  idepth    =  p7
  iphase    =  p8
  ifeed     =  p9
  igain     =  p10
  imax      =  idepth * 2.5
  
  amono     soundin   ifile, iskip
  amono     =  amono * igain
;  kdel                 oscili idepth, ispeed, 1, iphase
;  kdel                 = kdel + .001
  addl      delayr    imax
  atap      deltap    idepth
  amono     =  amono + (atap * ifeed)
            delayw    amono
  kloc      oscili    gipo, ispeed, 1, iphase
  kamp1     =  sin( kloc )
  kamp2     =  cos( kloc )
  asig1     =  atap * kamp1
  asig2     =  atap * kamp2
            outs      asig1, asig2
endin


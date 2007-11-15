  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

  gigain    =  20000.0
  gipiotwo  =  1.570796
instr 1
  ifreq     =  p4
  iamp      =  p5 * gigain
  iwavefunc =  p6
  ienvfunc  =  p7
  ienvspeed =  p8
  itrifunc  =  p9
  iloc      =  p10 * gipiotwo
  ileft     =  cos( iloc )
  iright    =  sin( iloc )

   
  kclean    linseg    0, .1, 1, p3-.2, 1, .1, 0
  kenv      oscili    iamp, ienvspeed, ienvfunc
  asig      oscili    kenv, ifreq, iwavefunc
  ktri      oscili    kclean, ienvspeed, itrifunc
  aout      =  asig * ktri
            outs      aout*ileft, aout*iright
endin

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

;i4 0 dur freq amp env
instr 1
  iop       =  1/p3
  iamp      =  p5 * 10000
  ienvfunc  =  1
  isrcfunc  =  p6
  itremsp   =  p7 * 10.0
  iseed     =  p8
  ilen      =  ftlen( isrcfunc )
  iadjust   =  1
  ifreq     =  (p4 * (sr/ilen)) * iadjust
  ifsp      =  .5 + (3 * iseed )
  kdev      randi     ifreq*.05*iseed, ifsp, iseed
  kfreq     =  ifreq + kdev
  kenv      oscili    iamp, iop, ienvfunc
  kam       randi     iamp, itremsp, iseed
  asine     oscili    kenv+kam,kfreq,isrcfunc,0   ;f1 0 8192 10 1
            out       asine
endin

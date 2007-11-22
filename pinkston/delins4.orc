  sr        =  22050
  kr        =  2205
  ksmps     =  10
  nchnls    =  2


instr   4       ;vdelay vibrato
  icps      =  cpspch(p5)                         ;basic pitch
  ilfohz    =  p6                                 ;LFO rate in cps
  idelfac   =  p7                                 ;between 0 & .999
  imaxdel   =  p8                                 ;max delay in secs
  ilfoamp   =  idelfac*imaxdel/2                  ;lfo fn is +/- 1
  kgate     linen     p4,.1,p3,.2                 ;basic note envlp
  avarydel  oscili    ilfoamp,ilfohz,1            ;fn1 is LFO wave
  asig      oscili    kgate,icps,2                ;fn2 is Osc wave
  adelay    =  imaxdel/2+avarydel                 ;offset to .5 max
  aout      vdelay    asig,adelay,imaxdel         ;varying delay
            outs      aout,aout       
endin           



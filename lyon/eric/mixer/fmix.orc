  sr        =  44100
  kr        =  8820
  ksmps     =  5

; lookup function for mixing sound

instr 1
  ifile     =  p4
  iskip     =  p5
  ifunc     =  p6
  igain     =  p7
  ifinc     =  1.0/p3
  kenv      oscili    igain, ifinc, ifunc
  asig      soundin   ifile,iskip
            out       kenv*asig
endin

;abuses two files : second file gets inverse amplitude
instr 2
  ifile1    =  p4
  iskip1    =  p5
  ifile2    =  p6
  iskip2    =  p7
  ifunc     =  p8
  igain     =  p9
  ifinc     =  1.0/p3
  kenv1     oscili    igain, ifinc, ifunc
  kenv2     =  igain - kenv1
  a1        soundin   ifile1,iskip1        
  a2        soundin   ifile2,iskip2
  aout      =  a1*kenv1 + a2*kenv2
            out       aout
endin
instr 10
  ifile     =  p4
  iskip     =  p5
  ifunc     =  p6
  igain     =  p7
  ifinc     =  1.0/p3
  kenv      oscili    igain, ifinc, ifunc
  kenv      =  igain - kenv
  asig      soundin   ifile,iskip
            out       kenv*asig
endin

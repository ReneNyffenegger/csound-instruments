  sr        =  44100
  kr        =  8820
  ksmps     =  5
  nchnls    =  2
; lookup function for mixing sound

instr 1
  ifile     =  p4
  iskip     =  p5
  ifunc     =  p6
  igain     =  p7
  ifinc     =  1.0/p3
  kenv      oscili    igain, ifinc, ifunc
  a1,a2     soundin   p4,p5
            outs      kenv*a1, kenv*a2
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
  a1,a2     soundin   ifile1,iskip1     
  a3,a4     soundin   ifile2,iskip2
  aout1     =  a1*kenv1 + a3*kenv2
  aout2     =  a2*kenv1 + a4*kenv2
            outs      aout1, aout2
endin

; abuses two files : second file gets inverse amplitude
; each file is always strong in one channel
instr 3
  ifile1    =  p4
  iskip1    =  p5
  ifile2    =  p6
  iskip2    =  p7
  ifunc     =  p8
  igain     =  p9
  ifinc     =  1.0/p3
  kenv1     oscili    igain, ifinc, ifunc
  kenv2     =  igain - kenv1
  a1,a2     soundin   ifile1,iskip1     
  a3,a4     soundin   ifile2,iskip2
  aout1     =  a1*kenv1 + a2*kenv2
  aout2     =  a3*kenv1 + a4*kenv2
            outs      aout1, aout2
endin

; file gets inverse amplitude
instr 10
  ifile1    =  p4
  iskip1    =  p5
  ifunc     =  p6
  igain     =  p7
  ifinc     =  1.0/p3
  kenv1     oscili    igain, ifinc, ifunc
  kenv      =  igain - kenv1
  a1,a2     soundin   p4,p5
            outs      kenv*a1, kenv*a2
endin

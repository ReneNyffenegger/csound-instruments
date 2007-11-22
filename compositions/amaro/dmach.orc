  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  2
  gipiotwo  =  1.570796

; mono in, increment == 1.0
instr 1
  igain     =  p5
  iloc      =  p6*gipiotwo
  igain1    =  igain * cos( iloc )
  igain2    =  igain * sin( iloc )
  a1        soundin   p4,0
            outs      igain1*a1,igain2*a1
endin

; stereo in, increment == 1.0
instr 2  
  igain     =  p5
  iloc      =  p6*gipiotwo
  igain1    =  igain * cos( iloc )
  igain2    =  igain * sin( iloc )
  a1,a2     soundin   p4,0
            outs      igain1*a1,igain2*a2
endin

; mono in, variable increment
instr 3
  ifunc     =  p4
  igain     =  p5
  iloc      =  p6*gipiotwo
  iincr     =  (sr/ftlen(ifunc))*p7
  igain1    =  igain * cos( iloc )
  igain2    =  igain * sin( iloc )
  asig      oscili    1.0, iincr, ifunc
            outs      asig*igain1, asig*igain2
endin

; stereo in, variable increment
instr 4
  ifunc1    =  p4
  ifunc2    =  ifunc1 + 1
  igain     =  p5
  iloc      =  p6*gipiotwo
  iincr     =  (sr/ftlen(ifunc1))*p7
  igain1    =  igain * cos( iloc )
  igain2    =  igain * sin( iloc )
  asig1     oscili    igain1, iincr, ifunc1
  asig2     oscili    igain2, iincr, ifunc2
            outs      asig1, asig2
endin

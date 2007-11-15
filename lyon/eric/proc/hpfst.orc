  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

;i1 0 dur file skip rolloff gain
;stereo in
instr 1
  irolloff  =  p6
  igain     =  p7
  ipack     =  4                                  ; shorts
  a1,a2     soundin   p4,p5, ipack
  a1        =  a1*igain
  a2        =  a2*igain
  alp1      atone     a1,irolloff
  alp2      atone     a2,irolloff
            outs      alp1,alp2
endin

  sr        =  44100
  kr        =  4410
;sr=22050
;kr=2205
  ksmps     =  10
; NOT TOO SUCCESSFUL
  ginoisp   =  5000
  gifeedback   =      .4
;i1 0 dur freq amp atk dk
instr 1
  ispeed    =  (1/p3)
  iampfunc  =  p4
  ifreqfunc =  p5
  ipts      =  p6
  iseed     =  p7

  kdx       phasor    ispeed
  kamp      table     kdx*ipts, iampfunc
  kfreq     table     kdx*ipts, ifreqfunc
  krev1     =  1./(kfreq * .95)
  krev2     =  1./(kfreq * 1.05)
  krcf      =  kfreq + (kfreq*1.05)
  kbw       =  krcf/50
contin:
  anoise    randi     1.0,ginoisp,iseed
  addl      delayr    2.0
  asig1     deltapi   krev1
  asig2     deltapi   krev2
  anoise    =  anoise+(asig1+asig2)*gifeedback
            delayw    anoise
  asig      reson     asig1+asig2,krcf,kbw,1
            out       asig*kamp
endin

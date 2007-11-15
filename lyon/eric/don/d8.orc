  sr        =  44100
  kr        =  882
  ksmps     =  50

; self feed back
instr 100
  gasig3    =  0
endin
instr 1
  ifbsp     =  2.
  ifbseed   =  p8
  itsize    =  5
  itsize2   =  6
  itsize3   =  3
  itsize4   =  7

  isd1      =  p4
  isd2      =  p5
  isd3      =  p6
  isd4      =  p7

  iminf     =  20.
  imaxf     =  7000.
  ifdif     =  imaxf-iminf

  kfeedback randi     .5, ifbsp, ifbseed
  kfeedback =  (kfeedback+.5)*.35 
  kdx       line      0,p3,itsize
  krspeed   table     kdx, 2
  krnd      randi     .5, krspeed, isd1
  kfr1      =  (krnd+.5)*ifdif + iminf
  asig1     oscil     1, kfr1 + (gasig3*kfr1*kfeedback), 1

  kdx       line      0,p3,itsize2
  krspeed   table     kdx, 3
  krnd      randi     .5, krspeed, isd2
  kfr2      =  (krnd+.5)*ifdif + iminf
  asig2     oscil     1, kfr2 + (asig1*kfr2), 1

  kdx       line      0,p3,itsize3
  krspeed   table     kdx, 4
  krnd      randi     .5, krspeed, isd3
  kfr3      =  (krnd+.5)*ifdif + iminf
  gasig3    oscil     1, kfr3 + (asig2*kfr3), 1

;       kdx     line 0,p3,itsize4
;       krspeed table kdx, 5
;       krnd    randi .5, krspeed, isd4
;       kfr4 = (krnd+.5)*ifdif + iminf
;       asig4   oscil 10000, kfr4 + (asig3*kfr4), 1

            out       gasig3*10000
endin
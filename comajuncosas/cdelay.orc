  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  2
            zakinit   20,20


instr 1 ;simple signal to test
  ifreq     =  p4
  ipan      =  p5

  kenv      expon     1,.3,.0000001
  asig      vco       kenv,ifreq,1,1,1,1
  a1        =  5000*asig*p5
  a2        =  5000*asig*(1-p5)

            zaw       a1,0
            zaw       a2,1
            outs      a1,a2
endin


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
instr 5;stereo delay with damped cross feedback rotation matrix
;(a weird name for a rather ordinary effect)
;josep m comajuncosas / july 21 / 2000
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  idlt      =  p4                                 ; delay time (in sec.)
  idamp     =  p5                                 ; damping factor (0 to 1,1 gives no damping and 0 gives total attenuation/no delay))
  ispread   =  p6                                 ; rotation angle (-1 to 1,0 gives no cross feedback, 1/-1 gives crossed delay w. L/R phase inversion)
  ifco      =  p7                                 ; freq.cutoff attenuation (in Hz)

  i2pi      =  6.283185307179

  ain1      zar       0
  ain2      zar       1

  adel1     delayr    idlt
  adel2     delayr    idlt

  acos      =  cos(ispread*i2pi)
  asin      =  sin(ispread*i2pi)

  across1   =  acos*adel1 + asin*adel2
  across2   =  -asin*adel1 + acos*adel2

  afdbk1    tone      across1+ain1,ifco
  afdbk2    tone      across2+ain2,ifco

            delayw    idamp*afdbk1
            delayw    idamp*afdbk2

            outs      adel1,adel2
endin
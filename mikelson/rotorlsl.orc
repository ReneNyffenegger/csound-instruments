;***************************************************
; Tone Wheel Organ with Rotating Speaker
;***************************************************

sr     = 44100
kr     = 2205
ksmps  = 20
nchnls = 2

instr 1 ; Rotor Organ #2

  gaorgan  init 0
  gaorgan2 init 0

  iphase = p2
; ikey = p6
  ikey = 12*int(p5-6) + 100*(p5-6)
  ifqc = cpspch(p5)

; The lower tone wheels have increased odd harmonic content.
  iwheel1  = ((ikey-12) > 12 ? 1:2)
  iwheel2  = ((ikey+7)  > 12 ? 1:2)
  iwheel3  = (ikey      > 12 ? 1:2)
  iwheel4  = 1
  
  kenv linseg 0, .01, p4, p3-.02, p4, .01, 0

  asubfund oscil p6,  .5*ifqc,      iwheel1, iphase/(ikey-12)
  asub3rd  oscil p7,  1.4983*ifqc,  iwheel2, iphase/(ikey+7)
  afund    oscil p8,  ifqc,         iwheel3, iphase/ikey
  a2nd     oscil p9,  2*ifqc,       iwheel4, iphase/(ikey+12)
  a3rd     oscil p10, 2.9966*ifqc,  iwheel4, iphase/(ikey+19)
  a4th     oscil p11, 4*ifqc,       iwheel4, iphase/(ikey+24)
  a5th     oscil p12, 5.0397*ifqc,  iwheel4, iphase/(ikey+28)
  a6th     oscil p13, 5.9932*ifqc,  iwheel4, iphase/(ikey+31)
  a8th     oscil p14, 8*ifqc,       iwheel4, iphase/(ikey+36)

  gaorgan = gaorgan + kenv*(asubfund + asub3rd + afund + a2nd + a3rd + a4th + a5th + a6th + a8th)
  gaorgan2 = gaorgan

endin

;Rotating Speaker
instr 3

; Speaker phase offset
  ioff = p4

; Phase separation between right and left
  isep = p5

; Global input from organ
  asig = gaorgan

; Distortion effect A lazy "S" curve.  Use table 6 for more distortion.
  asig = asig/40000
  aclip tablei asig, 5, 1, .5
  aclip = aclip*16000

; Delay buffer for rotating speaker
  aleslie delayr .02, 1
          delayw aclip

; Acceleration
  kenv    linseg .8, 1, 8, 2, 8, 1, .8, 2, .8, 1, 8, 1, 8
  kenvlow linseg .7, 2, 7, 1, 7, 2, .7, 1, .7, 2, 7, 1, 7

; Upper Doppler Effect
  koscl oscil 1, kenv, 1, ioff
  koscr oscil 1, kenv, 1, ioff + isep
  kdopl = .01-koscl*.0002
  kdopr = .012-koscr*.0002
  aleft deltapi kdopl
  aright deltapi kdopr

; Lower Effect
  koscllow oscil 1, kenvlow, 1, ioff
  koscrlow oscil 1, kenvlow, 1, ioff + isep
  kdopllow = .01-koscllow*.0003
  kdoprlow = .012-koscrlow*.0003
  aleftlow  deltapi kdopllow
  arightlow deltapi kdoprlow

; Filter Effect
; Divide into three frequency ranges for directional sound.

;  High Pass
  alfhi  butterbp aleft,   7000, 6000
  arfhi  butterbp aright,  7000, 6000

;  Band Pass
  alfmid butterbp aleft,   3000, 2000
  arfmid butterbp aright,  3000, 2000

;  Low Pass
  alflow butterlp aleftlow,   1000
  arflow butterlp arightlow,  1000

  kflohi  oscil 1, kenv, 3, ioff
  kfrohi  oscil 1, kenv, 3, ioff + isep
  kflomid oscil 1, kenv, 4, ioff
  kfromid oscil 1, kenv, 4, ioff + isep
  
; Amplitude Effect on Lower Speaker
  kalosc = koscllow * .4 + 1
  karosc = koscrlow * .4 + 1

; Add all frequency ranges and output the result.
  outs alfhi*kflohi+alfmid*kflomid+alflow*kalosc, arfhi*kfrohi+arfmid*kfromid+arflow*karosc

  gaorgan = 0

endin

;Rotating Speaker
instr 4

; Speaker phase offset
  ioff = p4

; Phase separation between right and left
  isep = .2

; Global input from organ
  asig = gaorgan2

; Distortion effect A lazy "S" curve.  Use table 6 for more distortion.
  asig = asig/40000
  aclip tablei asig, 5, 1, .5
  aclip = aclip*16000

; Delay buffer for rotating speaker
  aleslie delayr .02, 1
          delayw aclip

; Acceleration
  kenv    linseg .8, 1, 8, 2, 8, 1, .8, 2, .8, 1, 8, 1, 8
  kenvlow linseg .7, 2, 7, 1, 7, 2, .7, 1, .7, 2, 7, 1, 7

; Upper Doppler Effect
  koscl oscil 1, kenv, 1, ioff
  koscr oscil 1, kenv, 1, ioff + isep
  kdopl = .01-koscl*.0002
  kdopr = .012-koscr*.0002
  aleft deltapi kdopl
  aright deltapi kdopr

; Lower Effect
  koscllow oscil 1, kenvlow, 1, ioff
  koscrlow oscil 1, kenvlow, 1, ioff + isep
  kdopllow = .01-koscllow*.0003
  kdoprlow = .012-koscrlow*.0003
  aleftlow  deltapi kdopllow
  arightlow deltapi kdoprlow

; Filter Effect
; Divide into three frequency ranges for directional sound.

;  High Pass
  alfhi  butterbp aleft,   7000, 6000
  arfhi  butterbp aright,  7000, 6000

;  Band Pass
  alfmid butterbp aleft,   3000, 2000
  arfmid butterbp aright,  3000, 2000

;  Low Pass
  alflow butterlp aleftlow,   1000
  arflow butterlp arightlow,  1000

  kflohi  oscil 1, kenv, 3, ioff
  kfrohi  oscil 1, kenv, 3, ioff + isep
  kflomid oscil 1, kenv, 4, ioff
  kfromid oscil 1, kenv, 4, ioff + isep
  
; Amplitude Effect on Lower Speaker
  kalosc = koscllow * .4 + 1
  karosc = koscrlow * .4 + 1


  outs alfhi*kflohi+alfmid*kflomid+alflow*kalosc, arfhi*kfrohi+arfmid*kfromid+arflow*karosc

  gaorgan2 = 0

endin


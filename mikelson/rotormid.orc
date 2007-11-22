;------------------------------------------------------------------------
; Tone Wheel Organ with Rotating Speaker
;------------------------------------------------------------------------

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

;------------------------------------------------------------------------
; Global Rotor Speed/Drawbar Initialization
;------------------------------------------------------------------------

instr 1
  gispeedf  init      p4
  gksubfund init      p5
  gksub3rd  init      p6
  gkfund    init      p7
  gk2nd     init      p8
  gk3rd     init      p9
  gk4th     init      p10
  gk5th     init      p11
  gk6th     init      p12
  gk8th     init      p13
  giclick   init      p14
  giperc2   init      p15
  giperc3   init      p16

; Central Shaft
  gkphase   oscil     1, 1, 7

endin
        
;------------------------------------------------------------------------
; This instrument acts as the foot switch controlling rotor speeds.
;------------------------------------------------------------------------
instr 2

  gispeedi  init      gispeedf                    ;Save old speed
  gispeedf  init      p4                          ;update new speed

  gkenv     linseg    gispeedi*.8,1,gispeedf*.8,.01,gispeedf*.8 ;High freq. rotor acceleration
  gkenvlow  linseg    gispeedi*.7,2,gispeedf*.7,.01,gispeedf*.7 ;Low freq. rotor acceleration

endin

;------------------------------------------------------------------------
; Tone Wheel Organ
;------------------------------------------------------------------------
instr 3

  inn       notnum    
  iamp      veloc     
  iamp      =  (iamp = 0 ? 0 : 100)
  ipch      =  int(inn/12)+frac(inn/12)*12/100+3

  gaorgan   init      0                           ;Global send to speaker
  ikey      init      12*int(ipch-6)+100*(ipch-6) ;Keyboard key pressed.
  ifqc      init      cpspch(ipch)                ;Convert to cycles/sec.
  iwheel1   init      ((ikey-12) > 12 ? 1:2)      ;The lower 12 tone wheels have
  iwheel2   init      ((ikey+7)  > 12 ? 1:2)      ;increased odd harmonic content.
  iwheel3   init      (ikey      > 12 ? 1:2)
  iwheel4   init      1                       
  
;------------------------------------------------------------------------
  kamp      linenr    iamp, .01, .01, .01

; Percussion
  kpercenv  linseg    0, .01, 8, .2, 0, .01, 0
  gk2nd     =  (giperc2 = 1 ? kpercenv : gk2nd)   ; If percussion is on envelope the second.
  gk3rd     =  (giperc3 = 1 ? kpercenv : gk3rd)   ; If percussion is on envelope the third.

;------------------------------------------------------------------------
  asubfund  oscil     gksubfund, .5*ifqc,      iwheel1, i(gkphase)/(ikey-12) ;The organ tone is
  asub3rd   oscil     gksub3rd,  1.4983*ifqc,  iwheel2, i(gkphase)/(ikey+7) ;made from adding
  afund     oscil     gkfund,    ifqc,         iwheel3, i(gkphase)/ikey ;the weighted output
  a2nd      oscil     gk2nd,     2*ifqc,       iwheel4, i(gkphase)/(ikey+12) ;of 9 equal temperament
  a3rd      oscil     gk3rd,     2.9966*ifqc,  iwheel4, i(gkphase)/(ikey+19) ;tone wheels.
  a4th      oscil     gk4th,     4*ifqc,       iwheel4, i(gkphase)/(ikey+24)
  a5th      oscil     gk5th,     5.0397*ifqc,  iwheel4, i(gkphase)/(ikey+28)
  a6th      oscil     gk6th,     5.9932*ifqc,  iwheel4, i(gkphase)/(ikey+31)
  a8th      oscil     gk8th,     8*ifqc,       iwheel4, i(gkphase)/(ikey+36)

; Key Click
  kclickenv linseg    0, .005, giclick, .01, 0, .01, 0
  anoise    rand      kclickenv
  aclick    tone      anoise, 10000

  gaorgan   =  gaorgan+kamp*(asubfund+asub3rd+afund+a2nd+a3rd+a4th+a5th+a6th+a8th+aclick)

endin

;------------------------------------------------------------------------
;Rotating Speaker
;------------------------------------------------------------------------
instr  4

  ioff      init      p4
  isep      init      p5                          ;Phase separation between right and left
  iradius   init      .00025                      ;Radius of the rotating horn.
  iradlow   init      .00035                      ;Radius of the rotating scoop.
  ideleng   init      .02                         ;Length of delay line.

;------------------------------------------------------------------------
  asig      =  gaorgan                            ;Global input from organ

;------------------------------------------------------------------------
  asig      =  asig/40000                         ;Distortion effect using waveshaping.
  aclip     tablei    asig,5,1,.5                 ;A lazy "S" curve, use table 6 for increased
  aclip     =  aclip*16000                        ;distortion.

;------------------------------------------------------------------------
  aleslie   delayr    ideleng,1                   ;Put "clipped" signal into a delay line.
            delayw    aclip

;------------------------------------------------------------------------
  koscl     oscil     1,gkenv,1,ioff              ;Doppler effect is the result
  koscr     oscil     1,gkenv,1,ioff+isep         ;of delay taps oscillating
  kdopl     =  ideleng/2-koscl*iradius            ;through the delay line.  Left
  kdopr     =  ideleng/2-koscr*iradius            ;and right are slightly out of phase
  aleft     deltapi   kdopl                       ;to simulate separation between ears
  aright    deltapi   kdopr                       ;or microphones

;------------------------------------------------------------------------
  koscllow  oscil     1,gkenvlow,1,ioff           ;Doppler effect for the
  koscrlow  oscil     1,gkenvlow,1,ioff+isep      ;lower frequencies.
  kdopllow  =  ideleng/2-koscllow*iradlow
  kdoprlow  =  ideleng/2-koscrlow*iradlow
  aleftlow  deltapi   kdopllow
  arightlow deltapi   kdoprlow

;------------------------------------------------------------------------
  alfhi     butterbp  aleft,5000,4000             ;Divide the frequency into three
  arfhi     butterbp  aright,5000,4000            ;groups and modulate each with a
  alfmid    butterbp  aleft,2000,1500             ;different width pulse to account
  arfmid    butterbp  aright,2000,1500            ;for different  dispersion
  alflow    butterlp  aleftlow,500                ;of different frequencies.
  arflow    butterlp  arightlow,500

  kflohi    oscil     1,gkenv,3,ioff
  kfrohi    oscil     1,gkenv,3,ioff+isep
  kflomid   oscil     1,gkenv,4,ioff
  kfromid   oscil     1,gkenv,4,ioff+isep
  
;------------------------------------------------------------------------
; Amplitude Effect on Lower Speaker
  kalosc    =  koscllow*.4+1
  karosc    =  koscrlow*.4+1

; Add all frequency ranges and output the result.
            outs      alfhi*kflohi+2*alfmid*kflomid+alflow*kalosc, arfhi*kfrohi+2*arfmid*kfromid+arflow*karosc

endin

;------------------------------------------------------------------------
;Rotating Speaker without Deflectors
;------------------------------------------------------------------------
instr  5

  ioff      init      p4
  isep      init      p5                          ;Phase separation between right and left
  iradius   init      .00025                      ;Radius of the rotating horn.
  iradlow   init      .00035                      ;Radius of the rotating scoop.
  ideleng   init      .02                         ;Length of delay line.

;------------------------------------------------------------------------
  asig      =  gaorgan                            ;Global input from organ

;------------------------------------------------------------------------
  asig      =  asig/40000                         ;Distortion effect using waveshaping.
  aclip     tablei    asig,5,1,.5                 ;A lazy "S" curve, use table 6 for increased
  aclip     =  aclip*16000                        ;distortion.

;------------------------------------------------------------------------
  aleslie   delayr    ideleng,1                   ;Put "clipped" signal into a delay line.
            delayw    aclip

;------------------------------------------------------------------------
  koscl     oscil     1,gkenv,1,ioff              ;Doppler effect is the result
  koscr     oscil     1,gkenv,1,ioff+isep         ;of delay taps oscillating
  kdopl     =  ideleng/2-koscl*iradius            ;through the delay line.  Left
  kdopr     =  ideleng/2-koscr*iradius            ;and right are slightly out of phase
  aleft     deltapi   kdopl                       ;to simulate separation between ears
  aright    deltapi   kdopr                       ;or microphones

;------------------------------------------------------------------------
  koscllow  oscil     1,gkenvlow,1,ioff           ;Doppler effect for the
  koscrlow  oscil     1,gkenvlow,1,ioff+isep      ;lower frequencies.
  kdopllow  =  ideleng/2-koscllow*iradlow
  kdoprlow  =  ideleng/2-koscrlow*iradlow
  aleftlow  deltapi   kdopllow
  arightlow deltapi   kdoprlow

;------------------------------------------------------------------------
  alfhi     butterbp  aleft,5000,4000             ;Divide the frequency into three
  arfhi     butterbp  aright,5000,4000            ;groups and modulate each with a
  alfmid    butterbp  aleft,2000,1500             ;different width pulse to account
  arfmid    butterbp  aright,2000,1500            ;for different  dispersion
  alflow    butterlp  aleftlow,500                ;of different frequencies.
  arflow    butterlp  arightlow,500

; Note Tables 13 & 14 are for no deflectors.
  kflohi    oscil     1,gkenv,13,ioff
  kfrohi    oscil     1,gkenv,13,ioff+isep
  kflomid   oscil     1,gkenv,14,ioff
  kfromid   oscil     1,gkenv,14,ioff+isep
  
;------------------------------------------------------------------------
; Amplitude Effect on Lower Speaker
  kalosc    =  koscllow*.4+1
  karosc    =  koscrlow*.4+1

; Add all frequency ranges and output the result.
            outs      alfhi*kflohi+2*alfmid*kflomid+alflow*kalosc, arfhi*kfrohi+2*arfmid*kfromid+arflow*karosc

endin

;------------------------------------------------------------------------
;Rotating Speaker
;------------------------------------------------------------------------
instr  6

  ioff      init      p4
  isep      init      p5                          ;Phase separation between right and left
  iradius   init      .00025                      ;Radius of the rotating horn.
  iradlow   init      .00035                      ;Radius of the rotating scoop.
  ideleng   init      .02                         ;Length of delay line.

;------------------------------------------------------------------------
  asig      =  gaorgan                            ;Global input from organ

;------------------------------------------------------------------------
  asig      =  asig/40000                         ;Distortion effect using waveshaping.
  aclip     tablei    asig,5,1,.5                 ;A lazy "S" curve, use table 6 for increased
  aclip     =  aclip*16000                        ;distortion.

;------------------------------------------------------------------------
  aleslie   delayr    ideleng,1                   ;Put "clipped" signal into a delay line.
            delayw    aclip

;------------------------------------------------------------------------
  koscl     oscil     1,gkenv,1,ioff              ;Doppler effect is the result
  koscr     oscil     1,gkenv,1,ioff+isep         ;of delay taps oscillating
  kdopl     =  ideleng/2-koscl*iradius            ;through the delay line.  Left
  kdopr     =  ideleng/2-koscr*iradius            ;and right are slightly out of phase
  aleft     deltapi   kdopl                       ;to simulate separation between ears
  aright    deltapi   kdopr                       ;or microphones

;------------------------------------------------------------------------
  koscllow  oscil     1,gkenvlow,1,ioff           ;Doppler effect for the
  koscrlow  oscil     1,gkenvlow,1,ioff+isep      ;lower frequencies.
  kdopllow  =  ideleng/2-koscllow*iradlow
  kdoprlow  =  ideleng/2-koscrlow*iradlow
  aleftlow  deltapi   kdopllow
  arightlow deltapi   kdoprlow

;------------------------------------------------------------------------
  alfhi     butterbp  aleft,5000,4000             ;Divide the frequency into three
  arfhi     butterbp  aright,5000,4000            ;groups and modulate each with a
  alfmid    butterbp  aleft,2000,1500             ;different width pulse to account
  arfmid    butterbp  aright,2000,1500            ;for different  dispersion
  alflow    butterlp  aleftlow,500                ;of different frequencies.
  arflow    butterlp  arightlow,500

  kflohi    oscil     1,gkenv,3,ioff
  kfrohi    oscil     1,gkenv,3,ioff+isep
  kflomid   oscil     1,gkenv,4,ioff
  kfromid   oscil     1,gkenv,4,ioff+isep
  
;------------------------------------------------------------------------
; Amplitude Effect on Lower Speaker
  kalosc    =  koscllow*.4+1
  karosc    =  koscrlow*.4+1

; Add all frequency ranges and output the result.
            outs      alfhi*kflohi+2*alfmid*kflomid+alflow*kalosc, arfhi*kfrohi+2*arfmid*kfromid+arflow*karosc

  gaorgan   =  0

endin

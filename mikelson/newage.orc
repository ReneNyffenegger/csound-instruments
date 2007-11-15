;---------------------------------------------------------------------------
; New Age Bull
;---------------------------------------------------------------------------

  sr        =  44100
  kr        =  22050
  ksmps     =  2
  nchnls    =  2
            zakinit   30, 30

;---------------------------------------------------------------------------
; Waveguide Pluck
;---------------------------------------------------------------------------
instr  2

  iamp      =  p4
  ifqc      =  cpspch(p5)                         ; Convert to frequency
  itab1     =  p6                                 ; Initial table
  iatk      =  p7                                 ; Attack
  ioutch    =  p8                                 ; Output channel
  isus      =  p9
  p3        =  p3+isus
  imeth     =  1

  kamp      linseg    0, iatk, 1, p3-iatk-.05, 1, .05, 0 ; Amplitude

  aplk      pluck     iamp, ifqc, ifqc, itab1, imeth ; Pluck waveguide model
            zawm      aplk*kamp, ioutch           ; Write to output
endin

;---------------------------------------------------------------------------
; LFO
;---------------------------------------------------------------------------
instr   7
  iamp      init      p4
  ifqc      init      p5
  itab1     init      p6
  iphase    init      p7
  ioffset   init      p8
  iout      init      p9

  koscil    oscil     iamp, ifqc, itab1, iphase   ;Table oscillator
  kout      =  koscil+ioffset

            zkw       kout, iout                  ;Send to output channel

endin


;---------------------------------------------------------------------------------
; Bass Synth
;---------------------------------------------------------------------------------
instr   20

  idur      =  p3
  iamp      =  p4/10
  ifqc      =  cpspch(p5)
  ifco      =  p6
  irez      =  p7
  iband     =  p8
  ioutch    =  p9
  ifqcadj   =  .149659863*sr

  kamp      linseg    0,       .005, iamp, .1, .6*iamp, idur-.13, .5*iamp, .02, 0
  kfco      linseg    .2*ifco, .005, ifco, .1, .3*ifco, idur-.13, .2*ifco, .02, .2*ifco
  krez      linseg    irez/2, .8*idur, irez, .2*idur, irez/2

  apulse1   buzz      1,ifqc, sr/2/ifqc, 1        ; Avoid aliasing
  apulse3   buzz      1,ifqc, sr/2/ifqc, 1
  apulse2   delay     apulse3, 1/ifqc/2
  avpw      =  apulse1 - apulse2                  ; two inverted pulses at variable distance
  apwmdc    integ     avpw
  atri      integ     apwmdc
  axn       butterhp  atri, 10                    ; remove DC offset caused by integ

; Resonant Lowpass Filter (4 Pole)
  kc        =  ifqcadj/kfco
  krez2     =  krez/(1+exp(kfco/11000))
  ka1       =  kc/krez2-(1+krez2*iband)
  kasq      =  kc*kc
  kb        =  1+ka1+kasq

  ayn       nlfilt    axn/kb, (ka1+2*kasq)/kb, -kasq/kb, 0, 0, 1
  ayn2      nlfilt    ayn/kb, (ka1+2*kasq)/kb, -kasq/kb, 0, 0, 1

            zaw       kamp*ayn, ioutch
endin

;---------------------------------------------------------------------------------
; Female Ahh
;---------------------------------------------------------------------------------
instr   30
  idur      =  p3
  ifq       =  cpspch(p4)
  ioutch    =  p6
  ibendtab  =  p7

  k1        oscil     2, 3, 1                     ; vibrato
  kbend     oscili    1, 1/idur, ibendtab
  k2        linseg    .5, .02, 0, idur-.04, 0, .02, .5 ; octaviation coefficient
  kamp      linseg    0, .14, 1, .5*p3-.12, .6, .5*p3-.12, 1, .1, 0
  kfqc      =  ifq*kbend+k1

;                           koct                      iolaps  ifnb
;          xamp  xfund  xform    kband kris  kdur  kdec    ifna    idur
;  Base amplitude of 20000

  a1        fof       371, kfqc,  564, k2, 200, .003, .017, .005, 50, 1,19, idur, 0, 1
  a2        fof       186, kfqc, 1156, k2, 200, .003, .017, .005, 50, 1,19, idur, 0, 1
  a3        fof       113, kfqc, 1748, k2, 200, .003, .017, .005, 50, 1,19, idur, 0, 1
  a4        fof       117, kfqc, 3552, k2, 200, .003, .017, .005, 50, 1,19, idur, 0, 1
  a5        fof       103, kfqc, 4116, k2, 200, .003, .017, .005, 50, 1,19, idur, 0, 1
  a6        fof       51, kfqc, 2340, k2, 200, .003, .017, .005, 50, 1,19, idur, 0, 1
  a7        fof       58, kfqc, 2932, k2, 200, .003, .017, .005, 50, 1,19, idur, 0, 1
  a8        fof       53, kfqc, 7641, k2, 200, .003, .017, .005, 50, 1,19, idur, 0, 1
  a9        fof       56, kfqc, 8205, k2, 200, .003, .017, .005, 50, 1,19, idur, 0, 1

  abal1     =  p5*500

  a10       balance   (a1 + a2 + a3 + a4 + a5 + a6 + a7 + a8/2 + a9/2), abal1

  anoise    rand      1000*kamp
  a12       reson     anoise, 1156, 150
  a13       reson     anoise, 3778, 175
  a14       reson     anoise, 8177, 390
  a15       reson     anoise, 10000, 250

  a20       balance   (a12 + a13 + a14 + a15/2), a10/8

  aout      =  (a10+a20)*kamp
            zaw       aout, ioutch

endin

;---------------------------------------------------------------------------
;Lorenz Attractor
;---------------------------------------------------------------------------
instr  8

  iamp      init      p4/40
  kx        init      p5
  ky        init      p6
  kz        init      p7
  is        init      p8
  ir        init      p9
  ib        init      p10
  ih        init      p11/kr*1.2
  ioutch    init      p12
  ioffset   init      p13

  kxnew     =  kx+ih*is*(ky-kx)
  kynew     =  ky+ih*(-kx*kz+ir*kx-ky)
  kznew     =  kz+ih*(kx*ky-ib*kz)

  kx        =  kxnew
  ky        =  kynew
  kz        =  kznew

;printk   .5, kx
;printk   .5, ky
;printk   .5, kz

            zkw       kx*iamp+ioffset, ioutch
endin

;---------------------------------------------------------------------------
; Chorus
;---------------------------------------------------------------------------
instr   35

  imixch    =  p4                                 ; Mix of chorused signal
  imix      =  1-imixch                           ; Mix of direct signal
  izin      =  p5                                 ; Input channel
  izout     =  p6                                 ; Output channel
  ikin      =  p7                                 ; Input K Channel

  asig      zar       izin                        ; Read input channel
  kinsig    zkr       ikin                        ; Read K Input

  adel1     vdelay    asig, kinsig, 100           ; Variable delay tap
  aout      =  adel1*imixch+asig*imix             ; Mix direct and chorused signals

;aout     =       kinsig*500
            zaw       aout, izout                 ; Write to output channel

endin

;---------------------------------------------------------------------------
; Wave
;---------------------------------------------------------------------------
instr 41

  idur      =  p3
  iamp      =  p4
  ifqc      =  p5
  irate     =  p6
  iwave1    =  p7
  iwave2    =  p8
  iamptab   =  p9

  adel1     init      0
  adel2     init      0

  krate     zkr       irate
  kamp1     oscili    1, krate, iwave1
  kamp2     oscili    1, krate, iwave2
  kamp3     oscili    1, 1/idur, iamptab

  kosc1     oscil     20, .5, 1
  kosc2     oscil     20, .5, 1, .25

  kdel1     =  kosc1+21
  kdel2     =  kosc2+21

  anoise    rand      iamp/10

  a1        reson     anoise, ifqc*3, ifqc
  a2        reson     anoise, ifqc,  ifqc/3

  aout1     =  kamp1*a1*kamp3
  aout2     =  kamp2*a2*kamp3

  adel1     delay     aout1, .15
  adel2     delay     aout2, .15

            outs      aout1-.5*adel2, aout2-.5*adel1

endin

;---------------------------------------------------------------------------
; The Birds
;---------------------------------------------------------------------------
instr 42

  idur      =  p3
  iamp      =  p4
  ifqc      =  cpspch(p5)
  iwrbfm    =  p6
  iwrbrt    =  p7
  iwrbam    =  p8
  iwave     =  p9
  ioutch    =  p10

  iwbeg     =  (iwrbfm>0 ? 1+iwrbfm     : 1/(1-iwrbfm)) ; Determine whether to
  iwend     =  (iwrbfm>0 ? 1/(1+iwrbfm) : 1-iwrbfm) ; ramp up or down.

  kamp      linseg    0, .01, iamp, idur-.02, iamp, .01, 0 ; Declick

; Frequency Modulation
  krate     linseg    iwbeg, idur, iwend
  kfmod     oscil     iwrbam*krate, iwrbrt*krate, 1
  kfmod     =  1+kfmod
  kfqc      =  kfmod*ifqc

  aout      oscil     kamp*kfmod, kfqc, iwave

            zawm      aout, ioutch

endin

;---------------------------------------------------------------------------
; More Birds
;---------------------------------------------------------------------------
instr 43

  idur      =  p3
  iamp      =  p4
  ifqc      =  cpspch(p5)
  iform1    =  p6
  iform2    =  p7
  iform3    =  p8
  ioutch    =  p9
  irate     =  p10

  kamp      linseg    0, .01, iamp, idur-.02, iamp, .01, 0 ; Declick
  aamp      oscil     1, 500, 1

;koc    linseg 0, idur/2, 0, idur/2, 2
;kfqc   linseg ifqc*4, idur, ifqc/4
  koc       oscil     2, irate, 5
  kfqc      oscil     ifqc*4, irate, 5
  kamp2     oscil     1, irate, 19

;      xamp   xfund xform   koct kband kris  kdur  kdec  iolaps ifnb ifna Dur
  a1        fof       1,     kfqc, iform1, koc, 50,   .003, .017, .005, 50,    1,   19,  idur, 0, 1
  a2        fof       1,     kfqc, iform2, koc, 50,   .003, .017, .005, 50,    1,   19,  idur, 0, 1
  a3        fof       1,     kfqc, iform3, koc, 50,   .003, .017, .005, 50,    1,   19,  idur, 0, 1

  aout      balance   a1+a2+a3/2, aamp

            zawm      aout*kamp, ioutch

endin

;---------------------------------------------------------------------------------
; String Pad (Band Limited Impulse Train)
;---------------------------------------------------------------------------------
instr   50

  p3        =  p3+.2
  idur      =  p3
  iamp      =  p4
  ifqc      =  cpspch(p5)
  iampenv   =  p6
  ifcotab   =  p7
  ireztab   =  p8
  ioutch    =  p9
  iband     =  0

  kamp      linseg    0, .5, iamp, idur-.7, iamp, .2, 0
  kfco      oscili    1, 1/(p3), ifcotab
  krez      oscili    1, 1/(p3), ireztab
  ifqcadj   =  .149659863*sr
  klfo1     oscili    .1, 1.5, 1
  klfo2     oscili    .1, 1.5, 1, .21
  klfo3     oscili    .1, 1.5, 1, .43

  kfco      oscil     1, 1/idur, ifcotab
  krez      oscil     1, 1/idur, ireztab

  apulse1   buzz      1,ifqc, sr/2/ifqc, 1        ; Avoid aliasing
  apulse3   buzz      1,ifqc, sr/2/ifqc, 1
  apulse2   vdelay    apulse3, 1000/ifqc/(klfo1+1)/2, 1000/ifqc ;
  avpw1     =  apulse1 - apulse2                  ; two inverted pulses at variable distance
  apwmdc1   integ     avpw1

  apulse4   buzz      1,ifqc*.995, sr/2/ifqc, 1   ; Avoid aliasing
  apulse6   buzz      1,ifqc*.995, sr/2/ifqc, 1
  apulse5   vdelay    apulse6, 1000/ifqc/(klfo2+1)/2*.995, 1000/ifqc ;
  avpw2     delay     apulse4 - apulse5, .05      ; two inverted pulses at variable distance
  apwmdc2   integ     avpw2

  apulse7   buzz      1,ifqc*.997, sr/2/ifqc, 1   ; Avoid aliasing
  apulse9   buzz      1,ifqc*.997, sr/2/ifqc, 1
  apulse8   vdelay    apulse6, 1000/ifqc/(klfo2+1)/2*.997, 1000/ifqc ;
  avpw3     delay     apulse7 - apulse8, .02      ; two inverted pulses at variable distance
  apwmdc3   integ     avpw3

  axn       =  apwmdc1+apwmdc2+apwmdc3

; Resonant Lowpass Filter (4 Pole)
  kc        =  ifqcadj/kfco
  krez2     =  krez/(1+exp(kfco/11000))
  ka1       =  kc/krez2-(1+krez2*iband)
  kasq      =  kc*kc
  kb        =  1+ka1+kasq

  ayn       nlfilt    axn/kb, (ka1+2*kasq)/kb, -kasq/kb, 0, 0, 1
  ayn2      nlfilt    ayn/kb, (ka1+2*kasq)/kb, -kasq/kb, 0, 0, 1

            zawm      kamp*ayn2, ioutch
endin
;-------------------------------------------------------------
;Flute Instrument based on Perry Cook's Slide Flute
;-------------------------------------------------------------
instr  60

  aflute1   init      0
  ifqc      =  cpspch(p5)
  ipress    =  .9                                 ;p6
  ibreath   =  .01                                ;p7
  ifeedbk1  =  .4                                 ;p8
  ifeedbk2  =  .4                                 ;p9
  ibendtab  =  p6
  ioutch    =  p7
  iaccnt    =  p8
  kbreath   linseg    0, .005, .4*iaccnt, .2, 0, p3-.205, 0

;-------------------------------------------------------------
  kenv1     linseg    0,.01,iaccnt*1.4*ipress,.1,ipress,p3-.17,ipress,.06,0
;Flow setup
  kenv2     linseg    0,.01,1,p3-.02,1,.01,0      ;Flow must be about 1 or it will blow up
  kenvibr   linseg    0,.5,0,.5,1,p3-1,1          ; Vibrato envelope
  kvbrate   oscil     1, 1, 1
  kvibr     oscil     .02*kenvibr,5+kvbrate,1     ;Low frequency vibrato
  kbend     oscil     1, 1/p3, ibendtab

;-------------------------------------------------------------
  arnd0     rand      p4
  arnd1     reson     arnd0, 1230, 200
  arnd2     reson     arnd0, 3202, 1000
  arnd3     reson     arnd0, 6402, 2000

  abal1     =  kenv1
  aflow1    balance   arnd1+arnd2+arnd3,  abal1+kvibr ;Noise is used to simulate breath sound.
  asum1     =  ibreath*aflow1+kenv1+kvibr         ;Add flow, noise and vibrato.
  asum2     =  asum1+aflute1*ifeedbk1             ;Add above to scaled feedback.
  afqc      =  1/ifqc/kbend-asum1/20000-4/sr+ifqc/kbend/5000000 ;Find delay length.

;-------------------------------------------------------------
  atemp1    delayr    1/ifqc/2                    ;The embouchoure delay should
  ax        deltapi   afqc/2                      ;be about 1/2 the bore delay.
            delayw    asum2

;-------------------------------------------------------------
  apoly     =  ax-ax*ax*ax                        ;A polynomial is used to adjust
  asum3     =  apoly+aflute1*ifeedbk2             ;the feedback.

  kfco      linseg    4000, .1, 1000, .1, 2400, p3-.2, 2000
  avalue    tone      asum3, kfco

; Bore, the bore length determines pitch.  Shorter is higher pitch.
;-------------------------------------------------------------
  atemp2    delayr    1/ifqc
  aflute1   deltapi   afqc
            delayw    avalue

  khpenv    linseg    600, .3, 20, p3-.3, 20
  aout      butterhp  avalue, khpenv

            zaw       (aout+kbreath*(arnd2+arnd3)/400000)*p4*kenv2, ioutch

endin

;---------------------------------------------------------------------------
; Mixer
;---------------------------------------------------------------------------
instr 100

  idur      init      p3
  iamp      init      p4
  inch      init      p5
  ipan      init      p6
  ifader    init      p7
  ioutch    init      p8

  asig1     zar       inch                        ; Read input channel 1

  kfader    oscil     1, 1/idur, ifader
  kpanner   oscil     1, 1/idur, ipan

  kgl1      =  kfader*sqrt(kpanner)               ; Left gain
  kgr1      =  kfader*sqrt(1-kpanner)             ; Right gain

  kdclick   linseg    0, .002, iamp, idur-.002, iamp, .002, 0 ; Declick

  asigl     =  asig1*kgl1                         ; Scale and sum
  asigr     =  asig1*kgr1

            outs      kdclick*asigl, kdclick*asigr ; Output stereo pair
            zaw       kdclick*kfader*asig1, ioutch ; Output postfader

endin

;----------------------------------------------------------------------------------
; Large Room Reverb
;----------------------------------------------------------------------------------
instr  105

  idur      =  p3
  iamp      =  p4
  iinch1    =  p5
  igain1    =  p6
  iinch2    =  p7
  igain2    =  p8
  iinch3    =  p9
  igain3    =  p10

  aout91    init      0
  adel01    init      0
  adel11    init      0
  adel51    init      0
  adel52    init      0
  adel91    init      0
  adel92    init      0
  adel93    init      0

  kdclick   linseg    0, .002, iamp, idur-.004, iamp, .002, 0

  ain1      zar       iinch1
  ain2      zar       iinch2
  ain3      zar       iinch3
  asig0     =  igain1*ain1+igain2*ain2+igain3*ain3

  aflt01    butterlp  asig0, 4000                 ; Pre-Filter
  aflt02    butterbp  .8*aout91, 1000, 500        ; Feed-Back Filter
  asum01    =  aflt01+.5*aflt02                   ; Initial Mix

; All-Pass 1
  asub01    =  adel01-.3*asum01
  adel01    delay     asum01+.3*asub01,.008

; All-Pass 2
  asub11    =  adel11-.3*asub01
  adel11    delay     asub01+.3*asub11,.012

; Delay 1
  adel21    delay     asub11, .004

; Out 1
  aout31    =  1.5*adel21

; Delay 2
  adel41    delay     adel21, .017

; Single Nested All-Pass
  asum51    =  adel52-.25*adel51
  aout51    =  asum51-.5*adel41
  adel51    delay     adel41+.5*aout51, .025
  adel52    delay     adel51+.25*asum51, .062

; Delay 3
  adel61    delay     aout51,.031

; Out 2
  aout71    =  .8*adel61

; Delay 4
  adel81    delay     adel61, .003

; Double Nested All-Pass
  asum91    =  adel92-.25*adel91
  asum92    =  adel93-.25*asum91
  aout91    =  asum92-.5*adel81
  adel91    delay     adel81+.5*aout91, .120
  adel92    delay     adel91+.25*asum91, .076
  adel93    delay     asum91+.25*asum92, .030

  aout      =  .8*aout91+aout71+aout31

            outs      aout*kdclick, -aout*kdclick

endin


;---------------------------------------------------------------------------
; Clear audio & control channels
;---------------------------------------------------------------------------
instr 110

            zacl      0, 30                       ; Clear audio channels 0 to 30
            zkcl      0, 30                       ; Clear control channels 0 to 30

endin




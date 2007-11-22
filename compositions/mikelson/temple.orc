;---------------------------------------------------------------------------------
; A SET OF BAND LIMITED INSTRUMENTS WITH RESONANT FILTER
; BY HANS MIKELSON 11/20/97
; PARTIALLY DERIVED FROM CODE BY JOSEP Mª COMAJUNCOSAS-CSOUND & TIM STILSON-CCRMA
;---------------------------------------------------------------------------------
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2
            zakinit   30, 30

;---------------------------------------------------------------------------------
; LOW FREQUENCY OSCILLATOR
instr     1

  iamp      =  p4
  ilfo      =  p5
  iwave     =  p6
  ioutch    =  p7

  klfo      oscil     iamp, ilfo, iwave
            zkw       klfo, ioutch

endin

;---------------------------------------------------------------------------------
; ENVELOPE
instr     2

  idur      =  p3
  iamp      =  p4
  ishape    =  p5
  ioutch    =  p6

  kenv      oscil     iamp, 1/idur, ishape
            zkw       kenv, ioutch

endin

;---------------------------------------------------------------------------------
; PULSE WIDTH MODULATION (BAND LIMITED IMPULSE TRAIN)
instr     10

  idur      =  p3
  iamp      =  p4
  ifqc      =  cpspch(p5)
  iampenv   =  p6
  ifcotab   =  p7
  ireztab   =  p8
  ifcoch    =  p9
  irezch    =  p10
  ilfoch    =  p11
  ipanl     =  sqrt(p12)
  ipanr     =  sqrt(1-p12)

  kdclik    linseg    0, .002, iamp, idur-.004, iamp, .002, 0
  kamp      oscil     kdclik, 1/idur, iampenv 
  kfcoe     oscil     1, 1/idur, ifcotab
  kreze     oscil     1, 1/idur, ireztab
  kfcoc     zkr       ifcoch
  krezc     zkr       irezch
  kfco      =  kfcoe*kfcoc
  krez      =  kreze*krezc
  ifqcadj   =  6600

  klfo      zkr       ilfoch
  kfqc      =  ifqc+klfo
  kfco      oscil     1, 1/idur, ifcotab
  krez      oscil     1, 1/idur, ireztab

  apulse1   buzz      1,ifqc, sr/2/ifqc, 1        ; AVOID ALIASING
  apulse3   buzz      1,kfqc, sr/2/kfqc, 1
  apulse2   delay     apulse3, 1/ifqc/2           ; A BETTER IDEA?
  avpw      =  apulse1 - apulse2                  ; TWO INVERTED PULSES AT VARIABLE DISTANCE
  apwmdc    integ     avpw
  axn       =  apwmdc-.5                          ; REMOVE DC OFFSET CAUSED BY INTEG

; RESONANT LOWPASS FILTER (4 POLE)
  ka1       =  ifqcadj/krez/kfco-1
  ka2       =  ifqcadj/kfco
  kasq      =  ka2*ka2
  kb        =  1+ka1+kasq

  ayn       nlfilt    axn/kb, (ka1+2*kasq)/kb, -kasq/kb, 0, 0, 1
  ayn2      nlfilt    ayn/kb, (ka1+2*kasq)/kb, -kasq/kb, 0, 0, 1

            outs      kamp*ayn2*ipanl, kamp*ayn2*ipanr
endin

;---------------------------------------------------------------------------------
; RECTANGLE WAVE (BAND LIMITED IMPULSE TRAIN)
instr     11

  idur      =  p3
  iamp      =  p4
  ifqc      =  cpspch(p5)
  iampenv   =  p6
  ifcotab   =  p7
  ireztab   =  p8
  ifcoch    =  p9
  irezch    =  p10
  ipw       =  p11

  kdclik    linseg    0, .002, iamp, idur-.004, iamp, .002, 0
  kamp      oscil     kdclik, 1/idur, iampenv 
  kfcoe     oscil     1, 1/idur, ifcotab
  kreze     oscil     1, 1/idur, ireztab
  kfcoc     zkr       ifcoch
  krezc     zkr       irezch
  kfco      =  kfcoe*kfcoc
  krez      =  kreze*krezc

  kfco      oscil     1, 1/idur, ifcotab
  krez      oscil     1, 1/idur, ireztab

  apulse1   buzz      1,ifqc, sr/2/ifqc, 1        ; AVOID ALIASING
  apulse3   buzz      1,ifqc, sr/2/ifqc, 1
  apulse2   delay     apulse3, 1/ifqc*ipw         ; A BETTER IDEA?
  avpw      =  apulse1 - apulse2                  ; TWO INVERTED PULSES AT VARIABLE DISTANCE
  apwmdc    integ     avpw
  axn       =  apwmdc-.5                          ; REMOVE DC OFFSET CAUSED BY INTEG

; RESONANT LOWPASS FILTER (4 POLE)
  ka1       =  1000/krez/kfco-1
  ka2       =  100000/kfco/kfco
  kb        =  1+ka1+ka2
  ayn       nlfilt    axn/kb, (ka1+2*ka2)/kb, -ka2/kb, 0, 0, 1
  ayn2      nlfilt    ayn/kb, (ka1+2*ka2)/kb, -ka2/kb, 0, 0, 1

            outs      kamp*ayn2, kamp*ayn2
endin

;---------------------------------------------------------------------------------
; SAWTOOTH (BAND LIMITED IMPULSE TRAIN)
instr     12

  idur      =  p3
  iamp      =  p4
  ifqc      =  cpspch(p5)
  iampenv   =  p6
  ifcotab   =  p7
  ireztab   =  p8
  ifcoch    =  p9
  irezch    =  p10
  ipanl     =  sqrt(p11)
  ipanr     =  sqrt(1-p11)
  ioutch1   =  p12
  ioutch2   =  p13

  kdclik    linseg    0, .002, iamp, idur-.004, iamp, .002, 0
  kamp      oscil     kdclik, 1/idur, iampenv 
  kfcoe     oscil     1, 1/idur, ifcotab
  kreze     oscil     1, 1/idur, ireztab
  kfcoc     zkr       ifcoch
  krezc     zkr       irezch
  kfco      =  kfcoe*kfcoc
  krez      =  kreze*krezc

  apulse    buzz      1,ifqc, sr/2/ifqc, 1        ; AVOID ALIASING
  asawdc    integ     apulse
  axn       =  asawdc-.5

; RESONANT LOWPASS FILTER (4 POLE)
  ka1       =  1000/krez/kfco-1
  ka2       =  100000/kfco/kfco
  kb        =  1+ka1+ka2
  ayn       nlfilt    axn/kb, (ka1+2*ka2)/kb, -ka2/kb, 0, 0, 1
  ayn2      nlfilt    ayn/kb, (ka1+2*ka2)/kb, -ka2/kb, 0, 0, 1

  aoutl     =  kamp*ayn2*ipanl
  aoutr     =  kamp*ayn2*ipanr
            outs      aoutl, aoutr
            zawm      aoutl, ioutch1
            zawm      aoutr, ioutch2

endin

;---------------------------------------------------------------------------------
; TWO OSCILLATOR SAWTOOTH  (BAND LIMITED IMPULSE TRAIN)
instr     13

  idur      =  p3
  iamp      =  p4
  ifqcm     =  cpspch(p5)
  ifqcs     =  p6*ifqcm
  iamps     =  p7
  iampenv   =  p8
  ifcotab   =  p9
  ireztab   =  p10
  ifcoch    =  p11
  irezch    =  p12
  ipanl     =  sqrt(p13)
  ipanr     =  sqrt(1-p13)
  ioutchl   =  p14
  ioutchr   =  p15

  kamp      linseg    0, .02, iamp, idur-.07, .6*iamp, .05, 0 
  kfcoe     oscil     1, 1/idur, ifcotab
  kreze     oscil     1, 1/idur, ireztab
  kfcoc     zkr       ifcoch
  krezc     zkr       irezch
  kfco      =  kfcoe*kfcoc
  krez      =  kreze*krezc

  apuls1    buzz      1,ifqcm, sr/2/ifqcm, 1      ; AVOID ALIASING
  apuls2    buzz      iamps,ifqcs, sr/2/ifqcs, 1
  asawos    integ     apuls1+apuls2
  axn       =  asawos-1

; RESONANT LOWPASS FILTER (4 POLE)
  ka1       =  1000/krez/kfco-1
  ka2       =  100000/kfco/kfco
  kb        =  1+ka1+ka2
  ayn       nlfilt    axn/kb, (ka1+2*ka2)/kb, -ka2/kb, 0, 0, 1
  ayn2      nlfilt    ayn/kb, (ka1+2*ka2)/kb, -ka2/kb, 0, 0, 1

  aoutl     =  kamp*ayn2*ipanl
  aoutr     =  kamp*ayn2*ipanr
            outs      aoutl, aoutr
            zawm      aoutl, ioutchl
            zawm      aoutr, ioutchr
endin

;---------------------------------------------------------------------------------
; RAMP/SAW MODULATION (BAND LIMITED IMPULSE TRAIN) LEVELS NEED ADJUSTING
instr     14

  idur      =  p3
  iamp      =  p4
  ifqc      =  cpspch(p5)
  iampenv   =  p6
  ifcotab   =  p7
  ireztab   =  p8
  ifcoch    =  p9
  irezch    =  p10
  ilfoch    =  p11

  kdclik    linseg    0, .002, iamp, idur-.004, iamp, .002, 0
  kamp      oscil     kdclik, 1/idur, iampenv 
  kfcoe     oscil     1, 1/idur, ifcotab
  kreze     oscil     1, 1/idur, ireztab
  kfcoc     zkr       ifcoch
  krezc     zkr       irezch
  kfco      =  kfcoe*kfcoc
  krez      =  kreze*krezc

  klfo      zkr       ilfoch
  kfqc      =  ifqc+klfo
  kfco      oscil     1, 1/idur, ifcotab
  krez      oscil     1, 1/idur, ireztab

  apulse1   buzz      1,ifqc, sr/2/ifqc, 1        ; AVOID ALIASING
  apulse3   buzz      1,kfqc, sr/2/kfqc, 1
  apulse2   delay     apulse3, 1/ifqc/2           ; A BETTER IDEA?
  avpw      =  apulse1 - apulse2                  ; TWO INVERTED PULSES AT VARIABLE DISTANCE
  apwmdc    integ     avpw
  apwm      butterhp  apwmdc,5                    ; REMOVE DC OFFSET CAUSED BY INTEG
  asawrmp   integ     apwm
  asrnorm   =  2*ifqc/sr/klfo/1.5/(1-klfo/1.5)/100
  axn       butterhp  asrnorm,10

; RESONANT LOWPASS FILTER (4 POLE)
  ka1       =  1000/krez/kfco-1
  ka2       =  100000/kfco/kfco
  kb        =  1+ka1+ka2
  ayn       nlfilt    axn/kb, (ka1+2*ka2)/kb, -ka2/kb, 0, 0, 1
  ayn2      nlfilt    ayn/kb, (ka1+2*ka2)/kb, -ka2/kb, 0, 0, 1

            outs      kamp*axn, kamp*asawrmp
endin

;---------------------------------------------------------------------------------
; DELAY
instr     30

  idur      =  p3
  iamp      =  p4
  idtime    =  p5
  ifco      =  p6
  ifeedbk   =  p7
  ixfdbk    =  p8
  inchl     =  p9
  inchr     =  p10
  afsigl    init      0
  afsigr    init      0
  adsigl    init      0
  adsigr    init      0

  kdclick   linseg    0, .002, iamp, idur-.004, iamp, .002, 0

  asigl     zar       inchl
  asigr     zar       inchr

  afdbkl    =  asigl+ifeedbk*(afsigl+adsigl)/2+ixfdbk*(afsigr+adsigr)/2
  afdbkr    =  asigr+ifeedbk*(afsigr+adsigr)/2+ixfdbk*(afsigl+adsigl)/2

  adsigl    delay     afdbkl, idtime
  adsigr    delay     afdbkr, idtime

  afsigl    butterlp  adsigl, ifco
  afsigr    butterlp  adsigr, ifco

            outs      afdbkl*kdclick, afdbkr*kdclick
            zacl      0,30
endin




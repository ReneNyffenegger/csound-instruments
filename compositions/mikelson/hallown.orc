; A CSOUND HALLOWEEN PART 1

; 1. WIND
; 2. WOLF HOWL
; 3. THUNDER
; 4. PIPE ORGAN
; 5. CREAKING DOOR
; 6. CHURCH BELL
; 7. MOANING
; 8. BUBBLING CAULDRON
; 9. BIG METAL DOOR SLAM
;10. ELECTRIC ZAP (MANDELBROT SET)
;11. GHOSTIES 1
;12. GHOSTIES 2
;13. ELECTRONIC NOISES *
;14. SCURRYING RATS *
;15. FLUTTERING BATS *
;16. GHOSTS *
;17. CHAINS *
;18. THUMPING *
;19. SCREAMS *
;* NOT IMPLEMENTED YET
;* SUGGESTED MUSIC (NOT IMPLEMENTED)
;BACH'S TOCATTA AND FUGUE IN DM (INTRO)
;MUGORSKI'S NIGHT ON BALD MOUNTAIN *
;DANCE MACABRE *
;THE CAT CAME BACK *
                    
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

            zakinit   30, 30

; THESE ARE FOR LYON'S REVERB

  gifeed    init      .5
  gilp1     init      1/10
  gilp2     init      1/23
  gilp3     init      1/41
  giroll    init      3000

; WIND    
instr     1
  idur      =  p3
  iamptab   =  p4
  ifq1tab   =  p5
  ifq2tab   =  p6
  ipantab   =  p7
     
  kamp      oscil     1, 1/idur, iamptab
  kfq1      oscil     1, 1/idur, ifq1tab
  kfq2      oscil     1, 1/idur, ifq2tab
  kpan      oscil     1, 1/idur, ipantab
     
  anoise    rand      kamp

  ares1     reson     anoise, kfq1, kfq1/20
  ares2     reson     anoise, kfq2, kfq2/2

  abal1     balance   ares1, anoise
  abal2     balance   ares2, anoise

            outs      (abal1+abal2)*kpan, (abal1+abal2)*(1-kpan)

endin

; WOLF HOWL
instr     2
  idur      =  p3
  iamp      =  p4
  ifqtab    =  p5
  ifrmtab   =  p6
  ipan      =  p7
  ifco      =  p8

; k2      linseg    .5, idur*.1, 0, idur*.9, 0  ; OCTAVIATION COEFFICIENT
  k2        init      0
  kfqci     oscil     1, 1/idur, ifqtab
  kfqc2     linseg    0, .1, .8, .1, 1, idur-.1, 1
  kamp      linseg    0, .01, iamp, .05, iamp*2, .1, iamp, idur-.17, iamp*.1, .01, 0
  krnamp    linseg    .05, .05, 3.5, .15, .05, .5, 0, .01, 0

  krnd      randh     krnamp*kfqci/4, 5000
  kfqc      =  kfqci*kfqc2+(krnd+krnamp*kfqci/8)

  kfq1      oscil     1,    1/idur, ifrmtab
  kfa1      oscil     1,    1/idur, ifrmtab+1
  kfq2      oscil     1,    1/idur, ifrmtab+2
  kfa2      oscil     1,    1/idur, ifrmtab+3
  kfq3      oscil     1,    1/idur, ifrmtab+4
  kfa3      oscil     1,    1/idur, ifrmtab+5
  kfq4      oscil     1,    1/idur, ifrmtab+6
  kfa4      oscil     1,    1/idur, ifrmtab+7
  kfq5      oscil     1,    1/idur, ifrmtab+8
  kfa5      oscil     1,    1/idur, ifrmtab+9

  kfqc3     =  kfqc*.7

;              xamp  xfund     xform koct kband kris  kdur  kdec  iolaps ifna ifnb idur
  a1        fof       kfa1, kfqc3, kfq1, k2,  400,  .003, .017, .005, 20,       1,   19,  idur, 0, 1
  a2        fof       kfa2, kfqc,     kfq2, k2,  200,  .003, .017, .005, 20,    1,   19,  idur, 0, 1
  a3        fof       kfa3, kfqc,     kfq3, k2,  200,  .003, .017, .005, 20,    1,   19,  idur, 0, 1
  a4        fof       kfa4, kfqc,     kfq4, k2,  200,  .003, .017, .005, 20,    1,   19,  idur, 0, 1
  a5        fof       kfa5, kfqc,     kfq5, k2,  200,  .003, .017, .005, 20,    1,   19,  idur, 0, 1

  a6        =  (a1/3 + a2 + a3 + a4 + a5) * kamp

  a7        tone      a6, ifco
            outs      a7*ipan, a7*(1-ipan)
endin

; THUNDER
instr     3

  idur      =  p3
  iamp      =  p4
  ifqc      =  p5
  ifco      =  p6
  iatk      =  p7
  ipanl     =  p8
  ipanr     =  1-p8
  aop4      init      0

  kamp      linseg    0, .001, iamp, idur-.002, iamp, .001, 0
  kamp1     linseg    0, .01*iatk, 1, .2*idur-.01*iatk, .8, .8*idur, 0
  kamp2     linseg    0, .01*iatk, 1, .2*idur-.01*iatk, .8, .8*idur, 0
  kamp3     linseg    0, .01*iatk, 1, .2*idur-.01*iatk, .8, .8*idur, 0
  kamp4     linseg    0, .01*iatk, 1, .2*idur-.01*iatk, .8, .8*idur, 0

  kfqc      randh     ifqc, 200

  aop4      oscil     10*kamp4,   3*(1+.8*aop4)*kfqc, 1
  aop3      oscil     20*kamp3,     .5*(1+aop4)*kfqc, 1
  aop2      oscil     16*kamp2,            5.19*kfqc, 1
  aop1      oscil     2*kamp1, .5*(1+aop2+aop3)*kfqc, 1

  afilt     tone      aop1, ifco
  aout      balance   afilt, aop1

            outs      aout*kamp*ipanl, aout*kamp*ipanr
;          gain1 = gain1+aout*kamp*ipanl
;          gain2 = gain2+aout*kamp*ipanr

endin

; PIPE ORGAN
instr      4

  idur      =  p3
  iamp      =  p4
  ifqc      =  cpspch(p5)
  ipanl     =  p6
  ipanr     =  1-p6
  ioutch1   =  p7
  ioutch2   =  p8
  iatk      =  10
  iop1f     =  ifqc
  iop2f     =  2.01*ifqc
  iop3f     =  3.99*ifqc
  iop4f     =  8*ifqc
  iop5f     =  .5*ifqc
  iop7f     =  16*ifqc

  kdclick   linseg    0, .001, iamp, idur-.002, iamp, .001, 0
  kamp1     linseg    0, .01, 1, idur-.02, 1, .01, 0
  kamp2     linseg    0, .05, 1, .1, .7, idur-.16, .7, .01, 0
  kamp3     linseg    0, .03, .8, .05, 0, .01, 0
  kamp4     linseg    0, .1, .3, .1, .05, idur-.3, .1, .1, 0

  aop8      oscil     kamp4,   iop5f, 1
  ap1       =  aop8+1
  aop1      oscil     kamp1,   ap1*iop1f, 1
  aop2      oscil     kamp2,   ap1*iop2f, 1
  aop3      oscil     kamp2,   iop3f, 1
  aop4      oscil     kamp2,   iop4f, 1
  aop5      oscil     kamp3,   iop5f*5, 1
;aop6      oscil     kamp2,   iop5f+aop5*ifqc, 1
  aop7      oscil     kamp2,   iop7f, 1

  aout      =  aop1 + aop2 + aop3 + aop4 + aop5 + aop7

            outs      aout*kdclick*ipanl, aout*kdclick*ipanr
            zawm      aout*kdclick*ipanl, ioutch1
            zawm      aout*kdclick*ipanr, ioutch2

endin

; CREAKING DOOR

instr     5
  idur      =  p3
  iamp      =  p4
  ifqc      =  p5
  ifqtab    =  p6
  iwave     =  p7
  ipantab   =  p8
  iamptab   =  p9
;ioutch1   =         p10
;ioutch2   =         p11
  ifq1      =  2000

  koct      linseg    2, idur*.1, 0, idur*.4, 0, idur*.5, 2 ; OCTAVIATION COEFFICIENT
  kfqci     oscil     ifqc, 1/idur, ifqtab
  kpan      oscil     1, 1/idur, ipantab
  kamp      oscil     1, 1/idur, iamptab
  kdclick   linseg    0, .01, iamp, idur-.02, iamp, .01, 0

;                   xamp  xfund     xform koct   kband kris  kdur  kdec  iolaps ifna   ifnb idur
  a1        fof       1,    kfqci, ifq1, koct,  400,     .003, .017, .005, 20,    iwave, 19,  idur, 0, 1

;         zawm      a1*kdclick*kpan*kamp, ioutch1
;         zawm      a1*kdclick*(1-kpan)*kamp, ioutch2
            outs      a1*kpan*kdclick*kamp, a1*(1-kpan)*kdclick*kamp
endin

; CHURCH BELL

instr        6

  idur      =  p3
  iamp      =  p4
  ifqc      =  cpspch(p5)
  ipanl     =  p6
  ipanr     =  1-p6
  ioutch1   =  p7
  ioutch2   =  p8
  aop4      init      0

  kamp      linseg    0, .001, iamp, idur-.002, iamp, .001, 0
  kamp1     linseg    0, .01, 1, .3, .6, idur-.51, .4, .2, 0
  kamp2     linseg    0, .01, 1, .4, .3, .4, .1, idur-.81, 0
  kamp3     linseg    0, .01, 1, .1, .6, .4, .4, .4, .1, idur-.91, 0

  klfo      oscil     1, .5, 1, .5

  kfqc      =  ifqc + klfo

;aop3    oscil      9*kamp3,              3.14*kfqc, 1
  aop3      oscil     2*kamp3,             3.14*kfqc, 1
  aop2      oscil     .2*kamp2,             .78*kfqc, 1
  aop1      oscil     kamp1,            (1+aop2+aop3)*kfqc, 1

  aout      =  aop1

            outs      aout*kamp*ipanl, aout*kamp*ipanr
            zawm      aout*kamp*ipanl, ioutch1
            zawm      aout*kamp*ipanr, ioutch2

endin

; MOANING
        
instr     7
  idur      =  p3
  iamp      =  p4
  ifqc      =  p5
  ifqtab    =  p6
  iwave     =  p7
  ipantab   =  p8
  iamptab   =  p9
  ifq1      =  400
  ifq2      =  770
  ifq3      =  1090
  ifq4      =  1440

;koct     linseg    2, idur*.1, 0, idur*.4, 0, idur*.5, 2    ; OCTAVIATION COEFFICIENT
  koct      =  0
  kfqci     oscil     ifqc, 1/idur, ifqtab
  kpan      oscil     1, 1/idur, ipantab
  kamp      oscil     1, 1/idur, iamptab
  kdclick   linseg    0, .01, iamp, idur-.02, iamp, .01, 0

;                   xamp  xfund     xform koct   kband kris  kdur  kdec  iolaps ifna   ifnb idur
  a1        fof       1,    kfqci, ifq1, koct,  10,  .025, .15,     .005, 800,    iwave, 19,  idur, 0, 1
  a2        fof       .9,   kfqci, ifq2, koct,  200,     .025, .17,  .005, 10,    iwave, 19,  idur, 0, 1
  a3        fof       .7,   kfqci, ifq3, koct,  200,     .025, .17,  .005, 10,    iwave, 19,  idur, 0, 1
  a4        fof       .8,   kfqci, ifq4, koct,  200,     .025, .17,  .005, 10,    iwave, 19,  idur, 0, 1

  aout      =  a1+a2+a3+a4

            outs      aout*kpan*kdclick*kamp, aout*(1-kpan)*kdclick*kamp
endin

;BUBBLING CAULDRON FROM CUBEWATER , VARIATION ON KIM CASCONE'S WATER BY ELOY ANZOLA

instr 8
                                             
  igain     =  p4
  ifreq     =  p5                                 ;MUST BE VALUES < OR CLOSE TO 1, CONTROLS PITCH
  krt       =  p6                                 ;THIS IS THE FRQ OF THE RANDH OUTPUT & CLK OSC
  ipantab   =  p7

  ksh       randh     5000, krt

  a2        oscil     2, 100, 1                   ;SINE OSC (F1) CONTROLLED BY S&H

  ksh       =  ksh * ifreq                        ;* .5

  a4        reson     a2,ksh,50                   ;FILTER WITH S&H CONTROLING THE FCO
  a3        oscil     a4,1/p3,13                  ;a3 IS THE OUTPUT f13 ADSR

  a3        =  a3 * igain

  kpan      oscil     1,.14, ipantab

  aoutl     =  a3 * (1-kpan)
  aoutr     =  a3 * kpan
        
            outs      aoutl,aoutr

endin

; REVERB & DELAY BY ELOY ANZOLA 
; BIGDOOR BY HANS MIKELSON

instr 9
        
  igain     =  p4
  irvt      =  p5
  ifrq      =  p6
  ifeedb    =  p7
  ilenght   =  p8
  ishfqc    =  p9
  ifco      =  p10
  iatk      =  p11
  ipan      =  p12
        
  kampenv   linseg    0, iatk, 10000, .05, 0, .01, 0
  kfco      linseg    8000, p3, 200
  kdclick   linseg    0, .001, 1, p3-.002, 1, .001, 0
        
  ainsigl   randh     kampenv,ishfqc
  ainfl     tone      ainsigl,ifco
  ainsigr   randh     kampenv,ishfqc
  ainfr     tone      ainsigr,ifco
        
  a1l       alpass    ainfl, ifeedb, ilenght * 1.5 ; DIFFERENT TIME SETTINGS FOR LEFT AND RIGHT
  a2l       reverb2   ainfl, irvt, ifrq
  abkl      =  (a1l * .7 + a2l * .5 ) * igain
        
  a1r       alpass    ainfr, ifeedb, ilenght
  a2r       reverb2   ainfr, irvt * 1.2, ifrq
  abkr      =  (a1r * .7 + a2r * .5 ) * igain
        
  afltl     butterhp  abkl, 10
  asigl     butterlp  afltl, kfco
  afltr     butterhp  abkr, 10
  asigr     butterlp  afltr, kfco
        
            outs      asigl*kdclick*ipan, asigr*kdclick*(1-ipan)
        
endin

; ELECTRIC ZAP BASED ON THE MANDELBROT SET
instr  10

  idur      =  p3
  iamp      =  p4
  ifqc      =  cpspch(p5)
  kxtrace   init      p6
  kytrace   init      p7
  kxstep    init      p8
  kystep    init      p9*ifqc/55
  ilpmax    init      p10
  ipan      init      p11
  kclk      init      1
  aout2     init      0
  kcntold   init      0
  kdy       init      1

  kfco      linseg    200, idur*.3, 5000, idur*.2, 300, idur*.2, 1000, idur*.3, 10000
  kclkold   =  kclk
  kclk      oscil     1, ifqc, 9
  kdclick   linseg    0, .002, iamp, idur-.002, iamp, .002, 0
  
  kcount    =  0
  kx        =  0
  ky        =  0
                                             
mandloop:
                               ; ITERATION FOR CALCULATING THE MANDELBROT SET.

  kxx       =  kx*kx-ky*ky+kxtrace
  kyy       =  2*kx*ky+kytrace
  kx        =  kxx
  ky        =  kyy
  kcount    =  kcount + 1

if        ((kx*kx+ky*ky<4) && (kcount<ilpmax)) goto mandloop

; UPDATE THE TRACES.

  kytrace   =  kytrace + kystep

if        (kclkold == kclk) goto endif1

  kdy       =  -kdy
  kystep    =  kdy*kystep
  kxtrace   =  kxtrace+kxstep

endif1:

  aout1     =  kcount*kdclick
  aout2     tone      aout1, kfco
  aout2     butterhp  aout2, 10
  kcntold   =  kcount

            outs      aout2*ipan, aout2*(1-ipan)
endin

; GHOSTIES 1
;-------------------------------------------------------------

instr 11

; INITIALIZATIONS
                                             
  idlen     init      .2                          ;LENGTH OF THE DELAY LINE.
  iphaz     init      .01                         ;PHASE DIFFERENCE BETWEEN RIGHT AND LEFT EARS.
  ifqc      =  cpspch(p5)                         ;CONVERT PITCH TO FREQUENCY.

; ENVELOPES

  kpanl     linseg    0, p3/3, .1, p3/3, .9, p3/3, 1 ;PAN LEFT
  kpanr     =  1-kpanl                            ;PAN RIGHT
  kdopl     expseg    idlen/3, p3/2, idlen/10, p3/2, idlen/3 ;DOPPLER ENVELOPE
  kdist     linseg    .1, p3/2-idlen/2, 1, p3/2-idlen/2, .1 ;THE SOUND IS QUIETER 
                                                            ;THE FARTHER AWAY IT IS.

; GENERATE NOISE BANDS

  anoize    rand      p4                          ;TAKE A NOISE
  af1       reson     anoize, ifqc, 10            ;AND GENERATE SOME FREQUENCY
  af2       reson     anoize, ifqc*2, 20          ;BANDS TO ADD TOGETHER
  af3       reson     anoize, ifqc*8, 100         ;FOR INPUT TO THE DOPPLER EFFECT.
  asamp     =  af1+af2+af3

; DOPPLER EFFECTS

  adel1     delayr    idlen                       ;THERE HAS TO BE ENOUGH ROOM FOR
  atap1     deltapi   idlen/2+kdopl               ;AN OBJECT COMING FROM A LONG WAYS
  atap2     deltapi   idlen/2+kdopl+iphaz         ;AWAY.  TAKE TWO TAPS FOR RIGHT AND
            delayw    asamp*kdist                 ;LEFT EARS.

; SCALE AND OUTPUT

            outs      atap1*kpanl, atap2*kpanr

endin

; GHOSTIES 2
;-------------------------------------------------------------
instr 12
; INITIALIZATIONS
                                             
  idlen     init      .2                          ;LENGTH OF THE DELAY LINE.
  iphaz     init      .01                         ;PHASE DIFFERENCE BETWEEN RIGHT AND LEFT EARS.
  ifqc      =  cpspch(p5)                         ;CONVERT PITCH TO FREQUENCY.

; ENVELOPES

  kpanl     linseg    0, p3/3, .1, p3/3, .9, p3/3, 1 ;PAN LEFT
  kpanr     =  1-kpanl                            ;PAN RIGHT
  kdopl     expseg    idlen/3, p3/2, idlen/10, p3/2, idlen/3 ;DOPPLER ENVELOPE
  kdist     linseg    .1, p3/2-idlen/2, 1, p3/2-idlen/2, .1 ;THE SOUND IS QUIETER 
                                                            ;THE FARTHER AWAY IT IS.

; GENERATE NOISE BANDS

  anoize    rand      p4                          ;TAKE A NOISE
  af1       reson     anoize, ifqc, 10            ;AND GENERATE SOME FREQUENCY
  af2       reson     anoize, ifqc*2, 20          ;BANDS TO ADD TOGETHER
  af3       reson     anoize, ifqc*8, 100         ;FOR INPUT TO THE DOPPLER EFFECT.
  asamp     =  af1+af2+af3

; DOPPLER EFFECTS

  adel1     delayr    idlen                       ;THERE HAS TO BE ENOUGH ROOM FOR
  atap1     deltapi   idlen/2+kdopl               ;AN OBJECT COMING FROM A LONG WAYS
  atap2     deltapi   idlen/2+kdopl+iphaz         ;AWAY.  TAKE TWO TAPS FOR RIGHT AND
            delayw    asamp*kdist                 ;LEFT EARS.

; SCALE AND OUTPUT

            outs      atap2*kpanr, atap1*kpanl

endin

;---------------------------------------------------------------------------
; REVERB BASED ON LYON'S REVERB
;---------------------------------------------------------------------------
instr      46
  inputdur  =  p3
  iatk      =  .01
  idk       =  .01
  idecay    =  .01

;DATA FOR OUTPUT ENVELOPE
  ioutsust  =  p3-idecay
  idur      =  inputdur-(iatk+idk)
  isust     =  p3-(iatk+idur+idk)
  izin1     init      p6
  izin2     init      p7
  igain     =  p6

  ksweep    oscil     1,1/p3,p5
  korig     =  1-ksweep
  krev      =  ksweep

  kclean    linseg    0,iatk,igain,idur,igain,idk,0,isust,0
  kout      linseg    1,ioutsust,1,idecay,0
  ain1      zar       izin1
  ain2      zar       izin2
  ain1      =  ain1*kclean
  ain2      =  ain2*kclean
  ajunk     alpass    ain1,1.7,.1
  aleft     alpass    ajunk,1.01,.07
  ajunk     alpass    ain2,1.5,.2
  aright    alpass    ajunk,1.33,.05
  kdel1     =  .01
  addl1     delayr    .3
  afeed1    deltapi   kdel1
  afeed1    =  afeed1 + gifeed*aleft
            delayw    aleft

  kdel2     =  .012
  addl2     delayr    .3
  afeed2    deltapi   kdel2
  afeed2    =  afeed2 + gifeed*aright
            delayw    aright

;GLOBAL REVERB

  aglobin   =  (afeed1+afeed2)*.05
  atap1     comb      aglobin,3.3,gilp1
  atap2     comb      aglobin,3.3,gilp2
  atap3     comb      aglobin,3.3,gilp3
  aglobrev  alpass    atap1+atap2+atap3,2.6,.085
  aglobrev  tone      aglobrev,giroll

  kdel3     =  .      05
  addl3     delayr    .2
  agr1      deltapi   kdel3
            delayw    aglobrev

  kdel4     =  .06
  addl4     delayr    .2
  agr2      deltapi   kdel4
            delayw    aglobrev

  arevl     =  agr1+afeed1
  arevr     =  agr2+afeed2
  aoutl     =  (ain1*korig)+(arevl*krev)
  aoutr     =  (ain2*korig)+(arevr*krev)

              
            outs      aoutl*kout, aoutr*kout
            zacl      0, 30
endin


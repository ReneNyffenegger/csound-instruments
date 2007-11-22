  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

  gaoutl    init      0
  gaoutr    init      0
  gain1     init      0
  gain2     init      0

  gifeed    init      .5
  gilp1     init      1/10
  gilp2     init      1/23
  gilp3     init      1/41
  giroll    init      3000


instr 1 ; Explosion

  idur      =  p3
  iamp      =  p4
  ifqc      =  p5
  iatk      =  p6
  ipanl     =  p7
  ipanr     =  1-p7
  aop4      init      0

  kamp      linseg    0, .001, iamp, idur-.002, iamp, .001, 0
  kamp1     linseg    0, .01*iatk, 1, .2*idur, .8, .8*idur, 0
  kamp2     linseg    0, .01*iatk, 1, .2*idur, .8, .8*idur, 0
  kamp3     linseg    0, .01*iatk, 1, .2*idur, .8, .8*idur, 0
  kamp4     linseg    0, .01*iatk, 1, .2*idur, .8, .8*idur, 0

  kfqc      randh     ifqc, 200

  aop4      oscil     10*kamp4,    3*(1+.8*aop4)*kfqc, 1
  aop3      oscil     20*kamp3,      .5*(1+aop4)*kfqc, 1
  aop2      oscil     16*kamp2,             5.19*kfqc, 1
  aop1      oscil     2*kamp1, .5*(1+aop2+aop3)*kfqc, 1

  aout      tone      aop1, ifqc*10

;          outs   aout*kamp*ipanl, aout*kamp*ipanr
  gain1     =  gain1+aout*kamp*ipanl
  gain2     =  gain2+aout*kamp*ipanr

endin

instr 2 ; Explosion

  idur      =  p3
  iamp      =  p4
  ifqc      =  p5
  ipanl     =  p6
  ipanr     =  1-p6

  kampenv   linseg    0, .001, 1, idur-.002, 1, .001, 0
  kamp      expseg    .0001, .1*idur, 1, .2*idur, .1, .7*idur, .0001
  krezenv   linseg    ifqc/10, .05*idur, ifqc, .1*idur, ifqc/20, .01, ifqc/20

  arand1    rand      iamp
  arez1     reson     arand1, krezenv, krezenv/6
  arez1     tone      arand1, krezenv             ;, krezenv/6
  abal1     balance   arez1, arand1

            outs      abal1*kampenv*ipanl, abal1*kampenv*ipanr

endin

instr 3 ; Ray Gun

  idur      =  p3
  iamp      =  p4
  ifqc      =  p5
  ipanl     =  p6
  ipanr     =  1-p6

  kampenv   linseg    0, .001, 1, idur-.002, 1, .001, 0
  kdelenv   linseg    0, idur/4, 0, idur/4, 1, idur/2, 1

  krezenv   linseg    ifqc, .02, ifqc*4, .5*idur, ifqc/2, .01, ifqc/2

  arand1    rand      iamp
  arez1     reson     arand1, krezenv, krezenv/5
  abal1     balance   arez1, arand1

  gaoutl    =  abal1*kampenv*ipanl*kdelenv + gaoutl
  gaoutr    =  abal1*kampenv*ipanr*kdelenv + gaoutr

endin

instr 4  ; Echo

  adel1l    init      0
  adel1r    init      0
  adel2l    init      0
  adel2r    init      0

  kampenv   linseg    0, .01, 1, p3-.02, 1, .01, 0

  adell     =  adel1l + adel2l
  adelr     =  adel1r + adel2r

  asigl     =  gaoutl + .6*adell
  asigr     =  gaoutr + .6*adelr
  afiltl    tone      asigl, 2000
  afiltr    tone      asigr, 2000

  adell     delayr    .5
  adel1l    deltap    .1
  adel2l    deltap    .3
            delayw    afiltl
  adelr     delayr    .5
  adel1r    deltap    .1
  adel2r    deltap    .3
            delayw    afiltr

            outs      asigl*kampenv*2, asigr*kampenv*2

  gaoutl    =  0
  gaoutr    =  0

endin

;Alien Weaponry

instr  5

;--------------------------------------------------------------------
  idur      init      p3
  iamp      init      p4
  ifqc      init      p5
  ifqc2     init      p6
  ax        init      p7
  ay        init      p8
  az        init      p9
  as        init      p10
  ar        init      p11
  ab        init      p12
  ah        init      p13

;--------------------------------------------------------------------
  kamp      linseg    0, .2, iamp, idur-.21, iamp, .01, 0
  krezenv   linseg    50, p3/2, 5000, p3/2, 5000
  kfqc      linseg    ifqc, p3/2, ifqc2, p3/2, ifqc2

  axnew     =  ax+ah*as*(ay-ax)
  aynew     =  ay+ah*(-ax*az+ar*ax-ay)
  aznew     =  az+ah*(ax*ay-ab*az)

;--------------------------------------------------------------------
  ax        =  axnew
  ay        =  aynew
  az        =  aznew

;--------------------------------------------------------------------

  asigx     oscil     1, kfqc*(1+ax), 1
  asigy     oscil     1, kfqc*(1+ay), 1

  arezx     reson     asigx, krezenv, krezenv/8
  aoutx     balance   arezx, asigx
  arezy     reson     asigy, krezenv, krezenv/8
  aouty     balance   arezy, asigy

            outs      aoutx*kamp,aouty*kamp


endin


; Eric Lyon's Reverb

;i1 0 dur file skip gain %orig inputdur atk
instr 11
  inputdur  =  p6
  iatk      =  p7
  idk       =  .01
  idecay    =  .01
;data for output envelope
  ioutsust  =  p3-idecay
  idur      =  inputdur-(iatk+idk)
  isust     =  p3-(iatk+idur+idk)
  iorig     =  p5
  irev      =  1.0-p5

  igain     =  p6
  kclean    linseg    0,iatk,igain,idur,igain,idk,0,isust,0
  kout      linseg    1,ioutsust,1,idecay,0
;        ain1,ain2 soundin ifile,iskip
  ain1      =  gain1
  ain2      =  gain2
  ain1      =  ain1*kclean
  ain2      =  ain2*kclean
  ajunk     alpass    ain1,1.7,.1
  aleft     alpass    ajunk,1.01,.07
  ajunk     alpass    ain2,1.5,.2
  aright    alpass    ajunk,1.33,.05

  kdel1     randi     .01,1,.666
  kdel1     =  kdel1 + .1
  addl1     delayr    .3
  afeed1    deltapi   kdel1
  afeed1    =  afeed1 + gifeed*aleft
            delayw    aleft

  kdel2     randi     .01,.95,.777
  kdel2     =  kdel2 + .1
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

  kdel3     randi     .003,1,.888
  kdel3     =  kdel3 + .05
  addl3     delayr    .2
  agr1      deltapi   kdel3
            delayw    aglobrev

  kdel4     randi     .003,1,.999
  kdel4     =  kdel4 + .05
  addl4     delayr    .2
  agr2      deltapi   kdel4
            delayw    aglobrev

  arevl     =  agr1+afeed1
  arevr     =  agr2+afeed2
  aoutl     =  (ain1*iorig)+(arevl*irev)
  aoutr     =  (ain2*iorig)+(arevr*irev)
            outs      aoutl*kout,aoutr*kout
  gain1     =  0
  gain2     =  0
endin

instr 12
  inputdur  =  p8
  iatk      =  p9
  idk       =  .01
  idecay    =  .01
;data for output envelope
  ioutsust  =  p3-idecay
  idur      =  inputdur-(iatk+idk)
  isust     =  p3-(iatk+idur+idk)
  iorig     =  p7
  irev      =  1.0-p7

  ifile     =  p4
  iskip     =  p5
  igain     =  p6
        ;for mono input 
  kout      linseg    1,ioutsust,1,idecay,0
  asigin    soundin   ifile,iskip
  asigin    =  asigin * igain
  ajunk     alpass    asigin,1.7,.1
  aleft     alpass    ajunk,1.01,.07
  ajunk     alpass    asigin,1.5,.2
  aright    alpass    ajunk,1.33,.05

  kdel1     randi     .01,1,.666
  kdel1     =  kdel1 + .1
  addl1     delayr    .3
  afeed1    deltapi   kdel1
  afeed1    =  afeed1 + gifeed*aleft
            delayw    aleft

  kdel2     randi     .01,.95,.777
  kdel2     =  kdel2 + .1
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

  kdel3     randi     .003,1,.888
  kdel3     =  kdel3 + .05
  addl3     delayr    .2
  agr1      deltapi   kdel3
            delayw    aglobrev

  kdel4     randi     .003,1,.999
  kdel4     =  kdel4 + .05
  addl4     delayr    .2
  agr2      deltapi   kdel4
            delayw    aglobrev

  arevl     =  agr1+afeed1
  arevr     =  agr2+afeed2
;        aoutl = (ain1*iorig)+(arevl*irev)
;        aoutr = (ain2*iorig)+(arevr*irev)
;        outs aoutl*kout,aoutr*kout
endin

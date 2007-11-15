  sr        =  44100
  kr        =  4410
  ksmps     =  15
  nchnls    =  2

  gifeed    =  .5
  gilp1     =  1/10
  gilp2     =  1/23
  gilp3     =  1/41
  giroll    =  3000
;minimum dur = .51

;i1 0 dur freq amp vspeed1 vspeed2 atk dk
;i2 0 dur cf speed pan_init_phase
;i3 0 dur 

instr 100
endin
instr 99
  ga1       =  0
  gares1    =  0
  gares2    =  0
endin
instr 1

  icar      =  p4
  imod      =  icar*.995
  iamp      =  p5*32000
  igain     =  iamp*.45
  idown     =  igain*.4
  ivs1      =  p6
  ivs2      =  p7
  indexsust =  p3-.5
  idev      =  icar*.01
  iatk      =  .04
  idk       =  .15
  isust     =  p3-(iatk+idk)
  aenv      linseg    0,iatk,igain,isust,igain,idk,0
  kvib1     oscil     idev,ivs1,1
  kvib2     oscil     idev,ivs2,1
  kindex    linseg    0,.15,1.5,.15,.6,indexsust,.3,.2,.001
  kidev     randi     .1,13,.555
  kindex    =  (kindex+kidev)*icar
  amod      oscil     kindex,imod,1
  afr1      =  icar + amod + kvib1
  afr2      =  icar + amod + kvib2
  asig1     oscil     aenv,afr1,1
  asig2     oscil     aenv,afr2,1
        ;ga1 = ga1+asig1+asig2
            out       asig1+asig2
endin
instr 2
  ipotoo    =  1.570796
  ip        =  ipotoo/2
  icf       =  p4
  ispeed    =  p5/4.0
  iphs      =  p6
  ibfac     =  .15
  ibw       =  icf*ibfac
  kloc      oscili    ip, ispeed, 2, iphs         ;f1 is a sine
  kloc      =  kloc+ip
  a1        soundin   1,0
  ares      reson     ga1,icf,ibw,1
  kleft     =  cos(kloc)
  kright    =  sin(kloc)
  gares1    =  gares1 + kleft*ares
  gares2    =  gares2 + kright*ares
  ga1       =  0
endin

instr 3
  iorig     =  .25
  irev      =  1.0-iorig
  iatk      =  .05
  idk       =  .2
  isust     =  p3-(iatk+idk)

  igain     =  1.0
  aenv      linseg    0,iatk,igain,isust,igain,idk,0
  ain1      =  gares1 * aenv
  ain2      =  gares2* aenv
  gares1    =  0
  gares2    =  0
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
  aoutl     =  (aleft*iorig)+(arevl*irev)
  aoutr     =  (aright*iorig)+(arevr*irev)
            outs      aoutl*aenv,aoutr*aenv
endin

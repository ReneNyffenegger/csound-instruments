  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2


  gifeed    =  .5
  gilp1     =  1/10
  gilp2     =  1/23
  gilp3     =  1/41
  giroll    =  3000
  gadrysig  init      0

instr     2307
  idryamt   =  1-p4
  iwetamt   =  p4
  asndfile  soundin   "speech1.aif", 0
  gadrysig  =  gadrysig+asndfile*iwetamt
            outs      asndfile*idryamt, asndfile*idryamt
endin

instr     2314
  atmp      alpass    gadrysig, 1.7, .1
  aleft     alpass    atmp, 1.01, .07
  atmp      alpass    gadrysig, 1.5, .2
  aright    alpass    atmp, 1.33, .05
  kdel1     randi     .01, 1, .666
  kdel1     =  kdel1+.1
  addl1     delayr    .3
  afeed1    deltapi   kdel1
  afeed1    =  afeed1+gifeed*aleft
            delayw    aleft
  kdel2     randi     .01,. 95, .777
  kdel2     =  kdel2+.1
  addl2     delayr    .3
  afeed2    deltapi   kdel2
  afeed2    =  afeed2+gifeed*aright
            delayw    aright
  aglobin   =  (afeed1+afeed2)*.05
  atap1     comb      aglobin, 3.3, gilp1
  atap2     comb      aglobin, 3.3, gilp2
  atap3     comb      aglobin, 3.3, gilp3
  aglobrev  alpass    atap1+atap2+atap3, 2.6, .085
  aglobrev  tone      aglobrev, giroll
  kdel3     randi     .003, 1,. 888
  kdel3     =  kdel3+ .05
  addl3     delayr    .2
  agr1      deltapi   kdel3
            delayw    aglobrev
  kdel4     randi     .003, 1, .999
  kdel4     =  kdel4+ .05
  addl4     delayr    .2
  agr2      deltapi   kdel4
            delayw    aglobrev
  arevl     =  agr1+afeed1
  arevr     =  agr2+afeed2
            outs      arevl, arevr
  gadrysig  =  0
endin

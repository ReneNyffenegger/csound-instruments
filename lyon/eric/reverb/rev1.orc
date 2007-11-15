  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2
  gifeed    =  .5
  gilp1     =  1/10
  gilp2     =  1/23
  gilp3     =  1/41
  giroll    =  3000
;i1 0 dur file skip gain %orig inputdur atk
instr 1
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
  kclean    linseg    0,iatk,igain,idur,igain,idk,0,isust,0
  kout      linseg    1,ioutsust,1,idecay,0
  ain1,ain2 soundin   ifile,iskip
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
endin

instr 2
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
  aoutl     =  (ain1*iorig)+(arevl*irev)
  aoutr     =  (ain2*iorig)+(arevr*irev)
            outs      aoutl*kout,aoutr*kout
endin


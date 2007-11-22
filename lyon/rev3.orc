  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1
  gifeed    =  .5
  gilp1     =  1/30
  gilp2     =  1/23
  gilp3     =  1/41
  giroll    =  2500
instr          1
;tighter reverb
;i1 0 dur file skip gain iorig
  iorig     =  p7
  irev      =  (1.0-iorig)

  ifile     =  p4
  iskip     =  p5
  igain     =  p6
     ;FOR MONO INPUT 
  asigin    soundin   ifile,iskip
  asigin    =  asigin * igain
  ajunk     alpass    asigin,.7,.044
  aleft     alpass    ajunk,.3,.037

  kdel1     randi     .01,1,.666
  kdel1     =  kdel1    + .02
  addl1     delayr    .3
  afeed1    deltapi   kdel1
  afeed1    =  afeed1  + gifeed*aleft
            delayw    aleft

;GLOBAL REVERB

  aglobin   =  (afeed1)*.2
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


  arevl     =  agr1+afeed1
  aoutl     =  (asigin*iorig)+(arevl*irev)
            out       aoutl
endin

instr          100
endin

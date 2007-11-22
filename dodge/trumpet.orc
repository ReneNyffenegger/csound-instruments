  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1       
  irandev   =  .007
  ifreqrand =  125
  ivibatt   =  .6
  ivibdec   =  .2
  ivibwth   =  .007
  ivibrate  =  7
  iportdev  =  .03
  iportatt  =  .06
  iportdec  =  .01
  iampfac   =  .833
  ifund     =  cpspch(p4)
  iafrmfac  =  1-iampfac
  imax      =  2.66
  iratio    =  1.8/imax
  ifreqfrm  =  int(1500/ifund+.5)*ifund
  ifreqmod  =  ifund
  ifundatt  =  .03
  ifunddec  =  .15
  ifrmatt   =  .03
  ifrmdec   =  .3
  imodatt   =  .03
  imoddec   =  .01

  kphs      linen     ivibwth, ivibatt, p3, ivibdec
  kvfac     tablei    kphs, 4, 1
  kvibgate  =  kvfac*ivibwth 
  kport     envlpx    iportdev, iportatt, p3, iportdec, 5, 1, .01
  krand     randi     irandev, ifreqrand, -1
  kosc      oscil     kvibgate, ivibrate, 1
  kvib      =  (krand+1)*(kosc+1)*(kport+1)
       
  kgatemod  envlpx    imax*ifreqmod, imodatt, p3, imoddec, 3, 1.2, .01, .2
  kgatefd   envlpx    iampfac, ifundatt, p3, ifunddec, 2, 1, .01
  kgatefrm  envlpx    iafrmfac, ifrmatt, p3, ifrmdec, 2, 1, .01
  amod      oscili    kgatemod, ifreqmod*kvib, 1
  afund     oscili    kgatefd, ifund*kvib+amod, 1
  afrm      oscili    kgatefrm, ifreqfrm*kvib+amod*iratio, 1
            out       (afund+afrm)*p5
endin


instr          1          
  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc/2, 0, .2, .01
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
  iafrmfac  =  1-iampfac
  imax      =  2.66
  iratio    =  1.8/imax
  ifundatt  =  .03
  ifunddec  =  .15
  ifrmatt   =  .03
  ifrmdec   =  .3
  imodatt   =  .03
  imoddec   =  .01

  kphs      linen     ivibwth, ivibatt, 1, ivibdec
  kvfac     tablei    kphs, 4, 1
  kvibgate  =  kvfac*ivibwth 
  kport     envlpx    iportdev, iportatt, 1, iportdec, 5, 1, .01
  krand     randi     irandev, ifreqrand, -1
  kosc      oscil     kvibgate, ivibrate, 1
  kvib      =  (krand+1)*(kosc+1)*(kport+1)
       
  kgatemod  envlpx    imax*knote, imodatt, 1, imoddec, 3, 1.2, .01, .2
  kgatefd   envlpx    iampfac, ifundatt, 1, ifunddec, 2, 1, .01
  kgatefrm  envlpx    iafrmfac, ifrmatt, 1, ifrmdec, 2, 1, .01
  amod      oscili    kgatemod, knote*kvib, 1
  afund     oscili    kgatefd, knote*kvib+amod, 1
  afrm      oscili    kgatefrm, (int(1500/knote+.5)*knote)*kvib+amod*iratio, 1
            out       ((afund+afrm)*15000)*kgate
endin

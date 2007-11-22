;------------------------------------------------------------------------------
;    CANCION DE CUNA (LULLABY)
;------------------------------------------------------------------------------
;    DEDICATED TO MONICA BRAND
;    THIS VERSION IN CSOUND DEDICATED TO RICHARD BOULANGER
;------------------------------------------------------------------------------
;    FLAVIO GAETE
;    MAY 13TH 1999
;    CARACAS, VENEZUELA
;------------------------------------------------------------------------------

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

  gaaml     init      0
  gafml     init      0
  gafol     init      0
  gasil     init      0
     
  gaamr     init      0
  gafmr     init      0
  gafor     init      0
  gasir     init      0

;am
instr 1
  ilev1     =  ampdb(p4)
  inote     =  p5
  idec      =  p6
  ilev2     =  ilev1*p7
  irel1     =  p8

  ifrq      table     inote, 99 
  ifrq      =  cpspch(ifrq)

  iamf      =  ifrq*p9
  ipan      =  p10
  iwet      =  p11

  iatt      =  0.01
  icero     =  0.000000001
  icasi     =  ilev1*.0001
  irel2     =  p3-(iatt+idec+irel1)

  kamp      expseg    icero, iatt, ilev1, idec, ilev2, irel1, icasi, irel2, icero

  aam       oscil     kamp, iamf, 1
  aout      oscil     aam, ifrq, 1

  aaml      =  aout*(1-ipan)
  aamr      =  aout*ipan
            outs      aaml, aamr
          
  gaaml     =  (gaaml+aaml)*iwet
  gaamr     =  (gaamr+aamr)*iwet
endin
          
          
;fm
instr 2
  ilev1     =  ampdb(p4)
  inote     =  p5
  idec      =  p6
  ilev2     =  ilev1*p7
  irel1     =  p8

  ifrq      table     inote, 99 
  ifrq      =  cpspch(ifrq)

  ifm       =  ifrq*p9
  iidx1     =  p10
  iidx2     =  p11
  iidx3     =  p12
  iidx4     =  p13
  iidx5     =  p14
  ipan      =  p15
  iwet      =  p16

  iatt      =  0.01
  icero     =  0.000000001
  icasi     =  ilev1*.0001
  irel2     =  p3-(iatt+idec+irel1)

  kamp      expseg    icero, iatt, ilev1, idec, ilev2, irel1, icasi, irel2, icero
  kidx      linseg    iidx1, iatt, iidx2, idec, iidx3, irel1, iidx4, irel2, iidx5

  afrq      oscil     kidx, ifm, 1
  aout      oscil     kamp, ifrq*afrq, 1

  afml      =  aout*(1-ipan)
  afmr      =  aout*ipan
            outs      afml, afmr
          
  gafml     =  (gafml+afml)*iwet
  gafmr     =  (gafmr+afmr)*iwet
endin


;fof
instr 3
  ilev1     =  ampdb(p4)
  inote     =  p5

  idec      =  p6
  ilev2     =  ilev1*p7
  irel1     =  p8

  ifrq      table     inote, 99 
  ifrq      =  cpspch(ifrq)

  ifor1     =  ifrq*p9
  ifor2     =  ifrq*p10
  ifor3     =  ifrq*p11
  ifor4     =  ifrq*p12
  ifor5     =  ifrq*p13
  ipan      =  p14
  iwet      =  p15

  iatt      =  0.01
  icero     =  0.000000001
  icasi     =  ilev1*.0001
  irel2     =  p3-(iatt+idec+irel1)

  idur      =  .02
  iolaps    =  (ifrq*idur)+1

  kamp      expseg    icero, iatt, ilev1, idec, ilev2, irel1, icasi, irel2, icero
  aform     linseg    ifor1, iatt, ifor2, idec, ifor3, irel1, ifor4, irel2, ifor5

;                        xamp xfund  xform  koct kband krise kdur  kdec  iolaps  ifna--b 
  aout      fof       kamp, ifrq, aform, 1,    1,     .003, idur, .007, iolaps, 1, 2, p3

  afol      =  aout*(1-ipan)
  afor      =  aout*ipan
            outs      afol, afor
          
  gafol     =  (gafol+afol)*iwet
  gafor     =  (gafor+afor)*iwet
endin

          
;simple
instr 4
  ilev1     =  ampdb(p4)
  inote     =  p5
  idec      =  p6
  ilev2     =  ilev1*p7
  irel1     =  p8
  ichr      =  p9
  icf1      =  p10
  icf2      =  p11
  ifun      =  p12
  ipan      =  p13
  iwet      =  p14

  iatt      =  0.01
  icero     =  0.000000001
  icasi     =  ilev1*.0001
  irel2     =  p3-(iatt+idec+irel1)

  kamp      expseg    icero, iatt, ilev1, idec, ilev2, irel1, icasi, irel2, icero
  kcf       line      icf1, p3, icf2

  ifrq      table     inote, 99 
  ifrq      =  cpspch(ifrq)   
          
  a1        oscil     kamp, ifrq+ichr, ifun
  a2        oscil     kamp, ifrq-ichr, ifun

  a3        =  (a1+a2)*.5

  aout      butterlp  a3, kcf

  asil      =  aout*(1-ipan)
  asir      =  aout*ipan
            outs      asil, asir
          
  gasil     =  (gasil+asil)*iwet
  gasir     =  (gasir+asir)*iwet
endin
          
;reverb
instr 99
  iwet      =  1.5
  ipre      =  .0625
  irvbt     =  10

  gaaml     =  gaaml*.5
  gafml     =  gafml*.5
  gafol     =  gafol*.5
  gasil     =  gasil*.5
   
  adryl     =  (gaaml+gafml+gafol+gasil)/4
  adryl     alpass    adryl, .75, ipre

  iloop1l   =  .0521                              ; comb lengths
  iloop2l   =  .0599
  iloop3l   =  .0619
  iloop4l   =  .0677
  iloop5l   =  .0727
  iloop6l   =  .0797
                
  acomb1l   comb      adryl, irvbt, iloop1l
  acomb2l   comb      adryl, irvbt, iloop2l
  acomb3l   comb      adryl, irvbt, iloop3l
  acomb4l   comb      adryl, irvbt, iloop4l
  acomb5l   comb      adryl, irvbt, iloop5l
  acomb6l   comb      adryl, irvbt, iloop6l
   
  awetl     =  (acomb1l+acomb2l+acomb3l+acomb4l+acomb5l+acomb6l)

  ihz1l     =  1/55
  ihz2l     =  1/144
  ihz3l     =  1/377
  ihz4l     =  1/987

  alp1l     alpass    awetl,.43,ihz1l
  alp2l     alpass    alp1l,.33,ihz2l
  alp3l     alpass    alp2l,.21,ihz3l
  alp4l     alpass    alp3l,.12,ihz4l
  aenvl     linen     alp4l,.003,p3,.1
          
  aoutl     =  adryl + aenvl*iwet
   
  a1l       butterbp  aoutl,    70,   200
  a2l       butterbp  aoutl,   400,   480
  a3l       butterbp  aoutl,  1600,  1920
  a4l       butterbp  aoutl,  5120,  5120
  a5l       butterbp  aoutl, 14080, 11000
     
  aleft     =  (a1l+a2l+a3l+a4l+a5l)
  aleft     butterlp  aleft, 500

;----------------------------------------

  gaamr     =  gaamr*.5
  gafmr     =  gafmr*.5
  gafor     =  gafor*.5
  gasir     =  gasir*.5
   
  adryr     =  (gaamr+gafmr+gafor+gasir)/4

  adryr     alpass    adryr, .75, ipre

  iloop1r   =  .0521                              ; comb lengths
  iloop2r   =  .0599
  iloop3r   =  .0619
  iloop4r   =  .0677
  iloop5r   =  .0727
  iloop6r   =  .0797
                
  acomb1r   comb      adryr, irvbt, iloop1r
  acomb2r   comb      adryr, irvbt, iloop2r
  acomb3r   comb      adryr, irvbt, iloop3r
  acomb4r   comb      adryr, irvbt, iloop4r
  acomb5r   comb      adryr, irvbt, iloop5r
  acomb6r   comb      adryr, irvbt, iloop6r
     
  awetr     =  (acomb1r+acomb2r+acomb3r+acomb4r+acomb5r+acomb6r)

  ihz1r     =  1/55
  ihz2r     =  1/144
  ihz3r     =  1/377
  ihz4r     =  1/987

  alp1r     alpass    awetr,.43,ihz1r
  alp2r     alpass    alp1r,.33,ihz2r
  alp3r     alpass    alp2r,.21,ihz3r
  alp4r     alpass    alp3r,.12,ihz4r
  aenvr     linen     alp4r,.003,p3,.1
         
  aoutr     =  adryr + aenvr*iwet
   
  a1r       butterbp  aoutr,    70,   200
  a2r       butterbp  aoutr,   400,   480
  a3r       butterbp  aoutr,  1600,  1920
  a4r       butterbp  aoutr,  5120,  5120
  a5r       butterbp  aoutr, 14080, 11000

  aright    =  (a1r+a2r+a3r+a4r+a5r)
  aright    butterlp  aright, 500
     
            outs      aleft, aright
          
  gaaml     =  0
  gafml     =  0
  gafol     =  0
  gasil     =  0
     
  gaamr     =  0
  gafmr     =  0
  gafor     =  0
  gasir     =  0

endin

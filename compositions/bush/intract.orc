; =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
; =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
;
;                     INTRACT.ORC FOR CSOUND
;
;                         NOEL CLARK BUSH
;
;                   OCTOBER 1995 - DECEMBER 1996
;
; =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
; =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=

;   +  +  VIEW IN MONO-SPACED FONT, 8-CHARACTER TABS, 150 COL. WIDE (90 MINIMUM)  +  +


; =====================================================================================
;  ORCHESTRA HEADER
; =====================================================================================

; -------------------------------------------------------------------------------------
; CSOUND-REQUIRED VALUES

  sr        =  44100                              ; SAMPLE RATE (44.1 KHZ)
  kr        =  441                                ; CONTROL RATE (441 HZ)
  ksmps     =  100                                ; NUMBER OF SAMPLES IN A CONTROL PERIOD
  nchnls    =  2                                  ; DUAL CHANNEL SOUND

; -------------------------------------------------------------------------------------
; GLOBAL CONSTANTS MANUALLY ENTERED

  gihead    =  0.10                               ; DISTANCE (M) BETWEEN EARS
  gi1minbw  =  2                                  ; MINIMAL FILTER BANDWIDTH FOR I1
  giroomlen =  200                                ; LENGTH (M) OF ROOM
  giroomwid =  133                                ; WIDTH (M) OF ROOM
  giscalef  =  1                                  ; DETERMINED BY TRIAL AND ERROR

; -------------------------------------------------------------------------------------
; GLOBAL CONSTANTS CALCULATED

  gihfhead  =  gihead * 0.5                       ; (TO AVOID REPEATING THIS CALCULATION)
  gihfrl    =  giroomlen * 0.5                    ; (TO AVOID REPEATING THIS CALCULATION)
  gihfrlsq  =  gihfrl * gihfrl                    ; (TO AVOID REPEATING THIS CALCULATION)
  gihfrw    =  giroomwid * 0.5                    ; (TO AVOID REPEATING THIS CALCULATION)
  gihfrwsq  =  gihfrw * gihfrw                    ; (TO AVOID REPEATING THIS CALCULATION)

  gai1lrev  init      0                           ; GLOBAL REVERB FOR I1 LEFT CHANNEL
  gai1rrev  init      0                           ; GLOBAL REVERB FOR I1 RIGHT CHANNEL
  gai2lrev  init      0                           ; GLOBAL REVERB FOR I2 LEFT CHANNEL
  gai2rrev  init      0                           ; GLOBAL REVERB FOR I2 RIGHT CHANNEL
  gai4lrev  init      0                           ; GLOBAL REVERB FOR I4 LEFT CHANNEL
  gai4rrev  init      0                           ; GLOBAL REVERB FOR I4 RIGHT CHANNEL

  gibufkcyc =  4 / kr                             ; A BUFFER OF SEVERAL K-CYCLES
  giihfsr   =  int(sr * 0.5)


; I1 =====================================================================================
; I1  INSTRUMENT 1
; I1 =====================================================================================

instr 1

; I1 -------------------------------------------------------------------------------------
; I1 P-FIELDS READ

; I1 --- COMMON TO BOTH COMPONENTS

  idur      =  p3

; I1 --- COMPONENT 1

  ifreq1    =  cpsoct(p4)
  ipc1      =  p5
  iwob1     =  p6
  ipdf1     =  p7
  iwid1     =  p8
  iatk1     =  p9
  idec1     =  p10
  ipdb1     =  p11
  ipamp1    =  ampdb(ipdb1)
  iiloc1    =  p12
  ieloc1    =  p13

; I1 --- COMPONENT 2

  ifreq2    =  cpsoct(p14)
  ipc2      =  p15
  iwob2     =  p16
  ipdf2     =  p17
  iwid2     =  p18
  iatk2     =  p19
  idec2     =  p20
  ipdb2     =  p21
  ipamp2    =  ampdb(ipdb2)
  iiloc2    =  p22
  ieloc2    =  p23
  ireach    =  p24

; I1 -------------------------------------------------------------------------------------
; I1 WHICH ATTACK FUNCTION?        

  ifn1      =  (ireach > 0 ? 2 : 3)
  ifn2      =  (ireach > 0 ? 3 : 2)

; I1 -------------------------------------------------------------------------------------
; I1 AMP ENVELOPES

  aenv1     envlpx    ipamp1, iatk1, idur, idec1, ifn1, 0.5, 0.01, 0
  aenv2     envlpx    ipamp2, iatk2, idur, idec2, ifn2, 0.5, 0.01, 0    

; I1 -------------------------------------------------------------------------------------
; I1 RAW NOISE 

  awhite1   rand      ipamp1
  awhite2   rand      ipamp2

; I1 -------------------------------------------------------------------------------------
; I1 VARYING FILTER BANDWIDTHS CALCULATED

  kiwid1    envlpx    iwid1, iatk1, idur, idec1, ifn1, 0.5, 0.01, 0
  kiwid2    envlpx    iwid2, iatk2, idur, idec2, ifn2, 0.5, 0.01, 0
  kwid1     =  (iwid1 + gi1minbw) - kiwid1
  kwid2     =  (iwid2 + gi1minbw) - kiwid2

; I1 -------------------------------------------------------------------------------------
; I1 RANDOM PITCH FLUCTUATIONS

  kwob1     randi     iwob1*ifreq1,kr
  kwob2     randi     iwob2*ifreq2,kr

; I1 -------------------------------------------------------------------------------------
; I1 BAND-PASS FILTERING OF NOISE  

  afil1     reson     awhite1, ifreq1 + kwob1, kwid1, 1
  afil2     reson     awhite2, ifreq2 + kwob2, kwid2, 1

; I1 -------------------------------------------------------------------------------------
; I1 FILTERED NOISE AMP ENVELOPED

  anv1      =  afil1 * aenv1
  anv2      =  afil2 * aenv2
     
; I1 -------------------------------------------------------------------------------------
; I1 AMP FACTOR PATHS FOR DIRECT SOUND

  k1d0f     linseg    (1 - ipdf1) * iiloc1, idur, (1 - ipdf1) * ieloc1
  k2d0f     linseg    (1 - ipdf2) * iiloc2, idur, (1 - ipdf2) * ieloc2

; I1 -------------------------------------------------------------------------------------
; I1 AMP FACTOR PATHS FOR REVERBED SOUND

  k1r0f     linseg    (1 - sqrt(ipdf1)) * iiloc1, idur, (1 - sqrt(ipdf1)) * ieloc1
  k2r0f     linseg    (1 - sqrt(ipdf2)) * iiloc2, idur, (1 - sqrt(ipdf2)) * ieloc2

; I1 -------------------------------------------------------------------------------------
; I1 no-reverb signal    

  aldir     =  (anv1 * k1d0f) * 0.5 + (anv2 * k2d0f) * 0.5
  ardir     =  (anv1 * (1 - k1d0f)) * 0.5 + (anv2 * (1 - k2d0f)) * 0.5

; I1 -------------------------------------------------------------------------------------
; I1 REVERB-INPUT SIGNAL

  gai1lrev  =  gai1lrev + (anv1 * k1r0f) * 0.5 + (anv2 * k2r0f) * 0.5
  gai1rrev  =  gai1rrev + (anv1 * (1 - k1r0f)) * 0.5 + (anv2 * (1 - k2r0f)) * 0.5
     
; I1 -------------------------------------------------------------------------------------
; I1 SOUND OUT
            outs      aldir, ardir

; I1 -------------------------------------------------------------------------------------
; I1 END

endin


; I2 =====================================================================================
; I2  INSTRUMENT 2
; I2 =====================================================================================

instr 2

; I2 -------------------------------------------------------------------------------------
; I2 P-FIELDS READ

; I2 --- COMMON TO BOTH COMPONENTS

  idur      =  p3

; I2 --- COMPONENT 1

  ifreq1p0  =  p4
  ifund1    =  ifreq1p0
  iwid1     =  p5
  ipdf1     =  p6
  iatk1     =  p7
  idec1     =  p8
  ipdb1     =  p9
  ipamp1    =  ampdb(ipdb1)
  ids1      =  p10
  ids1sq    =  ids1 * ids1
  iazi1     =  p11

; I2 --- COMPONENT 2

  ifreq2p0  =  p12
  ifund2    =  ifreq2p0
  iwid2     =  p13
  ipdf2     =  p14
  iatk2     =  p15
  idec2     =  p16
  ipdb2     =  p17
  ipamp2    =  ampdb(ipdb2)
  ids2      =  p18
  ids2sq    =  ids2 * ids2
  iazi2     =  p19

; I2 -------------------------------------------------------------------------------------
; I2 LISTENER-TO-SOUND-SOURCE DISTANCES

  isb1      =  cos (1.5708 - iazi1) * ids1
  isb1sq    =  isb1 * isb1
  ibh1      =  sqrt (ids1sq - isb1sq)
  ibl1      =  ibh1 + gihfhead
  ibr1      =  ibh1 - gihfhead
  ibl1sq    =  ibl1 * ibl1
  ibr1sq    =  ibr1 * ibr1
  il1ds     =  sqrt (isb1sq + ibl1sq)
  ir1ds     =  sqrt (isb1sq + ibr1sq)
  isb2      =  cos       (1.5708 - iazi2) * ids2
  isb2sq    =  isb2 * isb2
  ibh2      =  sqrt(ids2sq - isb2sq)
  ibl2      =  ibh2 + gihfhead
  ibr2      =  ibh2 - gihfhead
  ibl2sq    =  ibl2 * ibl2
  ibr2sq    =  ibr2 * ibr2
  il2ds     =  sqrt (isb2sq + ibl2sq)
  ir2ds     =  sqrt (isb2sq + ibr2sq)

; I2 -------------------------------------------------------------------------------------
; I2 LISTENER-TO-FIRST-REFLECTED-SOUND DISTANCES

; I2 --- "NORTH/SOUTH"

  insxl1ds  =  sqrt (ibl1sq + gihfrlsq)
  insxr1ds  =  sqrt (ibr1sq + gihfrlsq)
  insxl2ds  =  sqrt (ibl2sq + gihfrlsq)
  insxr2ds  =  sqrt (ibr2sq + gihfrlsq)

; I2 --- "EAST/WEST"

  iewtvdsl  =  gihfrw + gihfhead
  iewtvdsr  =  gihfrw - gihfhead
  iewtvdslsq   =      iewtvdsl * iewtvdsl
  iewtvdsrsq   =      iewtvdsr * iewtvdsr
  iewxl1ds  =  sqrt (isb1sq + iewtvdslsq)
  iewxr1ds  =  sqrt (isb1sq + iewtvdsrsq)
  iewxl2ds  =  sqrt (isb2sq + iewtvdslsq)
  iewxr2ds  =  sqrt (isb2sq + iewtvdsrsq)
     
; I2 -------------------------------------------------------------------------------------
; I2 SOUND-SOURCE-TO-WALL DISTANCES

  inwlds1   =  gihfrl - isb1
  iewlds1   =  gihfrw - ibh1
  iswlds1   =  gihfrl + isb1
  iwwlds1   =  gihfrw + ibh1
  inwlds2   =  gihfrl - isb2
  iewlds2   =  gihfrw - ibh2
  iswlds2   =  gihfrl + isb2
  iwwlds2   =  gihfrw + ibh2

; I2 -------------------------------------------------------------------------------------
; I2 TOTAL FIRST REFLECTION PATHS

; I2 --- COMPONENT 1

; I2 --- --- LEFT CHANNEL

  infrpl1   =  inwlds1 + insxl1ds
  iefrpl1   =  iewlds1 + iewxl1ds
  isfrpl1   =  iswlds1 + insxl1ds
  iwfrpl1   =  iewlds1   + iewxl1ds

; I2 --- --- RIGHT CHANNEL

  infrpr1   =  inwlds1 + insxr1ds
  iefrpr1   =  iewlds1 + iewxr1ds
  isfrpr1   =  iswlds1 + insxr1ds
  iwfrpr1   =  iewlds1   + iewxr1ds

; I2 --- COMPONENT 2

; I2 --- --- LEFT CHANNEL

  infrpl2   =  inwlds1 + insxl2ds
  iefrpl2   =  iewlds1 + iewxl2ds
  isfrpl2   =  iswlds1 + insxl2ds
  iwfrpl2   =  iewlds1   + iewxl2ds

; I2 --- --- RIGHT CHANNEL

  infrpr2   =  inwlds1 + insxr2ds
  iefrpr2   =  iewlds1 + iewxr2ds
  isfrpr2   =  iswlds1 + insxr2ds
  iwfrpr2   =  iewlds1   + iewxr2ds


; I2 -------------------------------------------------------------------------------------
; I2 DELAY TIMES FOR DIRECT SOUND

  il1dyd    =  il1ds * 0.00289855
  il1dyd    =  (il1dyd > gibufkcyc ? il1dyd : gibufkcyc)
  ir1dyd    =  ir1ds * 0.00289855
  ir1dyd    =  (ir1dyd > gibufkcyc ? ir1dyd : gibufkcyc)
  il2dyd    =  il2ds * 0.00289855
  il2dyd    =  (il2dyd > gibufkcyc ? il2dyd : gibufkcyc)
  ir2dyd    =  ir2ds * 0.00289855
  ir2dyd    =  (ir2dyd > gibufkcyc ? ir2dyd : gibufkcyc)

; I2 -------------------------------------------------------------------------------------
; I2 DELAY TIMES FOR REFLECTED SOUND

  ildt      =  0

; I2 --- COMPONENT 1

; I2 --- --- LEFT CHANNEL

  inxl1dy   =  infrpl1 * 0.00289855
  inxl1dy   =  (inxl1dy > gibufkcyc ? inxl1dy : gibufkcyc)
  ildt      =  (inxl1dy > ildt ? inxl1dy : ildt)
  iexl1dy   =  iefrpl1 * 0.00289855
  iexl1dy   =  (iexl1dy > gibufkcyc ? iexl1dy : gibufkcyc)
  ildt      =  (iexl1dy > ildt ? iexl1dy : ildt)
  isxl1dy   =  infrpl1 * 0.00289855
  isxl1dy   =  (isxl1dy > gibufkcyc ? isxl1dy : gibufkcyc)
  ildt      =  (isxl1dy > ildt ? isxl1dy : ildt)
  iwxl1dy   =  iefrpl1 * 0.00289855
  iwxl1dy   =  (iwxl1dy > gibufkcyc ? iwxl1dy : gibufkcyc)
  ildt      =  (iwxl1dy > ildt ? iwxl1dy : ildt)

; I2 --- --- RIGHT CHANNEL

  inxr1dy   =  infrpr1 * 0.00289855
  inxr1dy   =  (inxr1dy > gibufkcyc ? inxr1dy : gibufkcyc)
  ildt      =  (inxr1dy > ildt ? inxr1dy : ildt)
  iexr1dy   =  iefrpr1 * 0.00289855
  iexr1dy   =  (iexr1dy > gibufkcyc ? iexr1dy : gibufkcyc)
  ildt      =  (iexr1dy > ildt ? iexr1dy : ildt)
  isxr1dy   =  infrpr1 * 0.00289855
  isxr1dy   =  (isxr1dy > gibufkcyc ? isxr1dy : gibufkcyc)
  ildt      =  (isxr1dy > ildt ? isxr1dy : ildt)
  iwxr1dy   =  iefrpr1 * 0.00289855
  iwxr1dy   =  (iwxr1dy > gibufkcyc ? iwxr1dy : gibufkcyc)
  ildt      =  (iwxr1dy > ildt ? iwxr1dy : ildt)

; I2 --- COMPONENT 2

; I2 --- --- LEFT CHANNEL

  inxl2dy   =  infrpl2 * 0.00289855
  inxl2dy   =  (inxl2dy > gibufkcyc ? inxl2dy : gibufkcyc)
  ildt      =  (inxl2dy > ildt ? inxl2dy : ildt)
  iexl2dy   =  iefrpl1 * 0.00289855
  iexl2dy   =  (iexl2dy > gibufkcyc ? iexl2dy : gibufkcyc)
  ildt      =  (iexl2dy > ildt ? iexl2dy : ildt)
  isxl2dy   =  infrpl2 * 0.00289855
  isxl2dy   =  (isxl2dy > gibufkcyc ? isxl2dy : gibufkcyc)
  ildt      =  (isxl2dy > ildt ? isxl2dy : ildt)
  iwxl2dy   =  iefrpl1 * 0.00289855
  iwxl2dy   =  (iwxl2dy > gibufkcyc ? iwxl2dy : gibufkcyc)
  ildt      =  (iwxl2dy > ildt ? iwxl2dy : ildt)

; I2 --- --- RIGHT CHANNEL

  inxr2dy   =  infrpr2 * 0.00289855
  inxr2dy   =  (inxr2dy > gibufkcyc ? inxr2dy : gibufkcyc)
  ildt      =  (inxr2dy > ildt ? inxr2dy : ildt)
  iexr2dy   =  iefrpr1 * 0.00289855
  iexr2dy   =  (iexr2dy > gibufkcyc ? iexr2dy : gibufkcyc)
  ildt      =  (iexr2dy > ildt ? iexr2dy : ildt)
  isxr2dy   =  infrpr2 * 0.00289855
  isxr2dy   =  (isxr2dy > gibufkcyc ? isxr2dy : gibufkcyc)
  ildt      =  (isxr2dy > ildt ? isxr2dy : ildt)
  iwxr2dy   =  iefrpr1 * 0.00289855
  iwxr2dy   =  (iwxr2dy > gibufkcyc ? iwxr2dy : gibufkcyc)
  ildt      =  (iwxr2dy > ildt ? iwxr2dy : ildt)

; I2 -------------------------------------------------------------------------------------
; I2 ACTUAL DURATION (P3) LENGTHENED BY LONGEST DELAY TIME            

  p3        =  idur + ildt + gibufkcyc

; I2 -------------------------------------------------------------------------------------
; I2 PARTIAL SERIES CALCULATIONS

  ifreq1p1  =  ifreq1p0 * (1 + ipdf1)
  ifreq1p2  =  ifreq1p0 * (1 + (2 * ipdf1))
  ifreq1p3  =  ifreq1p0 * (1 + (3 * ipdf1))
  ifreq1p4  =  ifreq1p0 * (1 + (4 * ipdf1))
  ifreq1p5  =  ifreq1p0 * (1 + (5 * ipdf1))
  ifreq2p1  =  ifreq2p0 * (1 + ipdf2)
  ifreq2p2  =  ifreq2p0 * (1 + (2 * ipdf2))
  ifreq2p3  =  ifreq2p0 * (1 + (3 * ipdf2))
  ifreq2p4  =  ifreq2p0 * (1 + (4 * ipdf2))
  ifreq2p5  =  ifreq2p0 * (1 + (5 * ipdf2))

; I2 -------------------------------------------------------------------------------------
; I2 AMP ENVELOPES FOR BUZZ SOURCES               

  aenv1     envlpx    ipamp1, iatk1, idur, idec1, 2, .5, .01, 0
  aenv2     envlpx    ipamp2, iatk2, idur, idec2, 2, .5, .01, 0    

; I2 -------------------------------------------------------------------------------------
; I2 RANDOM PITCH FLUCTUATIONS

  kwarb1    randi     .0053*ifund1,10
  kwarb2    randi     .0052*ifund2,10

; I2 -------------------------------------------------------------------------------------
; I2 NUMBER OF HARMONICS IN BUZZ SOURCES

  knh1      =  giihfsr / ifund1
  knh2      =  giihfsr / ifund2
  knh1      =  (knh1 < 1 ? 1 : knh1)    
  knh2      =  (knh2 < 1 ? 1 : knh2)    

; I2 -------------------------------------------------------------------------------------
; I2 BUZZ SOURCES

  a1sou     buzz      aenv1, ifund1 + kwarb1, knh1, 4
  a2sou     buzz      aenv2, ifund1 + kwarb2, knh2, 4
     
; I2 -------------------------------------------------------------------------------------
; I2 FILTER BANKS (IN PARALLEL)

  a1p0      reson     a1sou, ifreq1p0, iwid1, 1
  a1p1      reson     a1sou, ifreq1p1, iwid1, 1
  a1p2      reson     a1sou, ifreq1p2, iwid1, 1
  a1p3      reson     a1sou, ifreq1p3, iwid1, 1
  a1p4      reson     a1sou, ifreq1p4, iwid1, 1
  a1p5      reson     a1sou, ifreq1p5, iwid1, 1
  a2p0      reson     a2sou, ifreq2p0, iwid2, 1
  a2p1      reson     a2sou, ifreq2p1, iwid2, 1
  a2p2      reson     a2sou, ifreq2p2, iwid2, 1
  a2p3      reson     a2sou, ifreq2p3, iwid2, 1
  a2p4      reson     a2sou, ifreq2p4, iwid2, 1
  a2p5      reson     a2sou, ifreq2p5, iwid2, 1

; I2 -------------------------------------------------------------------------------------
; I2 FILTER OUTPUTS SUMMED    AND BALANCED AGAINST BUZZ SOURCE

  i01t1     =  ifreq1p0 / ifreq1p1
  i12t1     =  ifreq1p1 / ifreq1p2
  i23t1     =  ifreq1p2 / ifreq1p3
  i34t1     =  ifreq1p3 / ifreq1p4
  i45t1     =  ifreq1p4 / ifreq1p5
  i01t2     =  ifreq2p0 / ifreq2p1
  i12t2     =  ifreq2p1 / ifreq2p2
  i23t2     =  ifreq2p2 / ifreq2p3
  i34t2     =  ifreq2p3 / ifreq2p4
  i45t2     =  ifreq2p4 / ifreq2p5
  a1sum     =  a1p0 + (i01t1 * a1p1) + (i12t1 * a1p2) + (i23t1 * a1p3) + (i34t1 * a1p4) + (i45t1 * a1p5)
  a2sum     =  a2p0 + (i01t2 * a2p1) + (i12t2 * a2p2) + (i23t2 * a2p3) + (i34t2 * a2p4) + (i45t2 * a2p5)
  a1bal     balance   a1sum, a1sou
  a2bal     balance   a2sum, a2sou

; I2 -------------------------------------------------------------------------------------
; I2 DELAY LINES (ITD)

; I2 --- COMPONENT ONE

; I2 --- --- LEFT CHANNEL

  al1d      delay     a1bal, il1dyd
  al1xn     delay     a1bal, inxl1dy
  al1xe     delay     a1bal, iexl1dy
  al1xs     delay     a1bal, isxl1dy
  al1xw     delay     a1bal, iwxl1dy

; I2 --- --- RIGHT CHANNEL

  ar1d      delay     a1bal, ir1dyd
  ar1xn     delay     a1bal, inxr1dy
  ar1xe     delay     a1bal, iexr1dy
  ar1xs     delay     a1bal, isxr1dy
  ar1xw     delay     a1bal, iwxr1dy

; I2 --- COMPONENT 2

; I2 --- --- LEFT CHANNEL

  al2d      delay     a2bal, il2dyd
  al2xn     delay     a2bal, inxl2dy
  al2xe     delay     a2bal, iexl2dy
  al2xs     delay     a2bal, isxl2dy
  al2xw     delay     a2bal, iwxl2dy

; I2 --- --- RIGHT CHANNEL

  ar2d      delay     a2bal, ir2dyd
  ar2xn     delay     a2bal, inxr2dy
  ar2xe     delay     a2bal, iexr2dy
  ar2xs     delay     a2bal, isxr2dy
  ar2xw     delay     a2bal, iwxr2dy

; I2 -------------------------------------------------------------------------------------
; I2 AMP FACTORS FOR NO-REVERB DIRECT SOUND

  il1dampf  =  1 + (1 / il1ds)
  ir1dampf  =  1 + (1 / ir1ds)
  il2dampf  =  1 + (1 / il2ds)
  ir2dampf  =  1 + (1 / ir2ds)

; I2 -------------------------------------------------------------------------------------
; I2 AMP FACTORS FOR NO-REVERB FIRST-REFLECTED SOUND

; I2 --- COMPONENT 1

; I2 --- --- LEFT CHANNEL

  il1xnampf =  1 + (1 / infrpl1)
  il1xeampf =  1 + (1 / iefrpl1)
  il1xsampf =  1 + (1 / isfrpl1)
  il1xwampf =  1 + (1 / iwfrpl1)

; I2 --- --- RIGHT CHANNEL

  ir1xnampf =  1 + (1 / infrpr1)
  ir1xeampf =  1 + (1 / iefrpr1)
  ir1xsampf =  1 + (1 / isfrpr1)
  ir1xwampf =  1 + (1 / iwfrpr1)

; I2 --- COMPONENT 2

; I2 --- --- LEFT CHANNEL

  il2xnampf =  1 + (1 / infrpl2)
  il2xeampf =  1 + (1 / iefrpl2)
  il2xsampf =  1 + (1 / isfrpl2)
  il2xwampf =  1 + (1 / iwfrpl2)

; I2 --- --- RIGHT CHANNEL

  ir2xnampf =  1 + (1 / infrpr2)
  ir2xeampf =  1 + (1 / iefrpr2)
  ir2xsampf =  1 + (1 / isfrpr2)
  ir2xwampf =  1 + (1 / iwfrpr2)

; I2 -------------------------------------------------------------------------------------
; I2 AMP FACTORS FOR REVERB-INPUT DIRECT SOUND

  il1revdampf  =      1 + (1 / (il1ds * il1ds))
  ir1revdampf  =      1 + (1 / (ir1ds * ir1ds))
  il2revdampf  =      1 + (1 / (il2ds * il2ds))
  ir2revdampf  =      1 + (1 / (ir2ds * ir2ds))

; I2 -------------------------------------------------------------------------------------
; I2 AMP FACTORS FOR REVERB-INPUT FIRST-REFLECTED SOUND

; I2 --- COMPONENT 1

; I2 --- --- LEFT CHANNEL

  il1revxnampf =      1 + (1 / (infrpl1 * infrpl1))
  il1revxeampf =      1 + (1 / (iefrpl1 * iefrpl1))
  il1revxsampf =      1 + (1 / (isfrpl1 * isfrpl1))
  il1revxwampf =      1 + (1 / (iwfrpl1 * iwfrpl1))

; I2 --- --- RIGHT CHANNEL

  ir1revxnampf =      1 + (1 / (infrpr1 * infrpr1))
  ir1revxeampf =      1 + (1 / (iefrpr1 * iefrpr1))
  ir1revxsampf =      1 + (1 / (isfrpr1 * isfrpr1))
  ir1revxwampf =      1 + (1 / (iwfrpr1 * iwfrpr1))

; I2 --- COMPONENT  2

; I2 --- --- LEFT CHANNEL

  il2revxnampf =      1 + (1 / (infrpl2 * infrpl2))
  il2revxeampf =      1 + (1 / (iefrpl2 * iefrpl2))
  il2revxsampf =      1 + (1 / (isfrpl2 * isfrpl2))
  il2revxwampf =      1 + (1 / (iwfrpl2 * iwfrpl2))

; I2 --- --- RIGHT CHANNEL

  ir2revxnampf =      1 + (1 / (infrpr2 * infrpr2))
  ir2revxeampf =      1 + (1 / (iefrpr2 * iefrpr2))
  ir2revxsampf =      1 + (1 / (isfrpr2 * isfrpr2))
  ir2revxwampf =      1 + (1 / (iwfrpr2 * iwfrpr2))

; I2 -------------------------------------------------------------------------------------
; I2 NO-REVERB SOUND     

; I2 --- DIRECT SOUND

  al1d      =  (al1d * il1dampf)
  ar1d      =  (ar1d * ir1dampf)
  al2d      =  (al2d * il2dampf)
  ar2d      =  (ar2d * ir2dampf)

; I2 --- FIRST REFLECTIONS

  al1x      =  (al1xn * il1xnampf) + (al1xe * il1xeampf) + (al1xs * il1xsampf) + (al1xw * il1xwampf)
  ar1x      =  (ar1xn * ir1xnampf) + (ar1xe * ir1xeampf) + (ar1xs * ir1xsampf) + (ar1xw * ir1xwampf)
  al2x      =  (al2xn * il2xnampf) + (al2xe * il2xeampf) + (al2xs * il2xsampf) + (al2xw * il2xwampf)
  ar2x      =  (ar2xn * ir2xnampf) + (ar2xe * ir2xeampf) + (ar2xs * ir2xsampf) + (ar2xw * ir2xwampf)

; I2 --- SUM

  alnorev   =  al1d + al2d + al1x + al2x
  arnorev   =  ar1d + ar2d + ar1x + ar2x

; I2 -------------------------------------------------------------------------------------
; I2 REVERB-INPUT SOUND  

; I2 --- DIRECT SOUND

  al1revd   =  (al1d * il1revdampf)
  ar1revd   =  (ar1d * ir1revdampf)
  al2revd   =  (al2d * il2revdampf)
  ar2revd   =  (ar2d * ir2revdampf)

; I2 --- FIRST REFLECTIONS

  al1revx   =  (al1xn * il1revxnampf) + (al1xe * il1revxeampf) + (al1xs * il1revxsampf) + (al1xw * il1revxwampf)
  ar1revx   =  (ar1xn * ir1revxnampf) + (ar1xe * ir1revxeampf) + (ar1xs * ir1revxsampf) + (ar1xw * ir1revxwampf)
  al2revx   =  (al2xn * il2revxnampf) + (al2xe * il2revxeampf) + (al2xs * il2revxsampf) + (al2xw * il2revxwampf)
  ar2revx   =  (ar2xn * ir2revxnampf) + (ar2xe * ir2revxeampf) + (ar2xs * ir2revxsampf) + (ar2xw * ir2revxwampf)

; I2 --- SUM

  alrev     =  al1revd + al2revd + al1revx + al2revx
  arrev     =  ar1revd + ar2revd + ar1revx + ar2revx
     
; I2 -------------------------------------------------------------------------------------
; I2 NO-REVERB SOUND SCALED AND OUT
            outs      giscalef * alnorev, giscalef * arnorev

; I2 -------------------------------------------------------------------------------------
; I2 REVERB-INPUT SOUND TO GLOBAL REVERB SIGNAL

  gai2lrev  =  gai2lrev + alrev
  gai2rrev  =  gai2rrev + arrev

; I2 -------------------------------------------------------------------------------------
; I2 END

endin


; I4 =====================================================================================
; I4  INSTRUMENT 4
; I4 =====================================================================================

instr 4

; I4 -------------------------------------------------------------------------------------
; I4 P-FIELDS READ

; I4 --- COMMON TO BOTH COMPONENTS

  idur      =  p3

; I4 --- COMPONENT 1

  ifreq1p0  =  cpsoct(p4)
  ipc1      =  p5
  iwobmt1   =  cpsoct(p4 * p6)
  iwid1     =  p7
  inpdf1    =  p8
  iatk1     =  p9
  idec1     =  p10
  ipdb1     =  p11
  ipamp1    =  ampdb(ipdb1)
  ids1      =  p12
  ids1sq    =  ids1 * ids1
  iazi1     =  p13

; I4 --- COMPONENT 2

  ifreq2p0  =  cpsoct(p14)
  ipc2      =  p15
  iwobmt2   =  cpsoct(p13 * p16)
  iwid2     =  p17
  inpdf2    =  p18
  iatk2     =  p19
  idec2     =  p20
  ipdb2     =  p21
  ipamp2    =  ampdb(ipdb2)
  ids2      =  p22
  ids2sq    =  ids2 * ids2
  iazi2     =  p23
          
; I4 -------------------------------------------------------------------------------------
; I4 LISTENER-TO-SOUND-SOURCE DISTANCES

  isb1      =  cos (1.5708 - iazi1) * ids1
  isb1sq    =  isb1 * isb1
  ibh1      =  sqrt (ids1sq - isb1sq)
  ibl1      =  ibh1 + gihfhead
  ibr1      =  ibh1 - gihfhead
  ibl1sq    =  ibl1 * ibl1
  ibr1sq    =  ibr1 * ibr1
  il1ds     =  sqrt (isb1sq + ibl1sq)
  ir1ds     =  sqrt (isb1sq + ibr1sq)
  isb2      =  cos (1.5708 - iazi2) * ids2
  isb2sq    =  isb2 * isb2
  ibh2      =  sqrt (ids2sq - isb2sq)
  ibl2      =  ibh2 + gihfhead
  ibr2      =  ibh2 - gihfhead
  ibl2sq    =  ibl2 * ibl2
  ibr2sq    =  ibr2 * ibr2
  il2ds     =  sqrt (isb2sq + ibl2sq)
  ir2ds     =  sqrt (isb2sq + ibr2sq)

; I4 -------------------------------------------------------------------------------------
; I4 LISTENER-TO-FIRST-REFLECTED-SOUND DISTANCES

; I4 --- "NORTH/SOUTH"

  insxl1ds  =  sqrt (ibl1sq + gihfrlsq)
  insxr1ds  =  sqrt (ibr1sq + gihfrlsq)
  insxl2ds  =  sqrt (ibl2sq + gihfrlsq)
  insxr2ds  =  sqrt (ibr2sq + gihfrlsq)

; I4 --- "EAST/WEST"

  iewtvdsl  =  gihfrw + gihfhead
  iewtvdsr  =  gihfrw - gihfhead
  iewtvdslsq   =      iewtvdsl * iewtvdsl
  iewtvdsrsq   =      iewtvdsr * iewtvdsr
  iewxl1ds  =  sqrt (isb1sq + iewtvdslsq)
  iewxr1ds  =  sqrt (isb1sq + iewtvdsrsq)
  iewxl2ds  =  sqrt (isb2sq + iewtvdslsq)
  iewxr2ds  =  sqrt (isb2sq + iewtvdsrsq)
     
; I4 -------------------------------------------------------------------------------------
; I4 SOUND-SOURCE-TO-WALL DISTANCES

  inwlds1   =  gihfrl - isb1
  iewlds1   =  gihfrw - ibh1
  iswlds1   =  gihfrl + isb1
  iwwlds1   =  gihfrw + ibh1
  inwlds2   =  gihfrl - isb2
  iewlds2   =  gihfrw - ibh2
  iswlds2   =  gihfrl + isb2
  iwwlds2   =  gihfrw + ibh2

; I4 -------------------------------------------------------------------------------------
; I4 TOTAL FIRST REFLECTION PATHS

; I4 --- COMPONENT 1

; I4 --- --- LEFT CHANNEL

  infrpl1   =  inwlds1 + insxl1ds
  iefrpl1   =  iewlds1 + iewxl1ds
  isfrpl1   =  iswlds1 + insxl1ds
  iwfrpl1   =  iewlds1   + iewxl1ds

; I4 --- --- RIGHT CHANNEL

  infrpr1   =  inwlds1 + insxr1ds
  iefrpr1   =  iewlds1 + iewxr1ds
  isfrpr1   =  iswlds1 + insxr1ds
  iwfrpr1   =  iewlds1   + iewxr1ds

; I4 --- COMPONENT 2

; I4 --- --- LEFT CHANNEL

  infrpl2   =  inwlds1 + insxl2ds
  iefrpl2   =  iewlds1 + iewxl2ds
  isfrpl2   =  iswlds1 + insxl2ds
  iwfrpl2   =  iewlds1   + iewxl2ds

; I4 --- --- RIGHT CHANNEL

  infrpr2   =  inwlds1 + insxr2ds
  iefrpr2   =  iewlds1 + iewxr2ds
  isfrpr2   =  iswlds1 + insxr2ds
  iwfrpr2   =  iewlds1   + iewxr2ds


; I4 -------------------------------------------------------------------------------------
; I4 DELAY TIMES FOR DIRECT SOUND

  il1dyd    =  il1ds * 0.00289855
  il1dyd    =  (il1dyd > gibufkcyc ? il1dyd : gibufkcyc)
  ir1dyd    =  ir1ds * 0.00289855
  ir1dyd    =  (ir1dyd > gibufkcyc ? ir1dyd : gibufkcyc)
  il2dyd    =  il2ds * 0.00289855
  il2dyd    =  (il2dyd > gibufkcyc ? il2dyd : gibufkcyc)
  ir2dyd    =  ir2ds * 0.00289855
  ir2dyd    =  (ir2dyd > gibufkcyc ? ir2dyd : gibufkcyc)

; I4 -------------------------------------------------------------------------------------
; I4 DELAY TIMES FOR REFLECTED SOUND

  ildt      =  0

; I4 --- COMPONENT 1

; I4 --- --- LEFT CHANNEL

  inxl1dy   =  infrpl1 * 0.00289855
  inxl1dy   =  (inxl1dy > gibufkcyc ? inxl1dy : gibufkcyc)
  ildt      =  (inxl1dy > ildt ? inxl1dy : ildt)
  iexl1dy   =  iefrpl1 * 0.00289855
  iexl1dy   =  (iexl1dy > gibufkcyc ? iexl1dy : gibufkcyc)
  ildt      =  (iexl1dy > ildt ? iexl1dy : ildt)
  isxl1dy   =  infrpl1 * 0.00289855
  isxl1dy   =  (isxl1dy > gibufkcyc ? isxl1dy : gibufkcyc)
  ildt      =  (isxl1dy > ildt ? isxl1dy : ildt)
  iwxl1dy   =  iefrpl1 * 0.00289855
  iwxl1dy   =  (iwxl1dy > gibufkcyc ? iwxl1dy : gibufkcyc)
  ildt      =  (iwxl1dy > ildt ? iwxl1dy : ildt)

; I4 --- --- RIGHT CHANNEL

  inxr1dy   =  infrpr1 * 0.00289855
  inxr1dy   =  (inxr1dy > gibufkcyc ? inxr1dy : gibufkcyc)
  ildt      =  (inxr1dy > ildt ? inxr1dy : ildt)
  iexr1dy   =  iefrpr1 * 0.00289855
  iexr1dy   =  (iexr1dy > gibufkcyc ? iexr1dy : gibufkcyc)
  ildt      =  (iexr1dy > ildt ? iexr1dy : ildt)
  isxr1dy   =  infrpr1 * 0.00289855
  isxr1dy   =  (isxr1dy > gibufkcyc ? isxr1dy : gibufkcyc)
  ildt      =  (isxr1dy > ildt ? isxr1dy : ildt)
  iwxr1dy   =  iefrpr1 * 0.00289855
  iwxr1dy   =  (iwxr1dy > gibufkcyc ? iwxr1dy : gibufkcyc)
  ildt      =  (iwxr1dy > ildt ? iwxr1dy : ildt)

; I4 --- COMPONENT 2

; I4 --- --- LEFT CHANNEL

  inxl2dy   =  infrpl2 * 0.00289855
  inxl2dy   =  (inxl2dy > gibufkcyc ? inxl2dy : gibufkcyc)
  ildt      =  (inxl2dy > ildt ? inxl2dy : ildt)
  iexl2dy   =  iefrpl1 * 0.00289855
  iexl2dy   =  (iexl2dy > gibufkcyc ? iexl2dy : gibufkcyc)
  ildt      =  (iexl2dy > ildt ? iexl2dy : ildt)
  isxl2dy   =  infrpl2 * 0.00289855
  isxl2dy   =  (isxl2dy > gibufkcyc ? isxl2dy : gibufkcyc)
  ildt      =  (isxl2dy > ildt ? isxl2dy : ildt)
  iwxl2dy   =  iefrpl1 * 0.00289855
  iwxl2dy   =  (iwxl2dy > gibufkcyc ? iwxl2dy : gibufkcyc)
  ildt      =  (iwxl2dy > ildt ? iwxl2dy : ildt)

; I4 --- --- RIGHT CHANNEL

  inxr2dy   =  infrpr2 * 0.00289855
  inxr2dy   =  (inxr2dy > gibufkcyc ? inxr2dy : gibufkcyc)
  ildt      =  (inxr2dy > ildt ? inxr2dy : ildt)
  iexr2dy   =  iefrpr1 * 0.00289855
  iexr2dy   =  (iexr2dy > gibufkcyc ? iexr2dy : gibufkcyc)
  ildt      =  (iexr2dy > ildt ? iexr2dy : ildt)
  isxr2dy   =  infrpr2 * 0.00289855
  isxr2dy   =  (isxr2dy > gibufkcyc ? isxr2dy : gibufkcyc)
  ildt      =  (isxr2dy > ildt ? isxr2dy : ildt)
  iwxr2dy   =  iefrpr1 * 0.00289855
  iwxr2dy   =  (iwxr2dy > gibufkcyc ? iwxr2dy : gibufkcyc)
  ildt      =  (iwxr2dy > ildt ? iwxr2dy : ildt)

; I4 -------------------------------------------------------------------------------------
; I4 ACTUAL DURATION (P3) LENGTHENED BY LONGEST DELAY TIME

  p3        =  idur + ildt + gibufkcyc

; I4 -------------------------------------------------------------------------------------
; I4 PARTIAL SERIES CALCULATIONS   

  ifreq1p1  =  ifreq1p0 * (1 + inpdf1)
  ifreq1p2  =  ifreq1p0 * (1 + (2 * inpdf1))
  ifreq1p3  =  ifreq1p0 * (1 + (3 * inpdf1))
  ifreq1p4  =  ifreq1p0 * (1 + (4 * inpdf1))
  ifreq1p5  =  ifreq1p0 * (1 + (5 * inpdf1))
  ifreq1p6  =  ifreq1p0 * (1 + (6 * inpdf1))
  ifreq1p7  =  ifreq1p0 * (1 + (7 * inpdf1))
  ifreq2p1  =  ifreq2p0 * (1 + inpdf2)
  ifreq2p2  =  ifreq2p0 * (1 + (2 * inpdf2))
  ifreq2p3  =  ifreq2p0 * (1 + (3 * inpdf2))
  ifreq2p4  =  ifreq2p0 * (1 + (4 * inpdf2))
  ifreq2p5  =  ifreq2p0 * (1 + (5 * inpdf2))
  ifreq2p6  =  ifreq2p0 * (1 + (6 * inpdf2))
  ifreq2p7  =  ifreq2p0 * (1 + (7 * inpdf2))

; I4 -------------------------------------------------------------------------------------
; I4 PITCH-WOBBLE FREQUENCIES 

  iwobfz1   =  ipc1 / idur
  iwobfz2   =  ipc2 / idur

; I4 -------------------------------------------------------------------------------------
; I4 PITCH-WOBBLE AMPLITUDES

  kwobln1   line      iwobmt1, idur, 0
  kwobln2   line      iwobmt2, idur, 0

; I4 -------------------------------------------------------------------------------------
; I4 PITCH-WOBBLE PATHS

  kwobfz1   line      iwobfz1, idur, iwobfz1 * (1 - inpdf1)
  kwobfz2   line      iwobfz2, idur, iwobfz2 * (1 - inpdf2)

; I4 -------------------------------------------------------------------------------------
; I4 PITCH-WOBBLE CONTROL SIGNALS

  kwob1     oscil     kwobln1, kwobfz1, 1
  kwob2     oscil     kwobln2, kwobfz2, 1

; I4 -------------------------------------------------------------------------------------
; I4 AMP ENVELOPES  FOR BUZZ SOURCES

  aenv1     envlpx    ipamp1, iatk1, idur, idec1, 2, .5, .01, 0
  aenv2     envlpx    ipamp2, iatk2, idur, idec2, 2, .5, .01, 0    

; I4 -------------------------------------------------------------------------------------
; I4 RANDOM PITCH FLUCTUATION

  kwarb1    randi     .0080 * ifreq1p0,10
  kwarb2    randi     .0082 * ifreq2p0,10

; I4 -------------------------------------------------------------------------------------
; I4 wobbling fundamental

  kfund1    =  ifreq1p0 + kwob1
  kfund2    =  ifreq2p0 + kwob2

; I4 -------------------------------------------------------------------------------------
; I4 NUMBER OF HARMONICS IN BUZZ SOURCE

  knh1      =  giihfsr / ifreq1p0
  knh2      =  giihfsr / ifreq2p0
  knh1      =  (knh1 < 1 ? 1 : knh1)    
  knh2      =  (knh2 < 1 ? 1 : knh2)    

; I4 -------------------------------------------------------------------------------------
; I4 BUZZ SOURCES

  a1sou     buzz      aenv1, kfund1 + kwarb1, knh1, 4
  a2sou     buzz      aenv2, kfund2 + kwarb2, knh2, 4

; I4 -------------------------------------------------------------------------------------
; I4 FILTER BANKS (IN PARALLEL)

  a1p0      reson     a1sou, ifreq1p0, iwid1, 1
  a1p1      reson     a1sou, ifreq1p1, iwid1 * 0.9, 1
  a1p2      reson     a1sou, ifreq1p2, iwid1 * 0.8, 1
  a1p3      reson     a1sou, ifreq1p3, iwid1 * 0.7, 1
  a1p4      reson     a1sou, ifreq1p4, iwid1 * 0.6, 1
  a1p5      reson     a1sou, ifreq1p5, iwid1 * 0.5, 1
  a1p6      reson     a1sou, ifreq1p6, iwid1, 1
  a1p7      reson     a1sou, ifreq1p7, iwid1, 1
  a2p0      reson     a2sou, ifreq2p0, iwid2, 1
  a2p1      reson     a2sou, ifreq2p1, iwid2 * 0.9, 1
  a2p2      reson     a2sou, ifreq2p2, iwid2 * 0.8, 1
  a2p3      reson     a2sou, ifreq2p3, iwid2 * 0.7, 1
  a2p4      reson     a2sou, ifreq2p4, iwid2 * 0.6, 1
  a2p5      reson     a2sou, ifreq2p5, iwid2 * 0.5, 1
  a2p6      reson     a2sou, ifreq2p6, iwid2, 1
  a2p7      reson     a2sou, ifreq2p7, iwid2, 1

; I4 -------------------------------------------------------------------------------------
; I4 FILTER OUTPUTS SUMMED, LOW-PASS FILTERED, AND BALANCED 
  a1sum     =  a1p0 + (0.78 * a1p1) + (0.65 * a1p2) + (0.34 * a1p3) + (0.30 * a1p4) + (0.28 * a1p5) + (0.20 * a1p6) + (0.15 * a1p7)
  a2sum     =  a2p0 + (0.76 * a2p1) + (0.54 * a2p2) + (0.32 * a2p3) + (0.25 * a2p4) + (0.20 * a2p5) + (0.19 * a2p6) + (0.13 * a2p7)
  a1fil     tone      a1sum, 2000
  a2fil     tone      a2sum, 2000
  a1bal     balance   a1fil, a1sou
  a2bal     balance   a2fil, a2sou

; I4 -------------------------------------------------------------------------------------
; I4 DELAY LINES (ITD)

; I4 --- COMPONENT ONE

; I4 --- --- LEFT CHANNEL

  al1d      delay     a1bal, il1dyd
  al1xn     delay     a1bal, inxl1dy
  al1xe     delay     a1bal, iexl1dy
  al1xs     delay     a1bal, isxl1dy
  al1xw     delay     a1bal, iwxl1dy

; I4 --- --- RIGHT CHANNEL

  ar1d      delay     a1bal, ir1dyd
  ar1xn     delay     a1bal, inxr1dy
  ar1xe     delay     a1bal, iexr1dy
  ar1xs     delay     a1bal, isxr1dy
  ar1xw     delay     a1bal, iwxr1dy

; I4 --- COMPONENT 2

; I4 --- --- LEFT CHANNEL

  al2d      delay     a2bal, il2dyd
  al2xn     delay     a2bal, inxl2dy
  al2xe     delay     a2bal, iexl2dy
  al2xs     delay     a2bal, isxl2dy
  al2xw     delay     a2bal, iwxl2dy

; I4 --- --- RIGHT CHANNEL

  ar2d      delay     a2bal, ir2dyd
  ar2xn     delay     a2bal, inxr2dy
  ar2xe     delay     a2bal, iexr2dy
  ar2xs     delay     a2bal, isxr2dy
  ar2xw     delay     a2bal, iwxr2dy

; I4 -------------------------------------------------------------------------------------
; I4 AMP FACTORS FOR NO-REVERB DIRECT SOUND

  il1dampf  =  1 + (1 / il1ds)
  ir1dampf  =  1 + (1 / ir1ds)
  il2dampf  =  1 + (1 / il2ds)
  ir2dampf  =  1 + (1 / ir2ds)

; I4 -------------------------------------------------------------------------------------
; I4 AMP FACTORS FOR NO-REVERB FIRST-REFLECTED SOUND

; I4 --- COMPONENT 1

; I4 --- --- LEFT CHANNEL

  il1xnampf =  1 + (1 / infrpl1)
  il1xeampf =  1 + (1 / iefrpl1)
  il1xsampf =  1 + (1 / isfrpl1)
  il1xwampf =  1 + (1 / iwfrpl1)

; I4 --- --- RIGHT CHANNEL

  ir1xnampf =  1 + (1 / infrpr1)
  ir1xeampf =  1 + (1 / iefrpr1)
  ir1xsampf =  1 + (1 / isfrpr1)
  ir1xwampf =  1 + (1 / iwfrpr1)

; I4 --- COMPONENT 2

; I4 --- --- LEFT CHANNEL

  il2xnampf =  1 + (1 / infrpl2)
  il2xeampf =  1 + (1 / iefrpl2)
  il2xsampf =  1 + (1 / isfrpl2)
  il2xwampf =  1 + (1 / iwfrpl2)

; I4 --- --- RIGHT CHANNEL

  ir2xnampf =  1 + (1 / infrpr2)
  ir2xeampf =  1 + (1 / iefrpr2)
  ir2xsampf =  1 + (1 / isfrpr2)
  ir2xwampf =  1 + (1 / iwfrpr2)

; I4 -------------------------------------------------------------------------------------
; I4 AMP FACTORS FOR REVERB-INPUT DIRECT SOUND

  il1revdampf  =      1 + (1 / (il1ds * il1ds))
  ir1revdampf  =      1 + (1 / (ir1ds * ir1ds))
  il2revdampf  =      1 + (1 / (il2ds * il2ds))
  ir2revdampf  =      1 + (1 / (ir2ds * ir2ds))

; I4 -------------------------------------------------------------------------------------
; I4 AMP FACTORS FOR REVERB-INPUT FIRST-REFLECTED SOUND

; I4 --- COMPONENT 1

; I4 --- --- LEFT CHANNEL

  il1revxnampf =      1 + (1 / (infrpl1 * infrpl1))
  il1revxeampf =      1 + (1 / (iefrpl1 * iefrpl1))
  il1revxsampf =      1 + (1 / (isfrpl1 * isfrpl1))
  il1revxwampf =      1 + (1 / (iwfrpl1 * iwfrpl1))

; I4 --- --- RIGHT CHANNEL

  ir1revxnampf =      1 + (1 / (infrpr1 * infrpr1))
  ir1revxeampf =      1 + (1 / (iefrpr1 * iefrpr1))
  ir1revxsampf =      1 + (1 / (isfrpr1 * isfrpr1))
  ir1revxwampf =      1 + (1 / (iwfrpr1 * iwfrpr1))

; I4 --- COMPONENT 2

; I4 --- --- LEFT CHANNEL

  il2revxnampf =      1 + (1 / (infrpl2 * infrpl2))
  il2revxeampf =      1 + (1 / (iefrpl2 * iefrpl2))
  il2revxsampf =      1 + (1 / (isfrpl2 * isfrpl2))
  il2revxwampf =      1 + (1 / (iwfrpl2 * iwfrpl2))

; I4 --- --- RIGHT CHANNEL

  ir2revxnampf =      1 + (1 / (infrpr2 * infrpr2))
  ir2revxeampf =      1 + (1 / (iefrpr2 * iefrpr2))
  ir2revxsampf =      1 + (1 / (isfrpr2 * isfrpr2))
  ir2revxwampf =      1 + (1 / (iwfrpr2 * iwfrpr2))

; I4 -------------------------------------------------------------------------------------
; I4 NO-REVERB SOUND     

; I4 --- DIRECT SOUND

  al1d      =  (al1d * il1dampf)
  ar1d      =  (ar1d * ir1dampf)
  al2d      =  (al2d * il2dampf)
  ar2d      =  (ar2d * ir2dampf)

; I4 --- FIRST REFLECTIONS

  al1x      =  (al1xn * il1xnampf) + (al1xe * il1xeampf) + (al1xs * il1xsampf) + (al1xw * il1xwampf)
  ar1x      =  (ar1xn * ir1xnampf) + (ar1xe * ir1xeampf) + (ar1xs * ir1xsampf) + (ar1xw * ir1xwampf)
  al2x      =  (al2xn * il2xnampf) + (al2xe * il2xeampf) + (al2xs * il2xsampf) + (al2xw * il2xwampf)
  ar2x      =  (ar2xn * ir2xnampf) + (ar2xe * ir2xeampf) + (ar2xs * ir2xsampf) + (ar2xw * ir2xwampf)

; I4 --- SUM

  alnorev   =  al1d + al2d + al1x + al2x
  arnorev   =  ar1d + ar2d + ar1x + ar2x

; I4 -------------------------------------------------------------------------------------
; I4 REVERB-INPUT SOUND  

; I4 --- DIRECT SOUND

  al1revd   =  (al1d * il1revdampf)
  ar1revd   =  (ar1d * ir1revdampf)
  al2revd   =  (al2d * il2revdampf)
  ar2revd   =  (ar2d * ir2revdampf)

; I4 --- FIRST REFLECTIONS

  al1revx   =  (al1xn * il1revxnampf) + (al1xe * il1revxeampf) + (al1xs * il1revxsampf) + (al1xw * il1revxwampf)
  ar1revx   =  (ar1xn * ir1revxnampf) + (ar1xe * ir1revxeampf) + (ar1xs * ir1revxsampf) + (ar1xw * ir1revxwampf)
  al2revx   =  (al2xn * il2revxnampf) + (al2xe * il2revxeampf) + (al2xs * il2revxsampf) + (al2xw * il2revxwampf)
  ar2revx   =  (ar2xn * ir2revxnampf) + (ar2xe * ir2revxeampf) + (ar2xs * ir2revxsampf) + (ar2xw * ir2revxwampf)

; I4 --- SUM

  alrev     =  al1revd + al2revd + al1revx + al2revx
  arrev     =  ar1revd + ar2revd + ar1revx + ar2revx
     
; I4 -------------------------------------------------------------------------------------
; I4 NO-REVERB SOUND SCALED AND OUT
            outs      giscalef * alnorev, giscalef * arnorev

; I4 -------------------------------------------------------------------------------------
; I4 REVERB-INPUT SOUND TO GLOBAL REVERB SIGNAL

  gai2lrev  =  gai2lrev + alrev
  gai2rrev  =  gai2rrev + arrev

; I4 -------------------------------------------------------------------------------------
; I4 END

endin

; I91 =====================================================================================
; I91  INSTRUMENT 91
; I91 =====================================================================================

instr 91

  irt       =  p4                                 ; AVERAGE REVERB TIME

; I91 -------------------------------------------------------------------------------------
; I91 VARYING REVERB PATH

  kvv       randh     2, 2
  klrtv     randi     irt * 0.4, kvv + 2.01
  krrtv     randi     irt * 0.4, kvv + 2.01

  aleft     reverb    gai1lrev, klrtv + irt
  aright    reverb    gai1rrev, krrtv + irt

            outs      giscalef * aleft, giscalef * aright

  gai1lrev  =  0
  gai1rrev  =  0

; I91 -------------------------------------------------------------------------------------
; I91 END

endin

; I92 =====================================================================================
; I92  INSTRUMENT 92
; I92 =====================================================================================

instr 92

  irt       =  p4                                 ; AVERAGE REVERB TIME

; I92 -------------------------------------------------------------------------------------
; I92 VARYING REVERB PATH

  kvv       randh     2, 2
  klrtv     randi     irt * 0.6, kvv + 2.01
  krrtv     randi     irt *  .6, kvv + 2.01

  aleft     reverb    gai2lrev, klrtv + irt
  aright    reverb    gai2rrev, krrtv + irt

            outs      giscalef * aleft, giscalef * aright

  gai2lrev  =  0
  gai2rrev  =  0

; I92 -------------------------------------------------------------------------------------
; I92 END

endin

; I94 =====================================================================================
; I94  INSTRUMENT 94
; I94 =====================================================================================

instr 94

  irt       =  p4                                 ; AVERAGE REVERB TIME

; I94 -------------------------------------------------------------------------------------
; I94 VARYING REVERB PATH

  kvv       randh     2, 2
  klrtv     randi     irt * 0.8, kvv + 2.01
  krrtv     randi     irt * 0.8, kvv + 2.01

  aleft     reverb    gai4lrev, klrtv + irt
  aright    reverb    gai4rrev, krrtv + irt

            outs      aleft, aright

  gai4lrev  =  0
  gai4rrev  =  0

; I94 -------------------------------------------------------------------------------------
; I94 END

endin

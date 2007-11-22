  sr        =  44100
  kr        =  2205
  ksmps     =  20
  nchnls    =  2

  garvbsig  init      0
  gasig     init      0

instr 1                 ;filtered saw
  irvbgain  =  p11
  iamp      =  ampdb(p5)
  inote     =  cpspch(p4)
  k1        linen     iamp,p6,p3,p7
  kpan      oscil     1,1/p3,p12
  a1        oscil     k1,inote,p8
  a2        oscil     k1,inote+.998,p8
  a3        oscil     k1,inote+1.003,p8
  k2        line      p9,p3,p10
  a4        =  (a1+a2+a3)/3
  aout      reson     a4,k2,100, 2
            outs      aout*kpan,aout*(1-kpan)
  garvbsig  =  garvbsig+(aout*irvbgain)
endin

instr 2        ;fm bouncing
  ifrqrat   =  p8*p5
  iamprat   =  p4*p9
  ibalance  =  p14
  intoe     =  cpspch(ifrqrat)
  iamp2     =  ampdb(iamprat)
  iamp      =  ampdb(p4*.8)
  inote     =  cpspch(p5)
  iamp3     =  ampdb(75)
  irvgain   =  p15
  k3        oscil     iamp3,1/p3,p7
  krepeat   =  k3*p16
  k1        oscil     iamp,(1/p3)*krepeat,p6
  k2        linen     iamp2,p10,p3,p11
  a2        oscil     k2,intoe,p13
  a1        oscil     k1,inote+a2,p12
            outs      a1*ibalance,a1*(1-ibalance)
  garvbsig  =  garvbsig+(a1*irvgain)
endin

instr 3                 ;filtered noise
  iamp      =  p12
  ksweep    line      p5,p3,p6
  kenv      oscil     iamp,(1/p3)*p7,p8            
  kpan      oscil     1,(1/p3)*p9,p10
  anoise    rand      16000
  afilt     reson     anoise,ksweep,p4,2
  asig      =  afilt*kenv 
            outs      asig*kpan,asig*(1-kpan)
  garvbsig  =  garvbsig+(asig*p11)
endin

instr 4                 ;random pitch 
  iamp      =  ampdb(p5 * .9)
  inote     =  cpspch(p6)
  kenv      oscil     1,1/p3,p11
  krand     randh     p7,p8
  kpan      oscil     1,1/p3,p9
  asig      oscil     iamp*kenv,inote+krand,p4
            outs      asig*kpan,asig*(1-kpan)
  garvbsig  =  garvbsig+(asig*p10)
endin

instr 99
  asig      reverb2   garvbsig,p4,p5
            outs      asig,asig
  garvbsig  =  0
endin

instr 98                ;DELAY LINE

  a1        delay     gasig,p4
  a2        delay     a1*p5,p4
  a3        delay     a2*p5,p4
  a4        delay     a3*p5,p4
  a5        delay     a4*p5,p4
  a6        delay     a5*p5,p4
            outs      (a1+a3+a5)/3,(a2+a4+a6)/3
  gasig     =  0
endin

instr 5                 ;DUAL FOSCIL     
  index     =  p11
  iamp      =  ampdb(p4)
  inote     =  cpspch(p5)
  ifmrise   =  p9*p3
  ifmamp    =  p8
  ifmdec    =  p10*p3
  ifmoff    =  p3-(ifmrise+ifmdec)
  kfm       linseg    0,ifmrise,ifmamp,ifmdec,0,ifmoff,0
  kndx      =  kfm*index
  kpan      oscil     1,1/p3,p14
  kenv      oscil     1,1/p3,p15
  a1        foscil    iamp,inote,p6,p7,kndx,p12
  a2        foscil    iamp,inote+1.003,p6,p7,kndx,p12
  a3        =  (a1+a2)/2
  a4        =  a3*kenv
            outs      a4*kpan,a4*(1-kpan)
  garvbsig  =  garvbsig+(a4*p13)
endin


instr 6                 ;RAND PTCH W/ SEND TO DELAY 
  iamp      =  ampdb(p5)
  inote     =  cpspch(p6)
  kenv      oscil     1,1/p3,p11
  krand     randh     p7,p8
  kpan      oscil     1,1/p3,p9
  asig      oscil     iamp*kenv,inote+krand,p4
            outs      asig*kpan,asig*(1-kpan)
  gasig     =  gasig+(asig*p10)
endin

instr 7                 ;PITCH TABLE W/ LFO
  ilfort    =  p5
  itablesize   =      p6
  itable    =  p7
  iamp      =  ampdb(p4)
  kindex    phasor    ilfort 
  kpitch    table     kindex*itablesize,itable
  knote     =  cpspch(kpitch)
  kenv      oscil     iamp,1/p3,p8
  kpan      oscil     1,1/p3,p10
  a1        oscil     kenv,knote,p9
  krtl      =  sqrt(kpan)
  krtr      =  sqrt(1-kpan)
  al        =  a1*krtl
  ar        =  a1*krtr
            outs      al,ar 
  garvbsig  =  garvbsig+(a1*p11)
endin

instr 8                 ;DUAL FOSCIL W/ MODULATING ENV     
  index     =  p11
  iamp      =  ampdb(p4)
  inote     =  cpspch(p5)
  ifmrise   =  p9*p3
  ifmamp    =  p8
  ifmdec    =  p10*p3
  ifmoff    =  p3-(ifmrise+ifmdec)
  kfm       linseg    0,ifmrise,ifmamp,ifmdec,0,ifmoff,0
  kndx      =  kfm*index
  kpan      oscil     1,1/p3,p14
  krpt      oscil     1,1/p3,p16
  krepeat   =  krpt*p17
  kenv      oscil     iamp,(1/p3)*krepeat,p15
  a1        foscil    kenv,inote,p6,p7,kndx,p12
  a2        foscil    kenv,inote+1.003,p6,p7,kndx,p12
  a3        =  (a1+a2)/2
            outs      a3*kpan,a3*(1-kpan)
  garvbsig  =  garvbsig+(a3*p13)
endin

instr 9
  inote     =  cpspch(p8)
  iamp      =  ampdb(p9)
  kenv      oscil     1,1/p3,p4
  asig      oscil     iamp*kenv,inote,19
  asig2     oscil     (iamp*kenv)*.7,inote,26
  kfilt1    oscil     1,1/p3,p5
  kfilt2    oscil     1,1/p3,p6
  kfilt3    oscil     1,1/p3,p7
  af1       reson     asig, 110*kfilt1, 20, 2
  af2       reson     asig, 220*kfilt2, 30, 2
  af3       reson     asig, 440*kfilt3, 40, 2
  aout      balance   0.6*af1+af2+0.6*af3+0.4*asig+2*asig2, asig
            outs      aout,aout
endin

instr 10
  inote     =  cpspch(p4)
  iamp      =  ampdb(p5)
  kenv      oscil     1,1/p3,p7
  kvib      oscil     1,p9,26
  asig      oscil     iamp*kenv,inote+(kvib*(p10*2)),p11
  kfilt     oscil     1,1/p3,p6
  af1       reson     asig,5000*kfilt,50, 2
  a2        =  af1*kenv
            outs      asig,asig
  gasig     =  gasig+(a2*p8)
endin

instr 11                                ;female OO
  iamp      =  ampdb(p4)
  inote     =  cpspch(p5)
  a1        buzz      iamp,inote,15,31
  a2        buzz      iamp,inote+1.003,15,31
  afilt1    =  (a1+a2)/2
  afilt2    reson     afilt1,280,20, 2
  afilt3    reson     afilt1,650,25, 2
  afilt4    reson     afilt1,2200,30, 2
  afilt5    reson     afilt1,3450,40, 2
  afilt6    reson     afilt1,4500,50, 2
  kenv      oscil     1,1/p3,30
  aout      =  (afilt2+afilt3+afilt4+afilt5+afilt6)/5
  alp       butterlp  aout,2000
            outs      alp*kenv,alp*kenv
  gasig     =  gasig+((alp*kenv)*p6)
endin

instr 12                        ;female AA
  iamp      =  ampdb(p4)
  inote     =  cpspch(p5)
  a1        buzz      iamp,inote,15,31
  a2        buzz      iamp,inote+1.003,15,31
  afilt1    =  (a1+a2)/2
  afilt2    reson     afilt1,650,50, 2
  afilt3    reson     afilt1,1100,50, 2
  afilt4    reson     afilt1,2860,50, 2
  afilt5    reson     afilt1,3300,50, 2
  afilt6    reson     afilt1,4500,50, 2
  kenv      oscil     1,1/p3,30
  aout      =  (afilt2+afilt3+afilt4+afilt5+afilt6)/5
  alp       butterlp  aout,2000
            outs      alp*kenv,alp*kenv
  gasig     =  gasig+((alp*kenv)*p6)
endin

instr 13                        ;female E
  iamp      =  ampdb(p4)
  inote     =  cpspch(p5)
  a1        buzz      iamp,inote,15,31
  a2        buzz      iamp,inote+1.003,15,31
  afilt1    =  (a1+a2)/2
  afilt2    reson     afilt1,500,50, 2
  afilt3    reson     afilt1,1750,50, 2
  afilt4    reson     afilt1,2450,50, 2
  afilt5    reson     afilt1,3350,50, 2
  afilt6    reson     afilt1,5000,50, 2
  kenv      oscil     1,1/p3,30
  aout      =  (afilt2+afilt3+afilt4+afilt5+afilt6)/5
  alp       butterlp  aout,2000
            outs      alp*kenv,alp*kenv
  gasig     =  gasig+((alp*kenv)*p6)
endin

instr 14                        ;female IY
  iamp      =  ampdb(p4)
  inote     =  cpspch(p5)
  a1        buzz      iamp,inote,15,31
  a2        buzz      iamp,inote+1.003,15,31
  afilt1    =  (a1+a2)/2
  afilt2    reson     afilt1,330,50, 2
  afilt3    reson     afilt1,2000,50, 2
  afilt4    reson     afilt1,2800,50, 2
  afilt5    reson     afilt1,3650,50, 2
  afilt6    reson     afilt1,5000,50, 2
  kenv      oscil     1,1/p3,30
  aout      =  (afilt2+afilt3+afilt4+afilt5+afilt6)/5
  alp       butterlp  aout,2000
            outs      alp*kenv,alp*kenv
  gasig     =  gasig+((alp*kenv)*p6)
endin

instr 15                        ;female O
  iamp      =  ampdb(p4)
  inote     =  cpspch(p5)
  a1        buzz      iamp,inote,15,31
  a2        buzz      iamp,inote+1.003,15,31
  afilt1    =  (a1+a2)/2
  afilt2    reson     afilt1,400,50, 2
  afilt3    reson     afilt1,840,50, 2
  afilt4    reson     afilt1,2800,50, 2
  afilt5    reson     afilt1,3250,50, 2
  afilt6    reson     afilt1,4500,50, 2
  kenv      oscil     1,1/p3,30
  aout      =  (afilt2+afilt3+afilt4+afilt5+afilt6)/5
  alp       butterlp  aout,2000
            outs      alp*kenv,alp*kenv
  gasig     =  gasig+((alp*kenv)*p6)
endin

instr 16                        ;female OO w/ vib formerly i8
  iamp      =  ampdb(p4)
  inote     =  cpspch(p5)
  kvib      oscil     1,p7,29
  a1        buzz      iamp,inote+(kvib*(p8*2)),15,31
  a2        buzz      iamp,(inote+1.003)+(kvib*(p8*2)),15,31
  afilt1    =  (a1+a2)/2 
  afilt2    reson     afilt1,280,50, 2
  afilt3    reson     afilt1,650,40, 2
  afilt4    reson     afilt1,2200,40, 2
  afilt5    reson     afilt1,3450,40, 2
  afilt6    reson     afilt1,4500,50, 2
  kenv      oscil     1,1/p3,30
  aout      =  (afilt2+afilt3+afilt4+afilt5+afilt6)/5
  alp1      butterlp  aout,1800
  alp       butterlp  alp1,3500
            outs      alp*kenv,alp*kenv
  gasig     =  gasig+((alp*kenv)*p6)
endin

instr 17                ;DEEP FM 
  ibalance  =  p6
  iamp      =  ampdb(p4)
  inote     =  cpspch(p5)
  kmodenv   oscil     1,1/p3,32
  a3        oscil     kmodenv*(iamp*.05),inote,29
  a2        oscil     iamp*.07,inote,29
  a1        oscil     iamp,inote+a2+a3,29
  kenv      oscil     1,1/p3,33
  aout      =  a1*kenv
            outs      aout*ibalance,aout*(1-ibalance)
  gasig     =  gasig+((aout*kenv)*p7)
endin

instr 18                ;delay chorus saw
  irvbgain  =  p6
  iamp      =  ampdb(p4 * .9)
  inote     =  cpspch(p5)
  kenv      oscil     1,1/p3,37
  a1        oscil     iamp*kenv,inote,36
  amod      oscil     2,.25,29
  adel      vdelay    a1,amod,20
  adel2     vdelay    adel,amod,20
  adel3     vdelay    adel2,amod,20
  adel4     vdelay    adel3,amod,20
  adel5     vdelay    adel4,amod,20
  aout      =  (adel3+adel2+adel+adel4+adel5+a1)/6
  abal      balance   aout,a1
            outs      abal,abal
  garvbsig  =  garvbsig+(abal*irvbgain)
endin

instr 19                        ;AM BELL
  iamp      =  ampdb(p4)
  inote     =  cpspch(p5)
  irvbgain  =  p6
  a5        oscil     iamp*.25,1729+inote,10
  a4        oscil     (iamp*.3)+a5,973+inote,10
  a1        oscil     (iamp*.5)+a4,513+inote,10
  a2        oscil     a1+iamp,inote,10
  a3        oscil     iamp,440,10
  kenv      oscil     1,1/p3,40
  am        balance   a2,a3 
  aout      =  am*kenv
            outs      aout,aout
  garvbsig  =  garvbsig+(aout*irvbgain)
endin

instr 20                        ;WOW
  iamp      =  ampdb(p4)
  inote     =  cpspch(p5)
  a1        buzz      iamp,inote,15,31
  a2        buzz      iamp,inote+1.003,15,31
  kmod      oscil     iamp,1/p3,41
  afilt1    =  (a1+a2)/2
  afilt2    reson     afilt1,650+kmod,50, 2
  afilt3    reson     afilt1,1100+kmod,50, 2
  afilt4    reson     afilt1,2860+kmod,50, 2
  afilt5    reson     afilt1,3300+kmod,50, 2
  afilt6    reson     afilt1,4500+kmod,50, 2
  kenv      oscil     1,1/p3,30
  aout      =  (afilt2+afilt3+afilt4+afilt5+afilt6)/5
  alp       butterlp  aout,2000
            outs      alp*kenv,alp*kenv
  gasig     =  gasig+((alp*kenv)*p6)
endin

instr 21                        ;random pitch w/ pitch eg and envelope repeat 
  iamp      =  ampdb(p5)
  inote     =  cpspch(p6)
  kpitch    oscil     iamp/2,1/p3,p12
  krptfun   oscil     100,1/p3,49
  kenv      oscil     iamp,1/p3*krptfun,p11
  krand     randh     p7,p8
  kpan      oscil     1,1/p3,p9
  asig      oscil     kenv,inote+kpitch,p4
            outs      asig*kpan,asig*(1-kpan)
  garvbsig  =  garvbsig+(asig*p10)
endin



  sr        =  44100 
  kr        =  2205                                 
  ksmps     =  20
  nchnls    =  2

  garvbsig1 init      0
  garvbsig2 init      0
  garvbsig3 init      0
  garvbsig4 init      0

instr 1
  idb       =  ampdb(p4)
  isc       =  idb*.333
  k1        line      40,p3,800 
  k2        line      440,p3,220
  k3        linen     isc,p6,p3,p7
  k4        line      800,p3,40 
  k5        line      220,p3,440  
  k6        linen     isc,p6,p3,p7
  a5        oscil     k3,p8,p5
  a6        oscil     k3,p8*.999,p5
  a7        oscil     k3,p8*1.001,p5
  a1        =  a5+a6+a7  
  a8        oscil     k6,p9,p5
  a9        oscil     k6,p9*.999,p5
  a10       oscil     k6,p9*1.001,p5
  a11       =  a8+a9+a10
  a2        butterbp  a1,k1,40
  a3        butterbp  a2,k5,k2*.8
  a4        balance   a3,a1
  a12       butterbp  a11,k4,40
  a13       butterbp  a12,k2,k5*.8
  a14       balance   a13,a11
            outs      a4,a14
endin

instr 2
  idb1      =  ampdb(p9)
  idb2      =  ampdb(p11)
  irvgain1  =  p12
  irvgain2  =  p13
  k1        oscil     idb1,1/p3,p8
  k2        oscil     idb2,1/p3,p10
  k3        linen     3,.9,p3,.3
  k4        randi     k3,10
  k5        randi     k3,15
  k6        linen     p20,p14,p3,p16
  k7        linen     p21,p15,p3,p17
  k8        oscil     k6,p18,1
  k9        oscil     k7,p19,1
  a1        oscil     k1,p4+k4+k8,p5
  a2        oscil     k2,p6+k5+k9,p7
            outs      a1,a2
  garvbsig1 =  garvbsig1+a1*irvgain1
  garvbsig2 =  garvbsig2+a2*irvgain2
endin
instr 3
  ifunc     =  p4
  imeth     =  p5
  iamp      =  ampdb(p6)
  iseed     =  p7
  ilforate  =  p8
  ita       =  23
  itb       =  24
  itc       =  25
  itd       =  26

if (imeth==1) kgoto randoma
if (imeth==2) kgoto randomb
if (imeth==3) kgoto randomc
if (imeth==4) kgoto randomd

randoma:
  kindex    randh     int(10), ilforate, iseed
  kpitch    table     abs(kindex), ita
            kgoto     next

randomb:
  kindex    randh     int(18), ilforate, iseed
  kpitch    table     abs(kindex), itb
            kgoto     next

randomc:
  kindex    randh     int(9), ilforate, iseed
  kpitch    table     abs(kindex), itc
            kgoto     next

randomd:
  kindex    randh     int(6), ilforate, iseed
  kpitch    table     abs(kindex), itd
            kgoto     next

next:
if p6<50 kgoto ra
if p6>49 kgoto rb
             
ra:
  k1        linen     iamp,.25*p3,p3,.2*p3
  k2        linen     iamp,.2*p3,p3,.25*p3
  k5        line      1500,p3,50
  k6        line      1000,p3,50
  a1        oscil     k1,kpitch,ifunc
  a2        oscil     k2,kpitch*1.002,ifunc
  a5        butterbp  a1,k5,30
  a6        butterbp  a2,k6,25
  a7        balance   a5,a1
  a8        balance   a6,a2
            outs      a7,a8
  garvbsig3 =  garvbsig3+(a1+a2)*4

rb:
  k3        linen     iamp,.25*p3,p3,.2*p3
  k4        linen     iamp,.2*p3,p3,.25*p3
  k7        line      1500,p3,50
  k8        line      1500,p3,50
  a3        oscil     k3,kpitch,ifunc
  a4        oscil     k4,kpitch*.998,ifunc
  a9        butterbp  a3,k7,25
  a10       butterbp  a4,k8,25
  a11       balance   a9,a3
  a12       balance   a10,a4
            outs      a11,a12
  garvbsig4 =  garvbsig4+(a3+a4)*2                               
endin
instr 96
  irvtime   =  p4
  a1        reverb2   garvbsig3,irvtime,.9
  k1        line      50,p3,2500
  a13       butterbr  a1,k1,10
  a14       balance   a13,a1 
            outs      a14,(a14)*0
  garvbsig3 =  0
endin
instr 97
  irvtime   =  p4
  a1        reverb2   garvbsig4,irvtime,.1 
  k1        line      2500,p3,100
  a13       butterbr  a1,k1,50
  a14       balance   a13,a1 
            outs      (a14)*0,a14
  garvbsig4 =  0
endin

instr 98
  irvtime   =  p4
  a1        reverb2   garvbsig1,irvtime,.5
            outs      a1,(a1)*0
  garvbsig1 =  0
endin
instr 99
  irvtime   =  p4
  a1        reverb2   garvbsig2,irvtime,.25
            outs      (a1)*0,a1
  garvbsig2 =  0
endin



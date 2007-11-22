
  sr        =  44100
  kr        =  2205
  ksmps     =  20
  nchnls    =  2 
      
  gavr      init      0
  gavl      init      0
  garvbsig1 init      0  
  garvbsig2 init      0
  gallp     init      0
  gallp2    init      0
      
      
instr   1
  icpsnew   =  p5 
  icpsold   =  p6 
  ioldsr    =  p7
  incr      =  ioldsr/sr * icpsnew/icpsold
  isc1      =  p8
  isc       =  p9
  irgl      =  p10
  irgr      =  p11
  kphase    init      0                           ;initialize phase
  aphase    interp    kphase                      ;convert to arate
  asig      tablei    aphase,p4                   ;resample the sound
  kphase    =  kphase+incr*ksmps                  ;update for next k
  k1        oscil     isc,1/p3,p13
  ar        =  (asig*k1)*25000
  kphase1   init      0                           ;initialize phase
  aphase1   interp    kphase1                     ;convert to arate
  asig1     tablei    aphase1,p4                  ;resample the sound
  kphase1   =  kphase1+incr*ksmps                 ;update for next k
  k2        oscil     isc1,1/p3,p12
  al        =  (asig1*k2)*30000
            outs      al,ar
  gavr      =  (ar*irgr)+gavr
  gavl      =  (al*irgl)+gavl
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
  k8        oscil     k6,p18,5
  k9        oscil     k7,p19,5
  a1        oscil     k1,p4+k4+k8,p5
  a2        oscil     k2,p6+k5+k9,p7
            outs      a1,a2
  garvbsig1 =  garvbsig1+a1*irvgain1
  garvbsig2 =  garvbsig2+a2*irvgain2
endin  
      
instr 3
  idb       =  ampdb(p4)
  isc       =  idb*.333
  k1        line      100,p3,1000 
  k2        line      1000,p3,100
  k3        linen     isc,p6,p3,p7
  k4        line      1000,p3,50 
  k5        line      50,p3,1000  
  k6        linen     isc,p6,p3,p7
  a5        oscil     k3,p8,p5
  a6        oscil     k3,p8*.999,p5
  a7        oscil     k3,p8*1.001,p5
  a1        =  a5+a6+a7  
  a8        oscil     k6,p9,p5
  a9        oscil     k6,p9*.999,p5
  a10       oscil     k6,p9*1.001,p5
  a11       =  a8+a9+a10
  a2        butterbp  a1,k1,50
  a3        butterbr  a2,k4,25
  a4        balance   a3,a1
  a12       butterbp  a11,k2,50
  a13       butterbr  a12,k5,25
  a14       balance   a13,a11
            outs      a4,a14
endin

instr 4
  ia        =  p8*.0001
  ib        =  p9*.1
  idb       =  ampdb(p6)
  idb1      =  ampdb(p7)
  k1        line      ia,p3,ib 
  k2        oscil     k1,p4,p10 
  k3        line      ia,p3*.9,ib
  k4        oscil     k3,p5,p11
  a1        oscil     idb,k2+.15,1,p14
  a2        oscil     idb1,k4+.15,1,p15
            outs      a1,a2 
  gallp     =  a1*p12 
  gallp2    =  a2*p13 
endin
     
      
instr 5
  idb       =  ampdb(p4)
  isc       =  idb*.333
  k1        line      100,p3,1000 
  k2        line      1000,p3,100
  k3        linen     isc,p6,p3,p7
  k4        line      1000,p3,50 
  k5        line      50,p3,1000  
  k6        linen     isc,p6,p3,p7
  a5        oscil     k3,p8,p5
  a6        oscil     k3,p8*.999,p5
  a7        oscil     k3,p8*1.001,p5
  a1        =  a5+a6+a7  
  a8        oscil     k6,p9,p5
  a9        oscil     k6,p9*.999,p5
  a10       oscil     k6,p9*1.001,p5
  a11       =  a8+a9+a10
  a2        butterbp  a1,k1,50
  a3        butterbr  a2,k4,25
  a4        balance   a3,a1
  a12       butterbp  a11,k2,50
  a13       butterbr  a12,k5,25
  a14       balance   a13,a11
            outs      a4,a14
  gallp     =  a4*p10
  gallp2    =  a14*p10
endin
     
     
instr 94
  ihz1      =  1/6
  ihz2      =  1/9.7
  ihz3      =  1/13.1
  ihz4      =  1/14.73
  ihz5      =  1/249
  ihz6      =  1/418
  asig      =  gallp   
  alp1      alpass    asig,6,ihz1
  alp2      alpass    alp1,(6*.909),ihz2
  alp3      alpass    alp2,(6*.877),ihz3
  alp4      alpass    alp3,(6*.768),ihz4
  alp5      alpass    alp4,(6*.643),ihz5
  alp6      alpass    alp5,(6*.531),ihz6
  aenv      linen     alp6,.003,p3,.4
            outs      aenv,aenv*0
  gallp     =  0
endin 
instr 95    
  ihz1      =  1/12
  ihz2      =  1/49.7
  ihz3      =  1/143.1
  ihz4      =  1/274.73
  ihz5      =  1/1149
  ihz6      =  1/2418
  asig      =  gallp2  
  alp1      alpass    asig,1.6,ihz1
  alp2      alpass    alp1,(1.6*.909),ihz2
  alp3      alpass    alp2,(1.6*.877),ihz3
  alp4      alpass    alp3,(1.6*.768),ihz4
  alp5      alpass    alp4,(1.6*.643),ihz5
  alp6      alpass    alp5,(1.6*.531),ihz6
  aenv      linen     alp6,.003,p3,.2
            outs      aenv*0,aenv 
  gallp2    =  0
endin 
      
      
instr 96
  irvtime   =  p4
  a1        reverb2   garvbsig1,irvtime,.5
            outs      a1,(a1)*0
  garvbsig1 =  0
endin

instr 97
  irvtime   =  p4
  a1        reverb2   garvbsig2,irvtime,.25
            outs      (a1)*0,a1
  garvbsig2 =  0
endin
      
instr 98
  idur      =  p3
  irvt      =  p4
  a1        reverb2   gavl,irvt,.45
            outs      a1,a1*0
  gavl      =  0
endin
      
instr 99
  idur      =  p3
  irvt      =  p4
  a1        reverb2   gavr,irvt,1
            outs      a1*0,a1 
  gavr      =  0
endin

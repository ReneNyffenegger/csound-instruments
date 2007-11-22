
; Shamil Gainetdinov
;was born in 1973 in Sterlitamak (Bashkiria, Russia). In 1990 he has graduated the Physical-
;Mathematical School at Novosibirsk State University. In 1995 he has graduated the Art College 
;in Tobolsk as a flutist. Since 1995 he has been studying a sound producing and musical theory 
;at the Ural State Conservatory and CSound class of Vladimir Volkov at the Electro-Acoustic 
;Music Studio.
;
; This piece is his own first experience of creation of music by means of CSound solely.
;There are no both exact reproduction of some concrete national style and a purpose to copy 
;a "live" timbres. This better a music picture expressing a mood of tender waiting for
;a signifikant event. Here were used FOF and pluck generatores (and also their modifications) 
;in combination with additive synthesis. FOF generatore was used both for synthesis of guttural 
;singing timbre and horn-like sound, also for the creation of some other sounds. 
;
;
;================= Shamil Gainetdinov ========================================================
;=================== HE WILL COME ============================================================
;orchestra

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  2

instr 1    ;gong's part 1
  idur      =  p3
  ifr       =  p5*.7501
  iamp      =  p4*.9
if ifr>400 goto lab2
if ifr<=400 goto lab1
lab1:
  kb        line      .6,idur,.4 
            goto      contin
lab2:
  kb        line      .4,idur,.6 
            goto      contin
contin:
  a2        oscil     iamp , 1/idur, 51
  a1        oscili    a2, ifr , 11

  kbw       linseg    200,idur*.1,40,idur*.9,2
  kflt      linseg    400,idur*.05,250,idur*.25,220,idur*.7,ifr
  ar        reson     a1,kflt,kbw,1.3,0
  af        balance   ar,a1

            outs      af*kb,af*(1-kb)
endin

instr 13  ;gong's part 2

  p2        =  p2+.07

  idur1     =  p3*.9
  idur2     =  p3*.8
  idur3     =  p3*.65
  idur4     =  p3*.55
  idur5     =  p3*.325
  idur6     =  p3*.35
  idur7     =  p3*.25
  idur8     =  p3*.2
  idur9     =  p3*.15
  idur10    =  p3*.1
  idur11    =  p3*.075

  iamp1     =  p4
  iamp2     =  p4*0.87
  iamp3     =  p4*1.35
  iamp4     =  p4*1.80
  iamp5     =  p4*1.67
  iamp6     =  p4*1.1
  iamp7     =  p4*.46
  iamp8     =  p4*.73
  iamp9     =  p4*.53
  iamp10    =  p4*.5
  iamp11    =  p4*.5

  ifq1      =  180
  ifq2      =  205.5
  ifq3      =  290.25
  ifq4      =  450.75
  ifq5      =  254.52
  ifq6      =  498.75
  ifq7      =  607.5
  ifq8      =  675.5
  ifq9      =  628
  ifq10     =  749.3
  ifq11     =  781
 
  
  k1        expon     iamp1, idur1, .0001
  a1        oscili    k1, ifq1, 11
  
  
  k2        expon     iamp2, idur2, .0001
  a2        oscili    k2, ifq2, 11
    
  k3        expon     iamp3, idur3, .0001
  a3        oscili    k3, ifq3, 11
   
  k4        expon     iamp4, idur4, .0001
  a4        oscili    k4, ifq4, 11
  
  k5        expon     iamp5, idur5, .0001
  a5        oscili    k5, ifq5, 11
  
  k6        expon     iamp6, idur6, .0001
  a6        oscili    k6, ifq6, 11
 
  k7        expon     iamp7, idur7, .0001
  a7        oscili    k7, ifq7, 11
  
  k8        expon     iamp8, idur8, .0001
  a8        oscili    k8, ifq8, 11
  
  k9        expon     iamp9, idur9, .0001
  a9        oscili    k9, ifq9, 11
 
  k10       expon     iamp10, idur10, .001
  a10       oscili    k10, ifq10, 11
  
  k11       expon     iamp11, idur11, .001
  a11       oscili    k11, ifq11, 11
  
  asrc      =  a1+a2+a3+a4+a5+a6+a7+a8+a9+a10+a11
  kbw       linseg    200,idur1*.1,40,idur1*.9,2
  kflt      linseg    400,idur1*.05,250,idur1*.25,220,idur1*.7,ifq1
  ar        reson     asrc,kflt,kbw,1.3,0
  af        balance   ar,asrc
  kb1       linseg    .5,idur1*.1,.8,idur1*.9,.5
  kb2       linseg    .5,idur1*.5,.2,idur1*.5,.6 
            outs      af*kb1,af*kb2
endin

instr 11;   crescendo of the gong like sound
  idur      =  p3
  ifq1      =  p5*.75
  iamp      =  p4*1.2
  ibal      =  p6                                 ;balance
  kbal      linseg    ibal,idur*.9,1-ibal,idur*.1,ibal
if p2<50 goto lab1
if p2>50 goto lab2
lab1:
  kamp      linseg    0,idur*.85,1.8,idur*.05,2.1,idur*.06,1.8,idur*.04,0
            goto      next
lab2:
  kamp      linseg    0,idur*.65,1.7,idur*.35,0
            goto      next
next:
if ifq1>300 && ifq1<600 goto lab4 
if ifq1<300 && ifq1>600 goto lab3
lab3: 
  kmod      linseg    0,idur*.96,3,idur*.04,0
            goto      contin
lab4: 
  kmod      linseg    0,idur*.96,6,idur*.04,0
            goto      contin
contin: 
  amod      oscil     kmod,5,1
  af        =  ifq1+amod/2
  a1        oscili    iamp*kamp, af,11

  kbw       linseg    2,idur*.7,40,idur*.3,200
  kflt      linseg    400,idur*.05,250,idur*.25,220,idur*.7,ifq1
  ar        reson     a1,kflt,kbw,1.3,0
  af        balance   ar,a1

            outs      af*kbal,af*(1-kbal)
endin

instr 12  ;gong spectrum(whithout attack)
  idur      =  p3
  ifq1      =  p5*.75
  iamp      =  p4
  ibal      =  p6
  kamp      linseg    0,idur*.4,.9,idur*.6,0
  a1        oscili    iamp, ifq1, 11
            outs      a1*kamp*ibal,a1*kamp*(1-ibal)
endin

instr 2;glock & bass string 
  idur      =  p3
  iamp      =  ampdb(p4)
if=cpspch(p5)
  ib        =  p6
if p5=6.02 goto lab1
if p5>7.02 goto contin
lab1:
  iamp      =  iamp*1.73 
            goto      contin
contin: 
  kamp1     linseg    0,.0001,iamp,idur-.0001,0
  a03       pluck     kamp1,if,4096,7,1
            outs      a03*ib,a03*(1-ib)
endin


instr 21;  bow-string
  idur      =  p3
  iamp      =  ampdb(p4)
if=cpspch(p5)
  kb        oscil     .9,1.5/idur,10 
  kf        randi     if/6,.2
  kamp      linseg    0,idur*.0001,iamp,idur*.98,0,idur*.0199,0
  a0        pluck     kamp,kf,4096/4,7,1
  kw        expon     200, idur, 10
  a1        reson     a0,500,kw,1
  a2        balance   a0,a1
            outs      a2*kb,a2*(1-kb)
endin

instr 32; recitativo 1
if=cpspch(p5)
  idur      =  p3
  iamp      =  ampdb(p4)
  ib        =  p6
  kamp      linseg    1,16,1,7,0
  k01       expseg    1,.23,.12,.27,1.2,3.5,1,.25,.12,.25,1,.5,1.1,.25,.12,.25,1,2.5,.95,.25,.12,.25,1,14.5,1.02
  k02       expseg    1.25,.27,.12,.23,1,3.7,1.3,.25,.12,.25,1.1,3,1,.24,.14,.26,1.01,3.4,.85,11.4,1
;     xamp       xfund  xform     koct    kband  kris  kdur  kdec  iolaps  ifna ifnb itotdur 
  a2        fof       iamp,     if,  if*k01*2    ,0.3,    1,   .003,  .02, .007,  if/5,   1,   2,   idur 
  a3        fof       iamp,     if,  if*k02*2    ,0.3,    2,   .005,  .02, .007,  if/5,   3,   2,   idur
  a1        =  (a2+a3)*kamp
  a01       reverb2   a1,1.7,.65
  a0        =  a1+a01*.3                  
            outs      a0*ib,a0*(1-ib)
endin

instr 4; percussion
  idur      =  p3
  iamp      =  ampdb(p4)
if=cpspch(p5)
  ib        =  p6
  kb        line      ib,idur,1-ib
  kbp       expseg    500,idur*.4,1.01,idur*.6,4
  an        rand      10000                       ; creation a sound from white noise by means butterbp and additive synthesis
  k01       expseg    .001,idur*.3,.5,idur*.7,.005
  k00       linseg    0,idur*.4,.6,idur*.6,0
  a04       butterbp  an,if*.5,kbp  
  a05       butterbp  an,if*1,kbp
  a051      oscil     iamp,if*1.2,4               ;(gen 11)
  a06       butterbp  an,if*2.4,kbp
  a061      oscil     iamp,if*2.5,4
  asig      =  a04+a05+a051/3.5+a06/4.6+a061/4.7
  asig1     =  a06/4+a061/4
            outs      (asig+asig1)*k00*kb,(asig+asig1)*k00*(1-kb)
endin

instr 41 ;another percussion (alike methode)
  idur      =  p3
  iamp      =  ampdb(p4)
if=cpspch(p5)
  ib        =  p6
  kb1       line      ib,idur,1-ib
  kb2       linseg    ib,idur*.4,1-ib,idur*.6,1-ib
  kbp       expseg    10,idur*.8,1.01,idur*.2,4
  an        rand      10000
  kamp      linseg    0,idur*.8,1,idur*.2,0
  a04       butterbp  an,if*.5,kbp
  a05       butterbp  an,if*1,kbp
  a051      oscil     iamp,if*1.2,4
  a06       butterbp  an,if*2.4,kbp
  a061      oscil     iamp,if*2.5,4
  asig      =  a04+a05+a051/3.5+a06/4.6+a061/4.7
  asig1     =  a06/4+a061/4
            outs      (asig*kb1+asig1*kb2)*kamp,(asig*(1-kb1)+asig1*(1-kb2))*kamp
endin

instr 31 ;strange kind of sitar
if=cpspch(p5)
  idur      =  p3
  iamp      =  ampdb(p4)
  ib        =  p6
if if>6.02 goto lab1
if if<6.02 goto lab2
lab1:
  kamp      linseg    0,5,1,17,1,1,0
  k01       expseg    9.25,5,8.2,3,8.5,2,6.75,3,7.9,10,5.25
  k02       expseg    6,6,7.75,3,6.9,3,8,11,6.25
            goto      contin
lab2:  
  kamp      linseg    0,5,1,5,1,12,1.6,3,0
  k01       expseg    9.25,5,8.2,3,8.5,2,6.75,3,7.9,10,5.25
  k02       expseg    6,6,7.75,3,6.9,3,8,13,6.25
            goto      contin
contin:
  kb        linseg    ib,idur*.1,1-ib,idur*.1,.5,idur*.5,1-ib,idur*.3,ib
  
 ;     xamp     xfund  xform     koct    kband  kris   kdur  kdec  iolaps  ifna ifnb itotdur 
  a2        fof       iamp,     if,  if*k01    ,0.3,     1,     .003,  .02, .007,  if/5,   1,    2,   idur 
  a3        fof       iamp,     if,  if*k02    ,0.3,     1,     .005,  .02, .007,  if/5,   3,    2,   idur
  a1        =  a2+a3
  a01       reverb2   a1,3.1,.65
  a0        =  (a1+a01*.4)*kamp
  a02       butterhp  a0,if*k01                   ; this part of sound moves on panorama
  a03       butterlp  a0,if*k01+20                ;this part remain the same 
            display   k01,idur
            display   k02,idur
            outs      a03*ib+a02*kb,a03*(1-ib)+a02*(1-kb)
endin

instr 33; recitativo 2
if=cpspch(p5)
  idur      =  p3
  iamp      =  ampdb(p4)
  ib        =  p6
  kf        expseg    1,idur*.8,1,idur*.2,.98
  kamp      linseg    0,.001,1,21,1,9.999,1,7,0
  k01       expseg    1,.23,.1,.27,1,4.5,1.1,.23,.1,.27,1.2,4.5,1,.23,.1,.27,1,20.5,1.3
  k02       expseg    1.25,1,1,.23,.11,.27,1.25,4,1.25,.23,.12,.27,1,4,1.25,.27,.12,.23,1.25,20..5,1
;     xamp       xfund  xform     koct    kband  kris  kdur  kdec  iolaps  ifna ifnb itotdur 
  a2        fof       iamp,  kf*if,  if*k01*2    ,0.3,    1,   .003,  .02, .007,  if/5,   1,   2,   idur 
  a3        fof       iamp,     if,  if*k02*2    ,0.3,    2,   .005,  .02, .007,  if/5,   3,   2,   idur
  a1        =  (a2+a3)*kamp
  a01       reverb2   a1,1.4,.65
  a0        =  a1+a01*.25              
            outs      a0*ib,a0*(1-ib)
endin


instr 3; vox 1
if=cpspch(p5)
  idur      =  p3
  iamp      =  ampdb(p4)
  ib        =  p6
  kb        linseg    ib,idur*.1,.95,idur*.1,.1,idur*.5,.5,idur*.3,ib
  kamp      linseg    0,idur*.2,1,idur*.6,1,idur*.2,0
  kmu       expseg    1,26,1,4,4.5,1,3,1,3.5,1,1
  k01       expseg    3,2,5.1,3,.5,4,.75,2,.5,2,1.2,1,1,3,.5,1,.75,4,1,4,1
  k02       expseg    1,1,1.3,1,1,1,.5,1,1,1,1.3,1,1,1,1.3,1,1,1,.5,2,1,1,1.2,2,1,3,.75,2,.5,1,1,2,.5,4,.75
                                                                  
;     xamp       xfund  xform       koct    kband  kris  kdur  kdec  iolaps  ifna ifnb itotdur 
  a2        fof       iamp*kamp, if,   if*k01*kmu ,0.3,    1,     .003,  .02, .007,  if/5,   1,   2,    idur 
  a3        fof       iamp*kamp, if/2, if*k02     ,0.3,    2,     .005,  .02, .007,  if/5,   3,   2,    idur
  a1        =  a2+a3
  a01       reverb2   a1,3.4,.65
  a0        =  a1+a01*.25
  a02       butterhp  a0,if*k01                   ; this part moves on panorama
  a03       butterlp  a0,if*k01+15                ; this part remain the same
            display   k01,idur
            display   k02,idur
            outs      a03*ib+a02*kb,a03*(1-ib)+a02*(1-kb)
endin

instr 35 ;recitativo 3
if=cpspch(p5)
  idur      =  p3
  iamp      =  ampdb(p4)
  ib        =  p6
  kamp      linseg    1.1,7,1,2,0
  k01       expseg    1,.25,1.2,.25,1,.25,.12,.25,1.2,1,.5,.25,.12,.25,1,6.5,1
  k02       expseg    1.25,1,1.2,.23,.12,.27,1.2,3,.75,.23,.12,.27,1.25,4,1
;     xamp       xfund  xform     koct    kband  kris  kdur  kdec  iolaps  ifna ifnb itotdur 
  a2        fof       iamp,     if,  if*k01*2    ,0.3,    1,   .003,  .02, .007,  if/5,   1,   2,   idur 
  a3        fof       iamp,     if,  if*k02*2    ,0.3,    2,   .005,  .02, .007,  if/5,   3,   2,   idur
  a1        =  (a2+a3)*kamp
  a01       reverb2   a1,1.4,.65
  a0        =  a1+a01*.25
            display   k01,idur
            display   k02,idur
            outs      a0*ib,a0*(1-ib)
endin

instr 36; vox(Dei)
  idur      =  p3
  iamp      =  ampdb(p4)
if=cpspch(p5)
  ib        =  p6
  kamp      expseg    .1,idur*.1,1,idur*.62,1,idur*.28,.002
  kmod      expseg    .001,3.4,.001,1.25,.2,1.25,.005
  kf1       oscil     kmod,8,1
if p7=0 goto lab1
if p7=1 goto lab2
lab1:
              ;(horn1)
  k1        linseg    1,3.4,3,3,3,.39,4,.4,3,.39,4,.4,3,.15,3.5,.15,3,.15,2.5,.15,3,8.5,2.8
 ;(control of form.freqency) 
;     xamp       xfund  xform     koct    kband  kris  kdur  kdec  iolaps  ifna ifnb itotdur iphs?  ifmode?
  a2        fof       iamp*kamp, if, if*k1+kf1     ,0.3,    1,   .003,  .02, .007,  if/5,   1,   2,   idur ;, 0,    3
  a3        fof       iamp*kamp, if, if*k1+kf1     ,0.3,    2,   .005,  .02, .007,  if/5,   3,   2,   idur ;,  0,    3
  a1        =  a2+a3
  alp       butterlp  a1,if*k1+kf1
  a01       reverb2   a1,3.5,.65
  a0        =  a1+a01*.3+alp*.5
            goto      lab4
lab2:
          ;(horn2)
  k2        linseg    1,3.4,3,3,3,.39,4,.4,3,.39,4,.4,3,.25,3.5,.15,3,.15,3.5,.15,3,.15,2.5,.15,3,8.5,2.8
 
;     xamp       xfund  xform     koct    kband  kris  kdur  kdec  iolaps  ifna ifnb itotdur iphs?  ifmode?
  a2        fof       iamp*kamp, if, if*k2+kf1     ,0.3,    1,   .003,  .02, .007,  if/5,   1,   2,   idur ;, 0,    3
  a3        fof       iamp*kamp, if, if*k2+kf1     ,0.3,    2,   .005,  .02, .007,  if/5,   3,   2,   idur ;,  0,    3
  a1        =  a2+a3
  alp       butterlp  a1,100
  a02       reverb2   a1,4,.85
  a0        =  a1+a02*.4+alp*.5
            goto      lab4
lab4:
            outs      a0*ib,a0*(1-ib)
            goto      contin
contin:
endin

instr 37; recitativo 4
if=cpspch(p5)
  idur      =  p3
  iamp      =  ampdb(p4)
  ib        =  p6
if if<6.04 goto lab2
if if>7.00 goto lab1
lab1:
  kf        linseg    1,17,1,1,.75,13,.75
            goto      contin1
lab2:
  kf        line      1,idur,1
            goto      contin1
contin1:
  kamp      linseg    1,22,1,1,.6,5,.05, 3, 0
  k01       expseg    1,.23,.12,.27,1.2,6.5,1,.25,.12,.25,1,3.5,1.1,.25,.12,.25,1,5.5,.95,.25,.12,.25,1,14.5,1
  k02       expseg    1.25,.27,.12,.23,1,6.7,1.3,.25,.12,.25,1.1,6,1,.24,.14,.26,1.01,6.4,.85,7,1,3.4,1
;     xamp       xfund  xform     koct    kband  kris  kdur  kdec  iolaps  ifna ifnb itotdur 
  a2        fof       iamp,  kf*if,  if*k01*2    ,0.3,    1,   .003,  .02, .007,  if/5,   1,   2,   idur 
  a3        fof       iamp,  kf*if,  if*k02*2    ,0.3,    2,   .005,  .02, .007,  if/5,   3,   2,   idur
  a1        =  (a2+a3)*kamp
  a01       reverb2   a1,1.4,.65
  a0        =  a1+a01*.2 
            outs      a0*ib,a0*(1-ib)
endin
 
instr 38; last word
if=cpspch(p5)
  idur      =  p3
  iamp      =  ampdb(p4)
  ib        =  p6
  kf        linseg    1,1,1,9,.75
  kamp      linseg    1,9.5,1,.5,0
  k01       expseg    1,.23,.12,.27,1.2,9.5,1
  k02       expseg    1.25,.27,.12,.23,1,9.5,1.25
;     xamp       xfund  xform     koct    kband  kris  kdur  kdec  iolaps  ifna ifnb itotdur 
  a2        fof       iamp,  kf*if,  if*k01*2    ,0.3,    1,   .003,  .02, .007,  if/5,   1,   2,   idur 
  a3        fof       iamp,  kf*if,  if*k02*2    ,0.3,    2,   .005,  .02, .007,  if/5,   3,   2,   idur
  a1        =  (a2+a3)*kamp
  a01       reverb2   a1,1.4,.65
  a0        =  a1+a01*.2                  
            outs      a0*ib,a0*(1-ib)
endin

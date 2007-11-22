;  --- SHAMANTRA ---            Short version
;====================== 

; by Vladimir Volkov


  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2



;;----------------------------------------                       1

instr 1                     ;; Timp_2

  idur      =  p3
  iamp      =  ampdb(p4)/2
  ifq1      =  cpspch(p5-1)*5
  if1       =  1
  ifq2      =  cpspch(p5-1)*7
  if2       =  1
  ifmindex  =  p6        
  imax      =  (.5*p4/idur)/ifmindex

  i1f1      =  ifq1*(p4/40)
  i1f2      =  ifq1*(60/p4)
  ifat1     =  1/p4                               ;idur*.4/p4
  ifat2     =  2/p4                               ;idur*.8/p4
  idec1     =  4/p4                               ;idur/p4
  idec2     =  idur-ifat1-ifat2-idec1

  i2f1      =  ifq2*(p4/40)
  i2f2      =  ifq2*(60/p4)

  iat       =  .1/p4                              ;idur/p4
  irel1     =  p4/4000
  irel2     =  idur-iat-irel1                     ;idur/p4
   ;aenv  oscil  iamp, 1/idur, 51
  kenv      linseg    0,iat,iamp,irel1,iamp*.4,irel2,0

  kf2       expseg    i1f1+.0001,ifat1,ifq2,ifat2,i1f2,idec1,ifq2, idec2,ifq2*1.1
  adyn      oscil     kf2*imax, 1/idur, 52
  amod      oscil     adyn, ifq2, if2
  kf1       expseg    i2f1+.0001,ifat1,ifq1,ifat2,i2f2,idec1,ifq1, idec2,ifq1*1.1
  a1        oscil     kenv, kf1 + amod, if1

  i1rf1     =  ifq1*(40/p4)+.0001
  i1rf2     =  ifq1*(p4/60)+.0001
  i1rf3     =  ifq1*(70/p4)
  i2rf1     =  ifq2*(40/p4)
  i2rf2     =  ifq2*(p4/60)
  i2rf3     =  ifq2*(60/p4)
  irfat1    =  p4/2000                            ;idur*(p4/8000)
  irfat2    =  p4/1000                            ;idur*(p4/4000)
  irdec1    =  p4/500                             ;idur*(p4/2000)
  irdec2    =  idur-irfat1-irfat2-irdec1

  kafq1     expseg    i1rf1,irfat1,ifq1,irfat2,i1rf2,irdec1,i1rf3,irdec2,ifq1*1.1
  kafq2     expseg    i2rf1,irfat1,ifq2,irfat2,i2rf2,irdec1,i2rf3,irdec2,ifq2*1.2
  kfam      expseg    1, irfat1*2, p4/4, irfat2*4, p4/8, idur-irfat1*2-irfat2*4, p4/32*idur
  kfen      expseg    1, irfat1*2, p4/8, irfat2*4, p4/4, idur-irfat1*2-irfat2*4, p4/2
  kfq       oscil     kfam,kfen, 1
;;kbw  expon 100, idur, 10
  kbw       expseg    160/p4*idur, irfat1*idur/2, p4*1.2, irfat2*idur*2, p4/2, idur-irfat1*idur/2-irfat2*idur*2, p4/8/idur
  krenv     linseg    0,iat,1,irel1,.6,irel2*.99,0,irel2*.01,0
  aflt1     reson     a1*krenv,kafq1+kfq, kbw/1, 2
  aflt2     reson     a1*krenv,kafq2+kfq, kbw/1, 2
  iout1     =  p4/90
  iout2     =  70/p4

            outs      aflt1*iout1, aflt2*iout2
endin


;;----------------------------------------                        2
;;----------------------------------------  
               
instr 2                       ;; Timp_4

  idur      =  p3
  iamp      =  ampdb(p4)/2
  ifq1      =  cpspch(p5-1)*5
  if1       =  1
  ifq2      =  cpspch(p5-1)*7
  if2       =  1
  ifmindex  =  p6        
  imax      =  (idur*p4/20)/ifmindex              ;(p4/idur)/ifmindex

  i1f1      =  (ifq1*(p4/40))+.0001
  i1f2      =  (ifq1*(60/p4))+.0001
  ifat1     =  1/p4
  ifat2     =  2/p4
  idec1     =  4/p4
  idec2     =  idur-ifat1-ifat2-idec1

  i2f1      =  ifq2*(p4/40)
  i2f2      =  ifq2*(60/p4)

  iat       =  .1/p4                              ;.1/p4;idur/p4
  irel1     =  p4/4000                            ;p4/4000
  irel2     =  idur-iat-irel1
  kenv      oscil     iamp, 1/idur, 51

  kf2       expseg    i1f1+.0001,ifat1,ifq2,ifat2,i1f2,idec1,ifq2, idec2,ifq2*1.1
  adyn      oscil     kf2*imax, 1/idur, 52
  amod      oscil     adyn, ifq2, if2
  kf1       expseg    i2f1+.0001,ifat1,ifq1,ifat2,i2f2,idec1,ifq1, idec2,ifq1*1.1
  a1        oscil     kenv, kf1+amod, if1

  kf4       expseg    i1f1*2+.0001,ifat1,ifq2*2,ifat2,i1f2*2,idec1,ifq2*2, idec2,ifq2*1.9
  adyn      oscil     2*kf2*imax, 1/idur, 52
  amod      oscil     adyn, ifq2*2, if2
  kf3       expseg    i2f1*2+.0001,ifat1,ifq1*2,ifat2,i2f2*2,idec1,ifq1*2, idec2,ifq1*1.9
  a2        oscil     kenv, 2*kf1 + amod, if1

  i1rf1     =  ifq1*(40/p4)                       ;;ifq1*(40/p4)
  i1rf2     =  ifq1*(p4/60)                       ;;ifq1*(p4/60)
  i1rf3     =  ifq1*(70/p4)                       ;;ifq1*(70/p4)
  i2rf1     =  ifq2*(40/p4)                       ;;ifq2*(40/p4)
  i2rf2     =  ifq2*(p4/60)                       ;;ifq2*(p4/60)
  i2rf3     =  ifq2*(60/p4)                       ;;ifq2*(60/p4)
  irfat1    =  p4/1000                            ;idur*(p4/8000)
  irfat2    =  p4/500                             ;idur*(p4/4000)
  irdec1    =  p4/250                             ;idur*(p4/2000)
  irdec2    =  idur-irfat1-irfat2-irdec1

  kafq1     expseg    i1rf1*2,irfat1,ifq1*2,irfat2,i1rf2*2,irdec1,i1rf3*2,irdec2,ifq1*2.5
  kafq2     expseg    i2rf1*2,irfat1,ifq2*2,irfat2,i2rf2*2,irdec1,i2rf3*2,irdec2,ifq2*1.5
  kfam      expseg    1, irfat1*2, p4/4, irfat2*4, p4/8, idur-irfat1*2-irfat2*4, idur
  kfen      expseg    1, irfat1*2, p4/2, irfat2*4, p4/4, idur-irfat1*2-irfat2*4, p4/16
  klfq      oscil     kfam,kfen, 1
  kbw       linseg    p4/20, 1/p4, p4*1.2, irfat2*20, p4/2, idur-1/p4-irfat2*20, p4/8/idur

  aflt1     reson     a1,kafq1*2+klfq, kbw*(p4/20), 2 ;kbw/4
  aflt2     reson     a2,kafq2*2+klfq, kbw*(p4/40), 2 ;kbw/8

  iout1     =  p4/90
  iout2     =  70/p4
  aleft     =  (aflt1*iout1 + aflt2*iout2)/3
  aright    =  (aflt2*iout1 + aflt1*iout2)/3

            outs      aleft, aright
endin


;;----------------------------------------                        3
;;----------------------------------------
;;----------------------------------------

instr 3                ;; Timp_5

  idur      =  p3
  iamp      =  ampdb(p4)/2
  ifq1      =  cpspch(p5-1)*5
  if1       =  1
  ifq2      =  cpspch(p5-1)*7
  if2       =  1
  ifmindex  =  p6        
  imax      =  (idur*p4/20)/ifmindex

  i1f1      =  ifq1*(p4/40)
  i1f2      =  ifq1*(60/p4)
  ifat1     =  1/p4
  ifat2     =  2/p4
  idec1     =  4/p4
  idec2     =  idur-ifat1-ifat2-idec1

  i2f1      =  ifq2*(p4/40)
  i2f2      =  ifq2*(60/p4)

  iat       =  .1/p4  
  irel1     =  p4/8000        
  irel2     =  idur-iat-irel1
  kenv      linseg    0,iat,iamp,irel1,iamp*.4,irel2,0

  kf2       expseg    i1f1,ifat1,ifq2,ifat2,i1f2,idec1,ifq2, idec2,ifq2*1.1
  adyn      oscil     kf2*imax, 1/idur, 52
  amod      oscil     adyn, ifq2, if2
  kf1       expseg    i2f1,ifat1,ifq1,ifat2,i2f2,idec1,ifq1, idec2,ifq1*1.1
  a1        oscil     kenv, kf1+amod, if1

  kf4       expseg    i1f1*2,ifat1,ifq2*2,ifat2,i1f2*2,idec1,ifq2*2, idec2,ifq2*1.9
  adyn      oscil     2*kf2*imax, 1/idur, 52
  amod      oscil     adyn, ifq2*2, if2
  kf3       expseg    i2f1*2,ifat1,ifq1*2,ifat2,i2f2*2,idec1,ifq1*2, idec2,ifq1*1.9
  a2        oscil     kenv, 2*kf1 + amod, if1

  i1rf1     =  ifq1*(40/p4)
  i1rf2     =  ifq1*(p4/60)
  i1rf3     =  ifq1*(70/p4)
  i2rf1     =  ifq2*(40/p4)
  i2rf2     =  ifq2*(p4/60)
  i2rf3     =  ifq2*(60/p4)
  irfat1    =  p4/1000
  irfat2    =  p4/500
  irdec1    =  p4/250
  irdec2    =  idur-irfat1-irfat2-irdec1

  kafq1     expseg    i1rf1*2,irfat1,ifq1*2,irfat2,i1rf2*2,irdec1,i1rf3*2,irdec2,ifq1*2.5
  kafq2     expseg    i2rf1*2,irfat1,ifq2*2,irfat2,i2rf2*2,irdec1,i2rf3*2,irdec2,ifq2*1.5
  kfam      expseg    1, irfat1*2, p4/4, irfat2*4, p4/8, idur-irfat1*2-irfat2*4, idur
  kfen      expseg    1, irfat1*2, p4/2, irfat2*4, p4/4, idur-irfat1*2-irfat2*4, p4/16
  klfq      oscil     kfam,kfen, 1
  kbw       linseg    p4/20, 1/p4, p4*1.2, irfat2*20, p4/2, idur-1/p4-irfat2*20, p4/8/idur
   
  aflt1     reson     a1,kafq1*2+klfq, kbw*(p4/20), 2 ;kbw/4
  aflt2     reson     a2,kafq2*2+klfq, kbw*(p4/40), 2 ;kbw/8
  afin      =  aflt1+aflt2

  klp       expseg    p4*3,8*idur/p4,p4*160,6*idur/p4,160000/p4, idur-8*idur/p4-6*idur/p4, p4*180

  khp       expseg    32000/p4,4*idur/p4,8000/p4,8*idur/p4,12000/p4,idur-4*idur/p4-8*idur/p4,24000/p4        
 
  alpf      butterlp  afin, klp                   ; cutting above klp

  ahpf      butterhp  alpf, khp                   ; cutting below khp
       
            outs      ahpf, ahpf

endin


;;----------------------------------------                         4
;;----------------------------------------
;;----------------------------------------
;;----------------------------------------

instr 4                 ;; Timp_6

  idur      =  p3
  iamp      =  ampdb(p4)/2
  ifq1      =  cpspch(p5-1)*5
  if1       =  1
  ifq2      =  cpspch(p5-1)*7
  if2       =  1
  ifmindex  =  p6        
  imax      =  (idur*p4/20)/ifmindex

  i1f1      =  ifq1*(p4/40)
  i1f2      =  ifq1*(60/p4)
  ifat1     =  1/p4
  ifat2     =  2/p4
  idec1     =  4/p4
  idec2     =  idur-ifat1-ifat2-idec1

  i2f1      =  ifq2*(p4/40)
  i2f2      =  ifq2*(60/p4)

  iat       =  .1/p4  
  irel1     =  p4/8000        
  irel2     =  idur-iat-irel1
   
  kenv      linseg    0,iat,iamp,irel1,iamp*.4,irel2,0

  kf2       expseg    i1f1,ifat1,ifq2,ifat2,i1f2,idec1,ifq2, idec2,ifq2*1.1
  adyn      oscil     kf2*imax, 1/idur, 52
  amod      oscil     adyn, ifq2, if2
  kf1       expseg    i2f1,ifat1,ifq1,ifat2,i2f2,idec1,ifq1, idec2,ifq1*1.1
  a1        oscil     kenv, kf1+amod, if1

  kf4       expseg    i1f1*2,ifat1,ifq2*2,ifat2,i1f2*2,idec1,ifq2*2, idec2,ifq2*1.9
  adyn      oscil     2*kf2*imax, 1/idur, 52
  amod      oscil     adyn, ifq2*2, if2
  kf3       expseg    i2f1*2,ifat1,ifq1*2,ifat2,i2f2*2,idec1,ifq1*2, idec2,ifq1*1.9
  a2        oscil     kenv, 2*kf1 + amod, if1

  i1rf1     =  ifq1*(40/p4)
  i1rf2     =  ifq1*(p4/60)
  i1rf3     =  ifq1*(70/p4)
  i2rf1     =  ifq2*(40/p4)
  i2rf2     =  ifq2*(p4/60)
  i2rf3     =  ifq2*(60/p4)
  irfat1    =  p4/1000
  irfat2    =  p4/500
  irdec1    =  p4/250
  irdec2    =  idur-irfat1-irfat2-irdec1

  kafq1     expseg    i1rf1*2,irfat1,ifq1*2,irfat2,i1rf2*2,irdec1,i1rf3*2,irdec2,ifq1*2.5
  kafq2     expseg    i2rf1*2,irfat1,ifq2*2,irfat2,i2rf2*2,irdec1,i2rf3*2,irdec2,ifq2*1.5
  kfam      expseg    1, irfat1*2, p4/4, irfat2*4, p4/8, idur-irfat1*2-irfat2*4, idur
  kfen      expseg    1, irfat1*2, p4/2, irfat2*4, p4/4, idur-irfat1*2-irfat2*4, p4/16
  klfq      oscil     kfam,kfen, 1

  kbw       linseg    p4/20, 1/p4, p4*1.2, irfat2*20, p4/2, idur-1/p4-irfat2*20, p4/8/idur

  aflt1     reson     a1,kafq1*2+klfq, kbw*(p4/20), 2 ;kbw/4
  aflt2     reson     a2,kafq2*2+klfq, kbw*(p4/40), 2 ;kbw/8
  afin      =  aflt1+aflt2

  klp1      expseg    p4*3,  7*idur/p4,p4*160,6*idur/p4,160000/p4, idur-7*idur/p4-6*idur/p4, p4*180
  klp2      expseg    p4*2.4,8*idur/p4,p4*180,7*idur/p4,180000/p4, idur-8*idur/p4-7*idur/p4, p4*90 
  klp3      expseg    p4*2,  9*idur/p4,p4*200,8*idur/p4,200000/p4, idur-9*idur/p4-8*idur/p4, p4*45         
        
  alpf      butterlp  afin, klp1                  ; cutting above klp
  alpf2     butterlp  afin, klp2
  alpf3     butterlp  afin, klp3

  khp1      expseg    32000/p4,4*idur/p4,16000/p4,8*idur/p4,24000/p4,idur-4*idur/p4-8*idur/p4,36000/p4
  khp2      expseg    40000/p4,5*idur/p4,24000/p4,7*idur/p4,36000/p4,idur-5*idur/p4-7*idur/p4,48000/p4
  khp3      expseg    48000/p4,6*idur/p4,32000/p4,6*idur/p4,48000/p4,idur-6*idur/p4-6*idur/p4,64000/p4

  ahpf      butterhp  alpf,  khp1                 ; cutting below khp
  ahpf2     butterhp  alpf2, khp2
  ahpf3     butterhp  alpf3, khp3


            outs      ahpf/2+ahpf3*2, ahpf/2+ahpf2*1.5

endin


;;----------------------------------------                         5
;;----------------------------------------
;;----------------------------------------
;;----------------------------------------
;;----------------------------------------

instr 5              ;; Timp_7

  idur      =  p3
  iamp      =  ampdb(p4)/2
  ifq1      =  cpspch(p5-1)*5
  if1       =  1
  ifq2      =  cpspch(p5-1)*7
  if2       =  1
  ifmindex  =  p6        
  imax      =  (idur*p4/60)*ifmindex

  i1f1      =  ifq1*(p4/40)
  i1f2      =  ifq1*(60/p4)
  ifat1     =  1/p4
  ifat2     =  2/p4
  idec1     =  4/p4

  idec2     =  idur-ifat1-ifat2-idec1

  i2f1      =  ifq2*(p4/40)
  i2f2      =  ifq2*(60/p4)

  iat       =  .1/p4  
  irel1     =  p4/8000        
  irel2     =  idur-iat-irel1
   
  kenv      linseg    0,iat,iamp,irel1,iamp*.4,irel2,0

  kf2       expseg    i1f1,ifat1,ifq2,ifat2,i1f2,idec1,ifq2, idec2,ifq2*1.1
  adyn      oscil     kf2*imax, 1/idur, 52
  amod      oscil     adyn, ifq2, if2
  kf1       expseg    i2f1,ifat1,ifq1,ifat2,i2f2,idec1,ifq1, idec2,ifq1*1.1
  a1        oscil     kenv, kf1+amod, if1

  kf4       expseg    i1f1*2,ifat1,ifq2*2,ifat2,i1f2*2,idec1,ifq2*2, idec2,ifq2*1.9
  adyn      oscil     2*kf2*imax, 1/idur, 52
  amod      oscil     adyn, ifq2*2, if2
  kf3       expseg    i2f1*2,ifat1,ifq1*2,ifat2,i2f2*2,idec1,ifq1*2, idec2,ifq1*1.9
  a2        oscil     kenv, 2*kf1 + amod, if1

  i1rf1     =  ifq1*(40/p4)
  i1rf2     =  ifq1*(p4/60)
  i1rf3     =  ifq1*(70/p4)
  i2rf1     =  ifq2*(40/p4)
  i2rf2     =  ifq2*(p4/60)
  i2rf3     =  ifq2*(60/p4)
  irfat1    =  p4/1000
  irfat2    =  p4/500
  irdec1    =  p4/250
  irdec2    =  idur-irfat1-irfat2-irdec1

  kafq1     expseg    i1rf1*2,irfat1,ifq1*2,irfat2,i1rf2*2,irdec1,i1rf3*2,irdec2,ifq1*2.5
  kafq2     expseg    i2rf1*2,irfat1,ifq2*2,irfat2,i2rf2*2,irdec1,i2rf3*2,irdec2,ifq2*1.5
  kfam      expseg    1, irfat1*2, p4/4, irfat2*4, p4/8, idur-irfat1*2-irfat2*4, idur
  kfen      expseg    1, irfat1*2, p4/2, irfat2*4, p4/4, idur-irfat1*2-irfat2*4, p4/16
  klfq      oscil     kfam,kfen, 1

  kbw       linseg    p4/20, 1/p4, p4*1.2, irfat2*20, p4/2, idur-1/p4-irfat2*20, p4/8/idur
                  
  aflt1     reson     a1,kafq1*2+klfq, kbw*(p4/20), 2 ;kbw/4
  aflt2     reson     a2,kafq2*2+klfq, kbw*(p4/40), 2 ;kbw/8

  kbw1      oscil     1, p4/10, 1
  kbw1      =  (kbw1+1)/2
  kbw1      =  kbw1*p4*p6/p7
  kbw2      oscil     1, p4/10, 1
  kbw2      =  (kbw2+1)/2
  kbw2      =  kbw2*p4/p6*p7

  aflt3     reson     a1,kafq1*p6*p7+klfq, kbw1, 2
  aflt4     reson     a1,kafq2*p6*p7+klfq, kbw2, 2

  aleft     =  aflt1
  aright    =  aflt2
  afin      =  aflt1+aflt2
  astip1    =  aflt3
  astip2    =  aflt4

  klp1      expseg    p4*3,  7*idur/p4,p4*160,6*idur/p4,160000/p4, idur-7*idur/p4-6*idur/p4, p4*180
  klp2      expseg    p4*2.4,8*idur/p4,p4*180,7*idur/p4,180000/p4, idur-8*idur/p4-7*idur/p4, p4*90 
  klp3      expseg    p4*2,  9*idur/p4,p4*200,8*idur/p4,200000/p4, idur-9*idur/p4-8*idur/p4, p4*45         
        
  alpf      butterlp  afin, klp1                  ; cutting above klp
  alpf2     butterlp  aleft, klp2
  alpf3     butterlp  aright, klp3

  khp1      expseg    32000/p4,4*idur/p4,16000/p4,8*idur/p4,24000/p4,idur-4*idur/p4-8*idur/p4,36000/p4
  khp2      expseg    40000/p4,5*idur/p4,24000/p4,7*idur/p4,36000/p4,idur-5*idur/p4-7*idur/p4,48000/p4
  khp3      expseg    48000/p4,6*idur/p4,32000/p4,6*idur/p4,48000/p4,idur-6*idur/p4-6*idur/p4,64000/p4

  ahpf      butterhp  alpf,  khp1                 ; cutting below khp
  ahpf2     butterhp  alpf2, khp2
  ahpf3     butterhp  alpf3, khp3

  kbp1      oscil     1, p4/10, 1
  kbp1      =  (kbp1+.1)/2
  kbp1      =  kbp1*p4*idur
  kbp2      oscil     1, p4/10, 1
  kbp2      =  (kbp2+.1)/2
  kbp2      =  kbp2*p4*idur
  kax1      expseg    p4*20,12*idur/p4,p4*40,6*idur/p4,64000/p4, idur-12*idur/p4-6*idur/p4, p4*200 
  kbp10     expseg    p4*2,12*idur/p4,p4*10,6*idur/p4,8000/p4, idur-12*idur/p4-6*idur/p4, p4*2 

  abpf1     butterbp  alpf, kax1, kbp10   
       
  kax2      expseg    p4*20,14*idur/p4,p4*40,8*idur/p4,64000/p4, idur-14*idur/p4-8*idur/p4, p4*200 
  kbp20     expseg    p4*2,14*idur/p4,p4*10,8*idur/p4,8000/p4, idur-14*idur/p4-8*idur/p4, p4*2 

  abpf2     butterbp  alpf, kax2, kbp20   
       
            outs      abpf1*6+astip1/2, abpf2*6+astip2/2

endin


;;----------------------------------------
;;----------------------------------------
;;--------- B - T O M --------------------
;;----------------------------------------
;;----------------------------------------

instr 11           ;; B-tom_1

  idur      =  p3
  iamp      =  ampdb(p4)*1.3
  ifq1      =  cpspch(p5-1)*5
  if1       =  1
  ifq2      =  cpspch(p5-1)*7
  if2       =  1
  ifmindex  =  p6                                 ; 1.0 - 3.0     
  imax      =  p4/4*ifmindex  

  i1f1      =  ifq1*(p4/40)
  i1f2      =  ifq1*(40/p4)
  ifat1     =  .4/p4       
  ifat2     =  .8/p4       
  idec1     =  1.6/p4      
  idec2     =  idur-ifat1-ifat2-idec1

  i2f1      =  ifq2*(p4/40)
  i2f2      =  ifq2*(40/p4)

  iat       =  .4/p4 
  irel1     =  .8/p4 
  irel2     =  idur-iat-irel1
   
  kenv      linseg    0,iat,iamp,irel1,iamp*.2,irel2,0

  kmax      expon     imax*.8, idur, imax*1.6

if (p7==1) kgoto rand1
if (p7>=1.5) kgoto rand2
if (p7<=.5) kgoto short      
           
rand1:
  krand1    randi     imax*(p6/8),p4/10           ;8
  kmax      =  kmax-krand1
;kf1 expseg ifq1,ifat1,i1f1,ifat2,i1f2,idec1,ifq1, idec2,ifq1*1.2
            kgoto     cont
rand2:
  krand2    randi     imax*(p6/10),p4/6           ;12
  kmax      =  kmax+krand2
;kf1 expseg ifq1,ifat1,i1f1,ifat2,i1f2,idec1,ifq1, idec2,ifq1/1.2
            kgoto     cont
short:
;kf1 expseg ifq1,ifat1,i1f1,ifat2,i1f2,idec1,ifq1, idec2,ifq1*1.8
            kgoto     cont

cont:
  kf2       expseg    ifq2,ifat1,i2f1,ifat2,i2f2,idec1,ifq2*p3, idec2,ifq2/p3
  adyn      oscil     kf2*kmax, 1/idur, 52
  amod      oscil     adyn, ifq2, if2

  kf1       expseg    ifq1,ifat1,i1f1,ifat2,i1f2,idec1,ifq1*p3, idec2,ifq1/p3

  a1        oscil     kenv, kf1 + amod, if1

  i1rf1     =  ifq1*(60/p4)
  i1rf2     =  ifq1*(p4/60)
  i1rf3     =  ifq1*(70/p4)
  i2rf1     =  ifq2*(60/p4)
  i2rf2     =  ifq2*(p4/60)
  i2rf3     =  ifq2*(70/p4)
  irfat1    =  p4/4000
  irfat2    =  p4/2000
  irdec1    =  p4/1000
  irdec2    =  idur-irfat1-irfat2-irdec1

  kafq1     expseg    i1rf1,irfat1,ifq1,irfat2,i1rf2,irdec1,i1rf3,irdec2,ifq1/p3
  kafq2     expseg    i2rf1,irfat1,ifq2,irfat2,i2rf2,irdec1,i2rf3,irdec2,ifq2/p3
  kfam      expseg    1, irfat1, p4/4, irfat2, p4/8, idur-irfat1-irfat2, p4/16
  kfen      expseg    p4, irfat1, p4/4, irfat2, p4/2, idur-irfat1-irfat2, p4
  kfq       oscil     kfam,kfen, 1

  ibw       =  p4                                 ;*ifmindex
  kbw       expseg    ibw/20, irfat1, ibw, irfat2, ibw/1.4, irdec1, ibw/2,irdec2,ibw/8
  krenv     linseg    0,iat,1,irel1,.2,irel2*.9,0, irel2*.1, 0 

  aflt1     reson     a1*krenv,kafq1+kfq, kbw/1, 2
  aflt2     reson     a1*krenv,kafq2+kfq, kbw/1, 2

  a2        rand      iamp
  ibw2      =  p4*p3
  kbw2      expseg    ibw/20, irfat1, ibw, irfat2, ibw/1.4, irdec1, ibw/2,irdec2,ibw/8   
  aflt3     reson     a2,kafq1*60/p4, kbw2, 2
  aflt4     reson     a2,kafq2*40/p4, kbw2, 2
  krenv2    linseg    0,iat,1,irel1,.02,irel2*.1,0, irel2*.9, 0  
  aflt3     =  aflt3*krenv*p4/60
  aflt4     =  aflt4*krenv*p4/60

  kpan      expseg    .01, idur/2, .1*p6, idur/2, .1
  kbal      randi     kpan, p4/12 
  kbal      oscil     kbal, 1/idur, 1
  kbal      =  .5+kbal
 
  aleft     =  (aflt1+aflt2+aflt3/2)*kbal
  aright    =  (aflt2+aflt1+aflt4/2)*(1-kbal)

            outs      aleft, aright
endin



;===================================================================
   
instr 21        ;; FM_1

  idur      =  p3
  iamp      =  ampdb(p4)/2
  ifq1      =  cpspch(p5-1)*5
  if1       =  1
  ifq2      =  cpspch(p5-1)*7
  if2       =  1
  ifmindex  =  p6        
  imax      =  (idur*p4/40)*ifmindex

  i1f1      =  ifq1*(p4/40)
  i1f2      =  ifq1*(60/p4)
  ifat1     =  1/p4
  ifat2     =  2/p4
  idec1     =  4/p4
  idec2     =  idur-ifat1-ifat2-idec1

  i2f1      =  ifq2*(p4/40)
  i2f2      =  ifq2*(60/p4)

  iat       =  4/p4  
  irel1     =  p4/2000                            ;p4/4000
  irel2     =  idur-iat-irel1
   
  kenv      linseg    0,iat,iamp,irel1,iamp*.6,irel2,0

  kf2       expseg    i1f1,ifat1,ifq2,ifat2,i1f2,idec1,ifq2, idec2,ifq2*1.1
 
  kmax      randh     imax, 3.5*p8    
  kmax      =  imax+kmax
  adyn      oscil     kf2*kmax, 1/idur, 52
  amod      oscil     adyn, ifq2, if2
  kf1       expseg    i2f1,ifat1,ifq1,ifat2,i2f2,idec1,ifq1, idec2,ifq1*1.1
  a1        oscil     kenv, kf1+amod, if1

  kf4       expseg    i1f1*2,ifat1,ifq2*2,ifat2,i1f2*2,idec1,ifq2*2, idec2,ifq2*1.9
  adyn      oscil     2*kf2*imax, 1/idur, 52
  amod      oscil     adyn, ifq2*2, if2
  kf3       expseg    i2f1*2,ifat1,ifq1*2,ifat2,i2f2*2,idec1,ifq1*2, idec2,ifq1*1.9
  a2        oscil     kenv, 2*kf1 + amod, if1

  i1rf1     =  ifq1*(40/p4)
  i1rf2     =  ifq1*(p4/60)
  i1rf3     =  ifq1*(70/p4)
  i2rf1     =  ifq2*(40/p4)
  i2rf2     =  ifq2*(p4/60)
  i2rf3     =  ifq2*(60/p4)
  irfat1    =  p4/1000
  irfat2    =  p4/500
  irdec1    =  p4/250
  irdec2    =  idur-irfat1-irfat2-irdec1

  kafq1     expseg    i1rf1*2,irfat1,ifq1*2,irfat2,i1rf2*2,irdec1,i1rf3*2,irdec2,ifq1*2.5
  kafq2     expseg    i2rf1*2,irfat1,ifq2*2,irfat2,i2rf2*2,irdec1,i2rf3*2,irdec2,ifq2*1.5
  kfam      expseg    1, irfat1*2, p4/4, irfat2*4, p4/8, idur-irfat1*2-irfat2*4, idur
  kfen      expseg    1, irfat1*2, p4/2, irfat2*4, p4/4, idur-irfat1*2-irfat2*4, p4/16
  klfq      oscil     kfam,kfen, 1

  kbw       linseg    p4/20, 1/p4, p4*1.2, irfat2*20, p4/2, idur-1/p4-irfat2*20, p4/8/idur
                  
  aflt1     reson     a1,kafq1+klfq, kbw*(p4/20), 2 ;kbw/4
  aflt2     reson     a2,kafq2+klfq, kbw*(p4/40), 2 ;kbw/8

  kbw1      oscil     1, p4/10, 1                 ;p4/10
  kbw1      =  (kbw1+1)/2
  kbw1      =  kbw1*p4*p6/p7
  kbw2      oscil     1, p4/10, 1                 ;p4/10
  kbw2      =  (kbw2+1)/2
  kbw2      =  kbw2*p4/p6*p7

  aflt3     reson     a1,kafq1*p6*p7+klfq, kbw1, 2
  aflt4     reson     a1,kafq2*p6*p7+klfq, kbw2, 2

  aleft     =  aflt1
  aright    =  aflt2
  afin      =  aflt1+aflt2
  astip1    =  aflt3
  astip2    =  aflt4

  klp1      expseg    p4*3,  7*idur/p4,p4*160,6*idur/p4,160000/p4, idur-7*idur/p4-6*idur/p4, p4*180
  klp2      expseg    p4*2.4,8*idur/p4,p4*180,7*idur/p4,180000/p4, idur-8*idur/p4-7*idur/p4, p4*90 
  klp3      expseg    p4*2,  9*idur/p4,p4*200,8*idur/p4,200000/p4, idur-9*idur/p4-8*idur/p4, p4*45         
        
  alpf      butterlp  afin, klp1 
  alpf2     butterlp  aleft, klp2
  alpf3     butterlp  aright, klp3

  khp1      expseg    32000/p4,4*idur/p4,16000/p4,8*idur/p4,24000/p4,idur-4*idur/p4-8*idur/p4,36000/p4
  khp2      expseg    40000/p4,5*idur/p4,24000/p4,7*idur/p4,36000/p4,idur-5*idur/p4-7*idur/p4,48000/p4
  khp3      expseg    48000/p4,6*idur/p4,32000/p4,6*idur/p4,48000/p4,idur-6*idur/p4-6*idur/p4,64000/p4

  ahpf      butterhp  alpf,  khp1 
  ahpf2     butterhp  alpf2, khp2
  ahpf3     butterhp  alpf3, khp3

  kbp1      oscil     1, p4/10, 1
  kbp1      =  (kbp1+.1)/2
  kbp1      =  kbp1*p4*idur
  kbp2      oscil     1, p4/10, 1
  kbp2      =  (kbp2+.1)/2
  kbp2      =  kbp2*p4*idur
  kax1      expseg    p4*20,12*idur/p4,p4*40,6*idur/p4,64000/p4, idur-12*idur/p4-6*idur/p4, p4*200 
  kbp10     expseg    p4*2,12*idur/p4,p4*10,6*idur/p4,8000/p4, idur-12*idur/p4-6*idur/p4, p4*2 

  abpf1     butterbp  alpf, kax1, kbp10 
       
  kax2      expseg    p4*20,14*idur/p4,p4*40,8*idur/p4,64000/p4, idur-14*idur/p4-8*idur/p4, p4*200 
  kbp20     expseg    p4*2,14*idur/p4,p4*10,8*idur/p4,8000/p4, idur-14*idur/p4-8*idur/p4, p4*2 

  abpf2     butterbp  alpf, kax2, kbp20 
       
            outs      ahpf2, ahpf2

endin



;;----------------------------------                          6

instr 6     ;; Timp_92

  idur      =  p3
  iamp      =  ampdb(p4)/2
  ifq1      =  cpspch(p5-1)*5
  if1       =  1
  ifq2      =  cpspch(p5-1)*7
  if2       =  1
  ifmindex  =  p6        
  imax      =  (idur*p4/30)*ifmindex

  i1f1      =  ifq1*(p4/40)
  i1f2      =  ifq1*(60/p4)
  ifat1     =  1/p4                               ;1/p4
  ifat2     =  2/p4                               ;2/p4
  idec1     =  4/p4                               ;4/p4
  idec2     =  idur-ifat1-ifat2-idec1

  i2f1      =  ifq2*(p4/40)
  i2f2      =  ifq2*(60/p4)

  iat       =  1.6/p4 
  irel1     =  p4/100        
  irel2     =  idur-iat-irel1
   ;aenv  oscil  iamp, 1/idur, 51
  kenv      linseg    0,iat,iamp,irel1,iamp*.8,irel2,0

  kf2       expseg    i1f1,ifat1,ifq2,ifat2,i1f2,idec1,ifq2, idec2,ifq2*1.1
  adyn      oscil     kf2*imax, 1/idur, 52
  amod      oscil     adyn, ifq2, if2
  kf1       expseg    i2f1,ifat1,ifq1,ifat2,i2f2,idec1,ifq1, idec2,ifq1*1.1
  a1        oscil     kenv, kf1+amod, if1

  kf4       expseg    i1f1*2,ifat1,ifq2*2,ifat2,i1f2*2,idec1,ifq2*2, idec2,ifq2*1.9
  adyn      oscil     2*kf2*imax, 1/idur, 52
  amod      oscil     adyn, ifq2*2, if2
  kf3       expseg    i2f1*2,ifat1,ifq1*2,ifat2,i2f2*2,idec1,ifq1*2, idec2,ifq1*1.9
  a2        oscil     kenv, 2*kf1 + amod, if1

  i1rf1     =  ifq1*(40/p4)
  i1rf2     =  ifq1*(p4/60)
  i1rf3     =  ifq1*(70/p4)
  i2rf1     =  ifq2*(40/p4)
  i2rf2     =  ifq2*(p4/60)
  i2rf3     =  ifq2*(60/p4)
  irfat1    =  p4/500                             ;p4/1000
  irfat2    =  p4/250                             ;p4/500
  irdec1    =  p4/125                             ;p4/250
  irdec2    =  idur-irfat1-irfat2-irdec1

  kafq1     expseg    i1rf1*2,irfat1,ifq1*2,irfat2,i1rf2*2,irdec1,i1rf3*2,irdec2,ifq1*2.5
  kafq2     expseg    i2rf1*2,irfat1,ifq2*2,irfat2,i2rf2*2,irdec1,i2rf3*2,irdec2,ifq2*1.5
  kfam      expseg    1, irfat1*2, p4/4, irfat2*4, p4/8, idur-irfat1*2-irfat2*4, idur
  kfen      expseg    1, irfat1*2, p4/2, irfat2*4, p4/4, idur-irfat1*2-irfat2*4, p4/16
;;klfq  oscil kfam,kfen, 1

  kren      line      1, idur, .4
  klfq1     randh     p7*kafq1*kren, p4/10*p6     ; .8*idur*p6 
  kbw       linseg    p4/20, 1/p4, p4*1.2, irfat2*20, p4/2, idur-1/p4-irfat2*20, p4/8/idur
                  
  aflt1     reson     a1,kafq1*2+klfq1, kbw*(p4/20), 2   
  aflt2     reson     a2,kafq2*2+klfq1, kbw*(p4/40), 2   

  kbw1      oscil     1, p4/9.6, 1
  kbw1      =  (kbw1+1)/2
  kbw1      =  kbw1*p4*p6*p7
  kbw2      oscil     1, p4/10.4, 1
  kbw2      =  (kbw2+1)/2
  kbw2      =  kbw2*p4*p6*p7

;;kenv1 linseg .001, idur/p4,1, 8*idur/p4, ..8,10*idur/p4,1,idur-idur/p4-8*idur/p4-10*idur/p4, .001
;;kenv2 linseg .001, idur/p4,1, 12*idur/p4, ..6,8*idur/p4,1,idur-idur/p4-12*idur/p4-8*idur/p4, .001

  kenv22    linseg    0,iat*1.6,.1,irel1,1,idur-iat*1.6-irel1,0
  kenv1     oscil     1 , 1/idur, 1 
  kenv2     oscil     kenv22, 1/idur, 1, .25
  klfq3     randh     kafq2*p7, idur*p6
  klfq4     randh     kafq2*p7*kenv22, idur*p6
  aflt3     reson     a1*kenv1,kafq1*4*p7+klfq3, kbw1, 2
  aflt4     reson     a2*kenv2,kafq2*4*p7+klfq4, kbw2, 2

  aleft     =  aflt1
  aright    =  aflt2
  afin      =  aflt1+aflt2
  astip1    =  aflt3
  astip2    =  aflt4

  klp1      expseg    p4*3,  7*idur/p4,p4*160,6*idur/p4,160000/p4, idur-7*idur/p4-6*idur/p4, p4*180
  klp2      expseg    p4*2.4,8*idur/p4,p4*180,7*idur/p4,180000/p4, idur-8*idur/p4-7*idur/p4, p4*90 
  klp3      expseg    p4*2,  9*idur/p4,p4*200,8*idur/p4,200000/p4, idur-9*idur/p4-8*idur/p4, p4*45         
        
  alpf      butterlp  afin, klp1 
  alpf2     butterlp  aleft, klp2
  alpf3     butterlp  aright, klp3

  khp1      expseg    32000/p4,4*idur/p4,16000/p4,8*idur/p4,24000/p4,idur-4*idur/p4-8*idur/p4,36000/p4
  khp2      expseg    40000/p4,5*idur/p4,24000/p4,7*idur/p4,36000/p4,idur-5*idur/p4-7*idur/p4,48000/p4
  khp3      expseg    48000/p4,6*idur/p4,32000/p4,6*idur/p4,48000/p4,idur-6*idur/p4-6*idur/p4,64000/p4

  ahpf      butterhp  alpf,  khp1 
  ahpf2     butterhp  alpf2, khp2
  ahpf3     butterhp  alpf3, khp3

  kbp1      oscil     1, p4/5.1, 1
  kbp1      =  (kbp1+1)/2
  kbp1      =  kbp1*p4*idur*p7
  kbp2      oscil     1, p4/4.9, 1
  kbp2      =  (kbp2+1)/2
  kbp2      =  kbp2*p4*idur*p6

  kren1     linseg    .8, p7, 1, idur-p7, .5
  kren2     linseg    1, p7, .8, idur-p7, .4

  kaxr1     randh     kren1*p4, 4/p7
  kbpr1     randh     kren1*p4/16, 4/p7

  kaxr2     randh     kren2*p4, 2*p7
  kbpr2     randh     kren2*p4/32, 2*p7

  kax1      expseg    p4*8,12*idur/p4,p4*60,8*idur/p4,64000/p4, idur-12*idur/p4-8*idur/p4, p4*20 
  kbp10     expseg    p4,12*idur/p4,p4*20,8*idur/p4,8000/p4, idur-12*idur/p4-8*idur/p4, p4*2 

  abpf1     butterbp  aleft, kax1+kaxr1, kbp10+kbpr1 ; passing area ?Hz
       
  kax2      expseg    p4*6,8*idur/p4,p4*40,8*idur/p4,56000/p4, idur-8*idur/p4-8*idur/p4, p4*10 
  kbp20     expseg    p4/2,8*idur/p4,p4*10,8*idur/p4,6000/p4, idur-8*idur/p4-8*idur/p4, p4 

  abpf2     butterbp  aleft, kax2+kaxr2, kbp20+kbpr2 

            outs      abpf1*3, abpf2*2

endin


;;---------------------------------                                7

instr 7   ;; Timp_93

  idur      =  p3
  iamp      =  ampdb(p4)/2
  ifq1      =  cpspch(p5-1)*5
  if1       =  1
  ifq2      =  cpspch(p5-1)*7
  if2       =  1
  ifmindex  =  p6        
  imax      =  (idur*p4/30)*ifmindex

  i1f1      =  ifq1*(p4/20) 
  i1f2      =  ifq1*(40/p4) 
  ifat1     =  4/p4                               ;1/p4
  ifat2     =  8/p4                               ;2/p4
  idec1     =  16/p4                              ;4/p4
  idec2     =  idur-ifat1-ifat2-idec1

  i2f1      =  ifq2*(p4/20) 
  i2f2      =  ifq2*(40/p4) 

  iat       =  8/p4 
  irel1     =  p4/80        
  irel2     =  idur-iat-irel1
   
  kenv      linseg    0,iat,iamp,irel1,iamp*.8,irel2,0

  kf2       expseg    i1f1,ifat1,ifq2,ifat2,i1f2,idec1,ifq2, idec2,ifq2*2.4
  adyn      oscil     kf2*imax, 1/idur, 52
  amod      oscil     adyn, ifq2, if2
  kf1       expseg    i2f1,ifat1,ifq1,ifat2,i2f2,idec1,ifq1, idec2,ifq1*1.6
  a1        oscil     kenv, kf1+amod, if1

  kf4       expseg    i1f1*2,ifat1,ifq2*2,ifat2,i1f2*2,idec1,ifq2*2, idec2,ifq2*1.8
  adyn      oscil     2*kf2*imax, 1/idur, 52
  amod      oscil     adyn, ifq2*2, if2
  kf3       expseg    i2f1*2,ifat1,ifq1*2,ifat2,i2f2*2,idec1,ifq1*2, idec2,ifq1*1.6
  a2        oscil     kenv, 2*kf1 + amod, if1

  i1rf1     =  ifq1*(40/p4)
  i1rf2     =  ifq1*(p4/60)
  i1rf3     =  ifq1*(70/p4)
  i2rf1     =  ifq2*(40/p4)
  i2rf2     =  ifq2*(p4/60)
  i2rf3     =  ifq2*(60/p4)
  irfat1    =  p4/500   
  irfat2    =  p4/250    
  irdec1    =  p4/125    
  irdec2    =  idur-irfat1-irfat2-irdec1

  kafq1     expseg    i1rf1*2,irfat1,ifq1*2,irfat2,i1rf2*2,irdec1,i1rf3*2,irdec2,ifq1*2.5
  kafq2     expseg    i2rf1*2,irfat1,ifq2*2,irfat2,i2rf2*2,irdec1,i2rf3*2,irdec2,ifq2*1.5
  kfam      expseg    1, irfat1*2, p4/4, irfat2*4, p4/8, idur-irfat1*2-irfat2*4, idur
  kfen      expseg    1, irfat1*2, p4/2, irfat2*4, p4/4, idur-irfat1*2-irfat2*4, p4/16
;;klfq  oscil kfam,kfen, 1

  kren      line      1, idur, .4
  klfq1     randh     p7*kafq1*kren, p4/10*p6     ; .8*idur*p6 
  kbw       linseg    p4/20, 1/p4, p4*1.2, irfat2*20, p4/2, idur-1/p4-irfat2*20, p4/8/idur
                  
  aflt1     reson     a1,kafq1*2+klfq1, kbw*(p4/20), 2
  aflt2     reson     a2,kafq2*2+klfq1, kbw*(p4/40), 2

  kbw1      oscil     1, p4/9.6, 1
  kbw1      =  (kbw1+1)/2
  kbw1      =  kbw1*p4*p6*p7
  kbw2      oscil     1, p4/10.4, 1
  kbw2      =  (kbw2+1)/2
  kbw2      =  kbw2*p4*p6*p7

;;kenv1 linseg .001, idur/p4,1, 8*idur/p4, ..8,10*idur/p4,1,idur-idur/p4-8*idur/p4-10*idur/p4, .001
;;kenv2 linseg .001, idur/p4,1, 12*idur/p4, ..6,8*idur/p4,1,idur-idur/p4-12*idur/p4-8*idur/p4, .001

  kenv22    linseg    0,iat*1.6,.1,irel1,1,idur-iat*1.6-irel1,0
  kenv1     oscil     1 , 1/idur, 1 
  kenv2     oscil     kenv22, 1/idur, 1, .25
  klfq3     randh     kafq2*p7, idur*p6
  klfq4     randh     kafq2*p7*kenv22, idur*p6
  aflt3     reson     a1*kenv1,kafq1*4*p7+klfq3, kbw1, 2
  aflt4     reson     a2*kenv2,kafq2*4*p7+klfq4, kbw2, 2

  aleft     =  aflt1
  aright    =  aflt2
  afin      =  aflt1+aflt2
  astip1    =  aflt3
  astip2    =  aflt4

  klp1      expseg    p4*3,  7*idur/p4,p4*160,6*idur/p4,160000/p4, idur-7*idur/p4-6*idur/p4, p4*180
  klp2      expseg    p4*2.4,8*idur/p4,p4*180,7*idur/p4,180000/p4, idur-8*idur/p4-7*idur/p4, p4*90 
  klp3      expseg    p4*2,  9*idur/p4,p4*200,8*idur/p4,200000/p4, idur-9*idur/p4-8*idur/p4, p4*45         
        
  alpf      butterlp  afin, klp1                  ; cutting above klp
  alpf2     butterlp  aleft, klp2
  alpf3     butterlp  aright, klp3

  khp1      expseg    32000/p4,4*idur/p4,16000/p4,8*idur/p4,24000/p4,idur-4*idur/p4-8*idur/p4,36000/p4
  khp2      expseg    40000/p4,5*idur/p4,24000/p4,7*idur/p4,36000/p4,idur-5*idur/p4-7*idur/p4,48000/p4
  khp3      expseg    48000/p4,6*idur/p4,32000/p4,6*idur/p4,48000/p4,idur-6*idur/p4-6*idur/p4,64000/p4

  ahpf      butterhp  alpf,  khp1                 ; cutting below khp
  ahpf2     butterhp  alpf2, khp2
  ahpf3     butterhp  alpf3, khp3

  kbp1      oscil     .8, p4/5.2, 1
  kbp1      =  (kbp1+1)/2
  kbp1      =  kbp1*p4*idur*p7
  kbp2      oscil     .6, p4/4.8, 1
  kbp2      =  (kbp2+1)/2
  kbp2      =  kbp2*p4*idur*p6

  kren1     linseg    .8, p7*2, 1, idur-p7*2, .5
  kren2     linseg    .6, p7/2, 1, idur-p7/2, .4

  kaxr1     randi     kren1*p4, 4*p7
  kbpr1     randi     kren1*p4/32, 4*p7

  kaxr2     randi     kren2*p4, 12/p7
  kbpr2     randi     kren2*p4/24, 12/p7

  kax1      expseg    p4*8,24*idur/p4,p4*48,16*idur/p4,32000/p4, idur-24*idur/p4-16*idur/p4, p4*20 
  kbp10     expseg    p4/2,24*idur/p4,p4*8,16*idur/p4,16000/p4, idur-24*idur/p4-16*idur/p4, p4*2 

  abpf1     butterbp  aright, kax1+kaxr1, kbp1+kbpr1
       
  kax2      expseg    p4*6,32*idur/p4,p4*36,12*idur/p4,48000/p4, idur-32*idur/p4-12*idur/p4, p4*10 
  kbp20     expseg    p4/4,32*idur/p4,p4*12,12*idur/p4,24000/p4, idur-32*idur/p4-12*idur/p4, p4 

  abpf2     butterbp  aright, kax2+kaxr2, kbp2+kbpr2

            outs      abpf2, abpf1

endin


;;----------------------------------------
;;----------------------------------------
;;--------- B - T O M ---2----------------
;;----------------------------------------
;;----------------------------------------

instr 12             ;; B-tom_2

  idur      =  p3
  iamp      =  ampdb(p4)*1.3
  ifq1      =  cpspch(p5-1)*5
  if1       =  1
  ifq2      =  cpspch(p5-1)*7
  if2       =  1
  ifmindex  =  p6       
  imax      =  p4/4*ifmindex 

  i1f1      =  ifq1*(p4/40)
  i1f2      =  ifq1*(40/p4)
  ifat1     =  .4/p4 
  ifat2     =  .8/p4 
  idec1     =  1.6/p4 
  idec2     =  idur-ifat1-ifat2-idec1

  i2f1      =  ifq2*(p4/40)
  i2f2      =  ifq2*(40/p4)

  iat       =  .4/p4 
  irel1     =  .8/p4 
  irel2     =  idur-iat-irel1
   
  kenv      linseg    0,iat,iamp,irel1,iamp*.2,irel2,0

  kmax      expon     imax*.8, idur, imax*1.6

if (p7==1) kgoto rand1
if (p7>=1.5) kgoto rand2
if (p7<=.5) kgoto short      
           
rand1:
  krand1    randi     imax*(p6/8),p4/10           ;8
  kmax      =  kmax-krand1
            kgoto     cont
rand2:
  krand2    randi     imax*(p6/10),p4/6           ;12
  kmax      =  kmax+krand2

            kgoto     cont
short:
;kf1 expseg ifq1,ifat1,i1f1,ifat2,i1f2,idec1,ifq1, idec2,ifq1*1.8
            kgoto     cont

cont:
  kf2       expseg    ifq2,ifat1,i2f1,ifat2,i2f2,idec1,ifq2*p3, idec2,ifq2/p3
  adyn      oscil     kf2*kmax, 1/idur, 52
  amod      oscil     adyn, ifq2, if2

  kf1       expseg    ifq1,ifat1,i1f1,ifat2,i1f2,idec1,ifq1*p3, idec2,ifq1/p3

  a1        oscil     kenv, kf1 + amod, if1

  i1rf1     =  ifq1*(60/p4)
  i1rf2     =  ifq1*(p4/60)
  i1rf3     =  ifq1*(70/p4)
  i2rf1     =  ifq2*(60/p4)
  i2rf2     =  ifq2*(p4/60)*p3
  i2rf3     =  ifq2*(70/p4)*p3
  irfat1    =  p4/4000
  irfat2    =  p4/2000
  irdec1    =  p4/1000
  irdec2    =  idur-irfat1-irfat2-irdec1

  kafq1     expseg    i1rf1,irfat1,ifq1,irfat2,i1rf2,irdec1,i1rf3,irdec2,ifq1/p3
  kafq2     expseg    i2rf1,irfat1,ifq2,irfat2,i2rf2,irdec1,i2rf3,irdec2,ifq2/p3
  kfam      expseg    1, irfat1, p4/4, irfat2, p4/8, idur-irfat1-irfat2, p4/16
  kfen      expseg    p4, irfat1, p4/4, irfat2, p4/2, idur-irfat1-irfat2, p4
  kfq       oscil     kfam,kfen, 1

  ibw       =  p4*p7
  kbw       expseg    ibw/20, irfat1, ibw, irfat2, ibw/1.4, irdec1, ibw/2,irdec2,ibw/8
  krenv     linseg    0,iat,1,irel1,.2,irel2*.9,0, irel2*.1, 0 

  aflt1     reson     a1*krenv,kafq1+kfq, kbw/1, 2
  aflt2     reson     a1*krenv,kafq2+kfq, kbw/1, 2

  a2        rand      iamp
  ibw2      =  p4*p3
  kbw2      expseg    ibw/20, irfat1, ibw, irfat2, ibw/1.4, irdec1, ibw/2,irdec2,ibw/8   
  aflt3     reson     a2,kafq1*60/p4, kbw2, 2
  aflt4     reson     a2,kafq2*40/p4, kbw2, 2
  krenv2    linseg    0,iat,1,irel1,.02,irel2*.1,0, irel2*.9, 0  
  aflt3     =  aflt3*krenv*p4/60
  aflt4     =  aflt4*krenv*p4/60

  kpan      expseg    .01, idur/2, .1*p6, idur/2, .1
  kbal      randi     kpan, p4/12 
  kbal      oscil     kbal, 1/idur, 1
  kbal      =  .5+kbal
 
  aleft     =  (aflt1+aflt2+aflt3/2)*kbal
  aright    =  (aflt2+aflt1+aflt4/2)*(1-kbal)

            outs      aleft, aright
endin



;;----------------------------------------
;;----------------------------------------
;;--------- B - T O M ---3----------------
;;----------------------------------------
;;----------------------------------------
  
instr 13             ;; B-tom_3

  idur      =  p3
  iamp      =  ampdb(p4)*1.3

  ifq1      =  cpspch(p5-1)*5
  ifq2      =  cpspch(p5-1)*7
  if1       =  1
  if2       =  1
  ifmindex  =  p6       
  imax      =  p4/4*ifmindex 
           

  i1f1      =  ifq1*(p4/60)
  i1f2      =  ifq1*(60/p4)
  ifat1     =  .4/p4       
  ifat2     =  .8/p4      
  idec1     =  1.6/p4     
  idec2     =  idur-ifat1-ifat2-idec1

  i2f1      =  ifq2*(p4/60)
  i2f2      =  ifq2*(60/p4)

  iat       =  .4/p4   
  irel1     =  .8/p4   
  irel2     =  idur-iat-irel1
   
  kenv      linseg    0,iat,iamp,irel1,iamp*.2,irel2,0

  kmax      expon     imax*.8, idur, imax*1.6

if (p7==1) kgoto rand1
if (p7>=1.5) kgoto rand2
if (p7<=.5) kgoto short      
           
rand1:
  krand1    randi     imax*(p6/8),p4/10           ;8
  kmax      =  kmax-krand1
            kgoto     cont
rand2:
  krand2    randi     imax*(p6/10),p4/6           ;12
  kmax      =  kmax+krand2
            kgoto     cont
short:
;kf1 expseg ifq1,ifat1,i1f1,ifat2,i1f2,idec1,ifq1, idec2,ifq1*1.8
            kgoto     cont

cont:
  kf2       expseg    ifq2,ifat1,i2f1,ifat2,i2f2,idec1,ifq2*p3, idec2,ifq2/p3
  adyn      oscil     kf2*kmax, 1/idur, 52
  amod      oscil     adyn, ifq2, if2

  kf1       expseg    ifq1,ifat1,i1f1,ifat2,i1f2,idec1,ifq1*p3, idec2,ifq1/p3

  a1        oscil     kenv, kf1 + amod, if1

  i1rf1     =  ifq1*(60/p4)
  i1rf2     =  ifq1*(p4/60)
  i1rf3     =  ifq1*(70/p4)
  i2rf1     =  ifq2*(60/p4)
  i2rf2     =  ifq2*(p4/60)*p3
  i2rf3     =  ifq2*(70/p4)*p3
  irfat1    =  p4/4000
  irfat2    =  p4/2000
  irdec1    =  p4/1000
  irdec2    =  idur-irfat1-irfat2-irdec1

  kafq1     expseg    i1rf1,irfat1,ifq1,irfat2,i1rf2,irdec1,i1rf3,irdec2,ifq1/p3
  kafq2     expseg    i2rf1,irfat1,ifq2,irfat2,i2rf2,irdec1,i2rf3,irdec2,ifq2/p3
  kfam      expseg    1, irfat1, p4/4, irfat2, p4/8, idur-irfat1-irfat2, p4/16
  kfen      expseg    p4, irfat1, p4/4, irfat2, p4/2, idur-irfat1-irfat2, p4
  kfq       oscil     kfam,kfen, 1

  ibw       =  p4*2*p7
  kbw       expseg    ibw/20, irfat1, ibw, irfat2, ibw/1.4, irdec1, ibw/2,irdec2,ibw/8
  krenv     linseg    0,iat,1,irel1,.2,irel2*.9,0, irel2*.1, 0 

  aflt1     reson     a1*krenv,kafq1+kfq, kbw/1, 2
  aflt2     reson     a1*krenv,kafq2+kfq, kbw/1, 2

  a2        rand      iamp
  ibw2      =  p4*p7
  kbw2      expseg    ibw/20, irfat1, ibw, irfat2, ibw/1.4, irdec1, ibw/2,irdec2,ibw/8   
  aflt3     reson     a2,kafq1*60/p4, kbw2, 2
  aflt4     reson     a2,kafq2*60/p4, kbw2, 2
  krenv2    linseg    0,iat,1,irel1,.02,irel2*.1,0, irel2*.9, 0  
  aflt3     =  aflt3*krenv*p4/40
  aflt4     =  aflt4*krenv*p4/40

  kpan      expseg    .01, idur/2, .1*p6, idur/2, .1
  kbal      randi     kpan, p4/12 
  kbal      oscil     kbal, 1/idur, 1
  kbal      =  .5+kbal
 
  aleft     =  (aflt1+aflt2+aflt3/2)*kbal
  aright    =  (aflt2+aflt1+aflt4/2)*(1-kbal)

            outs      aleft, aright
endin


;-------------------------------------------------;
instr 22         
;-------------------------------------------------;

  idur      =  p3
  iamp      =  ampdb(p4)/2
  ifq1      =  cpspch(p5-1)*5
  if1       =  1
  ifq2      =  cpspch(p5-1)*7
  if2       =  1
  ifmindex  =  p6        
  imax      =  (idur*p4/30)*ifmindex   

  i1f1      =  ifq1*(p4/20)
  i1f2      =  ifq1*(40/p4)
  ifat1     =  1/p4
  ifat2     =  2/p4
  idec1     =  4/p4
  idec2     =  idur-ifat1-ifat2-idec1

  i2f1      =  ifq2*(p4/20)
  i2f2      =  ifq2*(40/p4)

  iat       =  4/p4  
  irel1     =  p4/2000        
  irel2     =  idur-iat-irel1
   
  kenv      linseg    0,iat,iamp,irel1,iamp*.6,irel2,0

  kf2       expseg    i1f1,ifat1,ifq2,ifat2,i1f2,idec1,ifq2, idec2,ifq2*1.6
 
  kmax1     randh     imax, 3.55
  kmax1     =  imax+kmax1
  adyn      oscil     kf2*kmax1, 1/idur, 52

  kfm       randh     7*p6, 3.5                   ;;;FM_21:kfm randi 7*p6*p7, 8---
               ;;kfm oscil kfm*.8,1/idur,1 
  kfm       oscil     kfm,1/idur,1   
  kfq2      =  ifq2+kfm
  amod      oscil     adyn, kfq2, if2
  kf1       expseg    i2f1,ifat1,ifq1,ifat2,i2f2,idec1,ifq1, idec2,ifq1*.8
  a1        oscil     kenv, kf1+amod, if1

  kf4       expseg    i1f1*2,ifat1,ifq2*2,ifat2,i1f2*2,idec1,ifq2*2, idec2,ifq2*1.9
   
  kmax2     randh     imax, 7                     ;;; FM_21: kmax1 randi imax, 8 -------------
  kmax2     =  imax+kmax2
  adyn      oscil     2*kf2*kmax2, 1/idur, 52
  amod      oscil     adyn, ifq2*2, if2
  kf3       expseg    i2f1*2,ifat1,ifq1*2,ifat2,i2f2*2,idec1,ifq1*2, idec2,ifq1*1.9
  a2        oscil     kenv, 2*kf1 + amod, if1

  i1rf1     =  ifq1*(40/p4)
  i1rf2     =  ifq1*(p4/60)
  i1rf3     =  ifq1*(70/p4)
  i2rf1     =  ifq2*(40/p4)
  i2rf2     =  ifq2*(p4/60)
  i2rf3     =  ifq2*(60/p4)
  irfat1    =  p4/1000
  irfat2    =  p4/500
  irdec1    =  p4/250
  irdec2    =  idur-irfat1-irfat2-irdec1

  kafq1     expseg    i1rf1*2,irfat1,ifq1*2,irfat2,i1rf2*2,irdec1,i1rf3*2,irdec2,ifq1*2.5
  kafq2     expseg    i2rf1*2,irfat1,ifq2*2,irfat2,i2rf2*2,irdec1,i2rf3*2,irdec2,ifq2*1.5
  kfam      expseg    1, irfat1*2, p4/4, irfat2*4, p4/8, idur-irfat1*2-irfat2*4, idur
  kfen      expseg    1, irfat1*2, p4/2, irfat2*4, p4/4, idur-irfat1*2-irfat2*4, p4/16
  klfq      oscil     kfam,kfen, 1

  kbw       linseg    p4/20, 1/p4, p4*1.2, irfat2*20, p4/2, idur-1/p4-irfat2*20, p4/8/idur
                  
  aflt1     reson     a1,kafq1+klfq, kbw*(p4/20), 2 ;kbw/4
  aflt2     reson     a2,kafq2+klfq, kbw*(p4/40), 2 ;kbw/8

  kbw1      oscil     1, p4/10, 1
  kbw1      =  (kbw1+1)/2
  kbw1      =  kbw1*p4*p6/p7
  kbw2      oscil     1, p4/10, 1
  kbw2      =  (kbw2+1)/2
  kbw2      =  kbw2*p4/p6*p7

  aflt3     reson     a1,kafq1*p6*p7+klfq, kbw1, 2
  aflt4     reson     a1,kafq2*p6*p7+klfq, kbw2, 2

  aleft     =  aflt1
  aright    =  aflt2
  afin      =  aflt1+aflt2
  astip1    =  aflt3
  astip2    =  aflt4

  klp1      expseg    p4*3,  7*idur/p4,p4*160,6*idur/p4,160000/p4, idur-7*idur/p4-6*idur/p4, p4*180
  klp2      expseg    p4*2.4,8*idur/p4,p4*180,7*idur/p4,180000/p4, idur-8*idur/p4-7*idur/p4, p4*90 
  klp3      expseg    p4*2,  9*idur/p4,p4*200,8*idur/p4,200000/p4, idur-9*idur/p4-8*idur/p4, p4*45         
        
  alpf      butterlp  afin, klp1                  ; cutting above klp
  alpf2     butterlp  aleft, klp2
  alpf3     butterlp  aright, klp3

  khp1      expseg    32000/p4,4*idur/p4,16000/p4,8*idur/p4,24000/p4,idur-4*idur/p4-8*idur/p4,36000/p4
  khp2      expseg    40000/p4,5*idur/p4,24000/p4,7*idur/p4,36000/p4,idur-5*idur/p4-7*idur/p4,48000/p4
  khp3      expseg    48000/p4,6*idur/p4,32000/p4,6*idur/p4,48000/p4,idur-6*idur/p4-6*idur/p4,64000/p4

  ahpf      butterhp  alpf,  khp1                 ; cutting below khp
  ahpf2     butterhp  alpf2, khp2
  ahpf3     butterhp  alpf3, khp3



  kbp1      oscil     1, p4/10, 1
  kbp1      =  (kbp1+.1)/2
  kbp1      =  kbp1*p4*idur
  kbp2      oscil     1, p4/10, 1
  kbp2      =  (kbp2+.1)/2
  kbp2      =  kbp2*p4*idur
  kax1      expseg    p4*20,12*idur/p4,p4*40,6*idur/p4,64000/p4, idur-12*idur/p4-6*idur/p4, p4*200 
  kbp10     expseg    p4*2,12*idur/p4,p4*10,6*idur/p4,8000/p4, idur-12*idur/p4-6*idur/p4, p4*2 

  abpf1     butterbp  alpf, kax1, kbp10           ; passing area ?Hz
       
  kax2      expseg    p4*20,14*idur/p4,p4*40,8*idur/p4,64000/p4, idur-14*idur/p4-8*idur/p4, p4*200 
  kbp20     expseg    p4*2,14*idur/p4,p4*10,8*idur/p4,8000/p4, idur-14*idur/p4-8*idur/p4, p4*2 

  abpf2     butterbp  alpf, kax2, kbp20           ; passing area ?Hz
       

            outs      ahpf2+ahpf3, ahpf2*.6+ahpf3*1.6

endin



;----------------------------------

instr 8              ;; Timp_10

  idur      =  p3
  iamp      =  ampdb(p4)/3
  ifq1      =  cpspch(p5-1)*5
  if1       =  1
  ifq2      =  cpspch(p5-1)*7
  if2       =  1
  ifmindex  =  p6        
  imax      =  (idur*p4/60)*ifmindex

  i1f1      =  ifq1*(p4/40)
  i1f2      =  ifq1*(60/p4)
  ifat1     =  1/p4                               ;1/p4
  ifat2     =  2/p4                               ;2/p4
  idec1     =  4/p4                               ;4/p4
  idec2     =  idur-ifat1-ifat2-idec1

  i2f1      =  ifq2*(p4/40)
  i2f2      =  ifq2*(60/p4)

  iat       =  1.6/p4 
  irel1     =  p4/100        
  irel2     =  idur-iat-irel1
   ;aenv  oscil  iamp, 1/idur, 51
  kenv      linseg    0,iat,iamp,irel1,iamp*.6,irel2,0

  kf2       expseg    i1f1,ifat1,ifq2,ifat2,i1f2,idec1,ifq2, idec2,ifq2*1.1
  adyn      oscil     kf2*imax, 1/idur, 52
  amod      oscil     adyn, ifq2, if2
  kf1       expseg    i2f1,ifat1,ifq1,ifat2,i2f2,idec1,ifq1, idec2,ifq1*1.1
  a1        oscil     kenv, kf1+amod, if1

  kf4       expseg    i1f1*2,ifat1,ifq2*2,ifat2,i1f2*2,idec1,ifq2*2, idec2,ifq2*1.9
  adyn      oscil     2*kf2*imax, 1/idur, 52
  amod      oscil     adyn, ifq2*2, if2
  kf3       expseg    i2f1*2,ifat1,ifq1*2,ifat2,i2f2*2,idec1,ifq1*2, idec2,ifq1*1.9
  a2        oscil     kenv, 2*kf1 + amod, if1

  i1rf1     =  ifq1*(40/p4)
  i1rf2     =  ifq1*(p4/60)
  i1rf3     =  ifq1*(70/p4)
  i2rf1     =  ifq2*(40/p4)
  i2rf2     =  ifq2*(p4/60)
  i2rf3     =  ifq2*(60/p4)
  irfat1    =  p4/500                             ;p4/1000
  irfat2    =  p4/250                             ;p4/500
  irdec1    =  p4/125                             ;p4/250
  irdec2    =  idur-irfat1-irfat2-irdec1

  kafq1     expseg    i1rf1*2,irfat1,ifq1*2,irfat2,i1rf2*2,irdec1,i1rf3*2,irdec2,ifq1*2.5
  kafq2     expseg    i2rf1*2,irfat1,ifq2*2,irfat2,i2rf2*2,irdec1,i2rf3*2,irdec2,ifq2*1.5
  kfam      expseg    1, irfat1*2, p4/4, irfat2*4, p4/8, idur-irfat1*2-irfat2*4, idur
  kfen      expseg    1, irfat1*2, p4/2, irfat2*4, p4/4, idur-irfat1*2-irfat2*4, p4/16
  klfq      oscil     kfam,kfen, 1

  kbw       linseg    p4/20, 1/p4, p4*1.2, irfat2*20, p4/2, idur-1/p4-irfat2*20, p4/8/idur
                  
  aflt1     reson     a1,kafq1*2+klfq, kbw*(p4/20), 2 ;kbw/4
  aflt2     reson     a2,kafq2*2+klfq, kbw*(p4/40), 2 ;kbw/8

  kbw1      oscil     1, 3.5, 1
  kbw1      =  (kbw1+1)/2
  kbw1      =  kbw1*p4*p6*p7
  kbw2      oscil     1, 3.5, 1
  kbw2      =  (kbw2+1)/2
  kbw2      =  kbw2*p4*p6*p7
  kenv1     linseg    .001, idur/p4,1, 8*idur/p4, .8, 10*idur/p4,1,idur-idur/p4-8*idur/p4-10*idur/p4, .001
  kenv2     linseg    .001, idur/p4,1, 12*idur/p4, .6, 8*idur/p4,1,idur-idur/p4-12*idur/p4-8*idur/p4, .001
   
  aflt3     reson     a1*kenv1,kafq1*p7+klfq, kbw1, 2
  aflt4     reson     a2*kenv2,kafq2*p7+klfq, kbw2, 2

  aleft     =  aflt1
  aright    =  aflt2
  afin      =  aflt1+aflt2
  astip1    =  aflt3
  astip2    =  aflt4

  klp1      expseg    p4*3,  7*idur/p4,p4*160,6*idur/p4,160000/p4, idur-7*idur/p4-6*idur/p4, p4*180
  klp2      expseg    p4*2.4,8*idur/p4,p4*180,7*idur/p4,180000/p4, idur-8*idur/p4-7*idur/p4, p4*90 
  klp3      expseg    p4*2,  9*idur/p4,p4*200,8*idur/p4,200000/p4, idur-9*idur/p4-8*idur/p4, p4*45         
        
  alpf      butterlp  afin, klp1                  ; cutting above klp
  alpf2     butterlp  aleft, klp2
  alpf3     butterlp  aright, klp3

  khp1      expseg    32000/p4,4*idur/p4,16000/p4,8*idur/p4,24000/p4,idur-4*idur/p4-8*idur/p4,36000/p4
  khp2      expseg    40000/p4,5*idur/p4,24000/p4,7*idur/p4,36000/p4,idur-5*idur/p4-7*idur/p4,48000/p4
  khp3      expseg    48000/p4,6*idur/p4,32000/p4,6*idur/p4,48000/p4,idur-6*idur/p4-6*idur/p4,64000/p4

  ahpf      butterhp  alpf,  khp1                 ; cutting below khp
  ahpf2     butterhp  alpf2, khp2
  ahpf3     butterhp  alpf3, khp3

  kbp1      oscil     1, p4/5, 1
  kbp1      =  (kbp1+1)/2
  kbp1      =  kbp1*p4*idur*10*p7
  kbp2      oscil     1, p4/5, 1
  kbp2      =  (kbp2+1)/2
  kbp2      =  kbp2*p4*idur*20*p6

  kax1      expseg    p4*10,12*idur/p4,p4*60,8*idur/p4,64000/p4, idur-12*idur/p4-8*idur/p4, p4*200 
  kbp10     expseg    p4/2,12*idur/p4,p4*20,8*idur/p4,8000/p4, idur-12*idur/p4-6*idur/p4, p4*2 

  abpf1     butterbp  ahpf, kax1, kbp10   
       
  kax2      expseg    p4*10,8*idur/p4,p4*40,8*idur/p4,56000/p4, idur-8*idur/p4-8*idur/p4, p4*100 
  kbp20     expseg    p4,8*idur/p4,p4*10,8*idur/p4,6000/p4, idur-8*idur/p4-8*idur/p4, p4*2 

  abpf2     butterbp  ahpf, kax2, kbp20   
       
            outs      (abpf1+astip1)*.6, (abpf2+astip2)*.6

endin


;;----------------------------------------
;;----------------------------------------
;;--------- B - T O M ---4----------------
;;----------------------------------------
;;----------------------------------------
  
instr 14           ;; B-tom_4

  idur      =  p3
  iamp      =  ampdb(p4)*1.1
  ifq1      =  cpspch(p5-1)*5
  ifq2      =  cpspch(p5-1)*7
  if1       =  1
  if2       =  1
  ifmindex  =  p6       
  imax      =  p4/6*ifmindex    
           

  i1f1      =  ifq1*(p4/60)
  i1f2      =  ifq1*(60/p4)
  ifat1     =  .4/p4       
  ifat2     =  .8/p4      
  idec1     =  1.6/p4     
  idec2     =  idur-ifat1-ifat2-idec1

  i2f1      =  ifq2*(p4/60)
  i2f2      =  ifq2*(60/p4)

  iat       =  .4/p4   
  irel1     =  .8/p4   
  irel2     =  idur-iat-irel1
   
  kenv      linseg    0,iat,iamp,irel1,iamp*.2,irel2,0

  kmax      expon     imax*.8, idur, imax*1.6

if (p7==1) kgoto rand1
if (p7>=1.5) kgoto rand2
if (p7<=.5) kgoto short      
           
rand1:
  krand1    randi     imax*(p6/8),p4/10           ;8
  kmax      =  kmax-krand1

            kgoto     cont
rand2:
  krand2    randi     imax*(p6/10),p4/6           ;12
  kmax      =  kmax+krand2

            kgoto     cont
short:
;kf1 expseg ifq1,ifat1,i1f1,ifat2,i1f2,idec1,ifq1, idec2,ifq1*1.8
            kgoto     cont

cont:
  kf2       expseg    ifq2,ifat1,i2f1,ifat2,i2f2,idec1,ifq2*p3*p6, idec2,ifq2/p3/p6
  adyn      oscil     kf2*kmax, 1/idur, 52
  amod      oscil     adyn, ifq2, if2

  kf1       expseg    ifq1,ifat1,i1f1,ifat2,i1f2,idec1,ifq1*p3*p6, idec2,ifq1/p3/p6

  a1        oscil     kenv, kf1 + amod, if1

  i1rf1     =  ifq1*(60/p4)
  i1rf2     =  ifq1*(p4/60)
  i1rf3     =  ifq1*(70/p4)
  i2rf1     =  ifq2*(60/p4)
  i2rf2     =  ifq2*(p4/60)*p3*p6
  i2rf3     =  ifq2*(70/p4)*p3*p6
  irfat1    =  p4/4000
  irfat2    =  p4/2000
  irdec1    =  p4/1000
  irdec2    =  idur-irfat1-irfat2-irdec1

  kafq1     expseg    i1rf1,irfat1,ifq1,irfat2,i1rf2,irdec1,i1rf3,irdec2,ifq1/p3/p6
  kafq2     expseg    i2rf1,irfat1,ifq2,irfat2,i2rf2,irdec1,i2rf3,irdec2,ifq2/p3/p6
  kfam      expseg    1, irfat1, p4/4, irfat2, p4/8, idur-irfat1-irfat2, p4/16
  kfen      expseg    p4, irfat1, p4/4, irfat2, p4/2, idur-irfat1-irfat2, p4
  kfq       oscil     kfam,kfen, 1

  ibw       =  p4*8*p7/p6  
  kbw       expseg    ibw/20, irfat1, ibw, irfat2, ibw/1.4, irdec1, ibw/2,irdec2,ibw/8
  krenv     linseg    0,iat,1,irel1,.2,irel2*.9,0, irel2*.1, 0 

  aflt1     reson     a1*krenv,kafq1+kfq, kbw/1, 2
  aflt2     reson     a1*krenv,kafq2+kfq, kbw/1, 2

  a2        rand      iamp
  ibw2      =  p4*p7/p6
  kbw2      expseg    ibw/20, irfat1, ibw, irfat2, ibw/1.4, irdec1, ibw/2,irdec2,ibw/8   
  aflt3     reson     a2,kafq1*60/p4/p7, kbw2, 2
  aflt4     reson     a2,kafq2*60/p4/p7, kbw2, 2
  krenv2    linseg    0,iat,1,irel1,.02,irel2*.1,0, irel2*.9, 0  
  aflt3     =  aflt3*krenv*p4/80*p6
  aflt4     =  aflt4*krenv*p4/80*p6

  kpan      expseg    .01, idur/2, .2*p6, idur/2, .1
  kbal      randi     kpan, p4/12 
  kbal      oscil     kbal, 1/idur, 1
  kbal      =  .5+kbal
 
  aleft     =  (aflt1+aflt2+aflt3/2)*kbal
  aright    =  (aflt2+aflt1+aflt4/2)*(1-kbal)

            outs      aleft, aright
endin



;;;======================================================

instr 23                  ;; FM_3

  idur      =  p3
  iamp      =  ampdb(p4)
  ifq1      =  cpspch(p5-1)*5
  if1       =  1
  ifq2      =  cpspch(p5-1)*7   
  if2       =  1
  ifmindex  =  p6        
  imax      =  idur*p4/20*ifmindex

  i1f1      =  ifq1*(p4/40)
  i1f2      =  ifq1*(60/p4)
  ifat1     =  1/p4
  ifat2     =  2/p4
  idec1     =  4/p4
  idec2     =  idur-ifat1-ifat2-idec1

  i2f1      =  ifq2*(p4/40)
  i2f2      =  ifq2*(60/p4)

  iat       =  4/p4  
  irel1     =  p4/2000        
  irel2     =  idur-iat-irel1
   
  kenv      linseg    0,iat,iamp,irel1,iamp*.8,irel2,0

  kf2       expseg    i1f1,ifat1,ifq2,ifat2,i1f2,idec1,ifq2/p7, idec2,ifq2*1.1

  kmax      linseg    imax/4,iat,imax*2, idur-iat, imax*20
  kmax      randh     kmax, 7, 1
  kmax      =  imax+kmax
  adyn      oscil     kf2*kmax, 1/idur, 52
  amod      oscil     adyn, ifq2, if2
  kf1       expseg    i2f1,ifat1,ifq1,ifat2,i2f2,idec1,ifq1/p7, idec2,ifq1*1.1
  a1        oscil     kenv, kf1+amod, if1


  kf4       expseg    i1f1*2,ifat1,ifq2*2,ifat2,i1f2*2,idec1,ifq2*2, idec2,ifq2*1.9
  adyn      oscil     2*kf2*kmax, 1/idur, 52
  amod      oscil     adyn, ifq2*2, if2
  kf3       expseg    i2f1*2,ifat1,ifq1*2,ifat2,i2f2*2,idec1,ifq1*2, idec2,ifq1*1.9
  a2        oscil     kenv, 2*kf1 + amod, if1

  i1rf1     =  ifq1                               ;*(40/p4)
  i1rf2     =  ifq1                               ;*(p4/60)
  i1rf3     =  ifq1                               ;*(70/p4)
  i2rf1     =  ifq2                               ;*(40/p4)
  i2rf2     =  ifq2                               ;*(p4/60)
  i2rf3     =  ifq2                               ;*(60/p4)
  irfat1    =  4/p4   
  irfat2    =  8/p4    
  irdec1    =  p4/250
  irdec2    =  idur-irfat1-irfat2-irdec1

  kafq1     expseg    i1rf1*2,irfat1,ifq1*2,irfat2,i1rf2*2,irdec1,i1rf3*2,irdec2,ifq1*2.5
  kafq2     expseg    i2rf1*2,irfat1,ifq2*2,irfat2,i2rf2*2,irdec1,i2rf3*2,irdec2,ifq2*1.5
  kfam      expseg    1, irfat1*2, p4/4, irfat2*4, p4/8, idur-irfat1*2-irfat2*4, idur
  kfen      expseg    1, irfat1*2, p4/2, irfat2*4, p4/4, idur-irfat1*2-irfat2*4, p4/16
  klfq      oscil     kfam,kfen, 1

  kbw       linseg    p4/2, 1/p4, p4*2, irfat2, p4/2, idur-1/p4-irfat2, p4/4/idur
;;kbw  linseg p4/20, 1/p4, p4*1.2, irfat2*20, p4/2, idur-1/p4-irfat2*20, p4/8/idur
  aflt1     reson     a1,kafq1+klfq, kbw*(p4/20), 2   
  aflt2     reson     a2,kafq2+klfq, kbw, 2   
  kenvr     linseg    1, idur*.98, 1, idur*.01, 0, idur*.01,0
  aflt1     =  aflt1*kenvr
  aflt2     =  aflt2*kenvr
  kbw1      oscil     1, p4/10, 1    
  kbw1      =  (kbw1+1)/2
  kbw1      =  kbw1*p4*p6/p7
  kbw2      oscil     1, p4/10, 1    
  kbw2      =  (kbw2+1)/2
  kbw2      =  kbw2*p4/p6*p7

  aflt3     reson     a1,kafq1*p6*p7+klfq, kbw1, 2
  aflt4     reson     a1,kafq2*p6*p7+klfq, kbw2, 2

  aleft     =  aflt1
  aright    =  aflt2
  afin      =  aflt1+aflt2
  astip1    =  aflt3
  astip2    =  aflt4

  klp1      expseg    p4*3,  7*idur/p4,p4*160,6*idur/p4,160000/p4, idur-7*idur/p4-6*idur/p4, p4*180

  klp2      expseg    p4*2.40,  32/p4,p4*180,7*idur/p4,180000/p4, idur-32/p4-7*idur/p4, p4*90 
;;klp2 expseg p4*2.4,8*idur/p4,p4*180,7*idur/p4,180000/p4, idur-8*idur/p4-7*idur/p4, p4*90 

  klp3      expseg    p4*2,  9*idur/p4,p4*200,8*idur/p4,200000/p4, idur-9*idur/p4-8*idur/p4, p4*45         
        
  alpf      butterlp  afin, klp1                  ; cutting above klp
  alpf2     butterlp  aleft, klp2
  alpf3     butterlp  aright, klp3

  khp1      expseg    32000/p4,4*idur/p4,16000/p4,8*idur/p4,24000/p4,idur-4*idur/p4-8*idur/p4,36000/p4

  khp2      expseg    40000/p4,20/p4,24000/p4,7*idur/p4,36000/p4,idur-20/p4-7*idur/p4,48000/p4

  khp3      expseg    48000/p4,6*idur/p4,32000/p4,6*idur/p4,48000/p4,idur-6*idur/p4-6*idur/p4,64000/p4

  ahpf      butterhp  alpf,  khp1                 ; cutting below khp
  ahpf2     butterhp  alpf2, khp2
  ahpf3     butterhp  alpf3, khp3

  kbp1      oscil     1, p4/10, 1
  kbp1      =  (kbp1+.1)/2
  kbp1      =  kbp1*p4*idur
  kbp2      oscil     1, p4/10, 1
  kbp2      =  (kbp2+.1)/2
  kbp2      =  kbp2*p4*idur
  kax1      expseg    p4*20,12*idur/p4,p4*40,6*idur/p4,64000/p4, idur-12*idur/p4-6*idur/p4, p4*200 
  kbp10     expseg    p4*2,12*idur/p4,p4*10,6*idur/p4,8000/p4, idur-12*idur/p4-6*idur/p4, p4*2 

  abpf1     butterbp  alpf, kax1, kbp10           ; passing area ?Hz
       
  kax2      expseg    p4*20,14*idur/p4,p4*40,8*idur/p4,64000/p4, idur-14*idur/p4-8*idur/p4, p4*200 
  kbp20     expseg    p4*2,14*idur/p4,p4*10,8*idur/p4,8000/p4, idur-14*idur/p4-8*idur/p4, p4*2 

  abpf2     butterbp  alpf, kax2, kbp20           ; passing area ?Hz

  kbal      line      .01, idur, .2*p7       
  kbal      randi     kbal, 7
  kbal      oscil     kbal, 1/idur, 1
  kbal      =  .5+kbal

            outs      ahpf2*kbal, ahpf2*(1-kbal)

endin


;----------------------------

instr 9      ;; Timp_11

  idur      =  p3
  iamp      =  ampdb(p4)/2
  ifq1      =  cpspch(p5-1)*5
  if1       =  1
  ifq2      =  cpspch(p5-1)*7
  if2       =  1
  ifmindex  =  p6        
  imax      =  (idur*p4/40)*ifmindex

  i1f1      =  ifq1*(p4/40)
  i1f2      =  ifq1*(60/p4)
  ifat1     =  1/p4                               ;1/p4
  ifat2     =  2/p4                               ;2/p4
  idec1     =  4/p4                               ;4/p4
  idec2     =  idur-ifat1-ifat2-idec1

  i2f1      =  ifq2*(p4/40)
  i2f2      =  ifq2*(60/p4)

  iat       =  1.6/p4 
  irel1     =  p4/100        
  irel2     =  idur-iat-irel1
   ;aenv  oscil  iamp, 1/idur, 51
  kenv      linseg    0,iat,iamp,irel1,iamp*.8,irel2,0

  kf2       expseg    i1f1,ifat1,ifq2,ifat2,i1f2,idec1,ifq2, idec2,ifq2*1.1
  adyn      oscil     kf2*imax, 1/idur, 52
  amod      oscil     adyn, ifq2, if2
  kf1       expseg    i2f1,ifat1,ifq1,ifat2,i2f2,idec1,ifq1, idec2,ifq1*1.1
  a1        oscil     kenv, kf1+amod, if1

  kf4       expseg    i1f1*2,ifat1,ifq2*2,ifat2,i1f2*2,idec1,ifq2*2, idec2,ifq2*1.9
  adyn      oscil     2*kf2*imax, 1/idur, 52
  amod      oscil     adyn, ifq2*2, if2
  kf3       expseg    i2f1*2,ifat1,ifq1*2,ifat2,i2f2*2,idec1,ifq1*2, idec2,ifq1*1.9
  a2        oscil     kenv, 2*kf1 + amod, if1

  i1rf1     =  ifq1*(40/p4)
  i1rf2     =  ifq1*(p4/60)
  i1rf3     =  ifq1*(70/p4)
  i2rf1     =  ifq2*(40/p4)
  i2rf2     =  ifq2*(p4/60)
  i2rf3     =  ifq2*(60/p4)
  irfat1    =  p4/500                             ;p4/1000
  irfat2    =  p4/250                             ;p4/500
  irdec1    =  p4/125                             ;p4/250
  irdec2    =  idur-irfat1-irfat2-irdec1

  kafq1     expseg    i1rf1*2,irfat1,ifq1*2,irfat2,i1rf2*2,irdec1,i1rf3*2,irdec2,ifq1*2.5
  kafq2     expseg    i2rf1*2,irfat1,ifq2*2,irfat2,i2rf2*2,irdec1,i2rf3*2,irdec2,ifq2*1.5
  kfam      expseg    1, irfat1*2, p4/4, irfat2*4, p4/8, idur-irfat1*2-irfat2*4, idur
  kfen      expseg    1, irfat1*2, p4/2, irfat2*4, p4/4, idur-irfat1*2-irfat2*4, p4/16
  klfq      oscil     kfam,kfen, 1

  kbw       linseg    p4/20, 1/p4, p4*1.2, irfat2*20, p4/2, idur-1/p4-irfat2*20, p4/8/idur
                  
  kbw1      oscil     1, 3.5*p8, 1
  kbw1      =  (kbw1+1)/2
  kbw1      =  kbw1*p4*p6*p7
  kbw2      oscil     1, 3.5*p8, 1
  kbw2      =  (kbw2+1)/2
  kbw2      =  kbw2*p4*p6*p7
               
  aflt1     reson     a1,kafq1*p6+klfq, kbw1, 2  
  aflt2     reson     a2,kafq2*p6+klfq, kbw2, 2        

  kbw3      oscil     1, 3.5, 1
  kbw3      =  (kbw3+1)/2
  kbw3      =  kbw3*p4*p6                         ;*p7
  kbw4      oscil     1, 3.5, 1
  kbw4      =  (kbw4+1)/2
  kbw4      =  kbw4*p4*p6                         ;*p7
  kenv1     linseg    .001, idur/p4,1, 8*idur/p4, .8,10*idur/p4,1,idur-idur/p4-8*idur/p4-10*idur/p4, .01
  kenv2     linseg    .001, idur/p4,1, 12*idur/p4, .6,8*idur/p4,1,idur-idur/p4-12*idur/p4-8*idur/p4, .01
   ;;aflt3  reson  a1*kenv1,kafq1*3*p7+klfq, kbw1, 2
   ;;aflt4  reson  a2*kenv2,kafq2*3*p7+klfq, kbw2, 2
  aflt3     reson     a1*kenv1,kafq1*p7+klfq, kbw3, 2
  aflt4     reson     a2*kenv2,kafq2*p7+klfq, kbw4, 2

  aleft     =  aflt1
  aright    =  aflt2
  afin      =  aflt1+aflt2
  astip1    =  aflt3
  astip2    =  aflt4

  klp1      expseg    p4*3,  7*idur/p4,p4*160,6*idur/p4,160000/p4, idur-7*idur/p4-6*idur/p4, p4*180
  klp2      expseg    p4*2.4,8*idur/p4,p4*180,7*idur/p4,180000/p4, idur-8*idur/p4-7*idur/p4, p4*90 
  klp3      expseg    p4*2,  9*idur/p4,p4*200,8*idur/p4,200000/p4, idur-9*idur/p4-8*idur/p4, p4*45         
        
  alpf      butterlp  afin, klp1 
  alpf2     butterlp  aleft, klp2
  alpf3     butterlp  aright, klp3

  khp1      expseg    32000/p4,4*idur/p4,16000/p4,8*idur/p4,24000/p4,idur-4*idur/p4-8*idur/p4,36000/p4
  khp2      expseg    40000/p4,5*idur/p4,24000/p4,7*idur/p4,36000/p4,idur-5*idur/p4-7*idur/p4,48000/p4
  khp3      expseg    48000/p4,6*idur/p4,32000/p4,6*idur/p4,48000/p4,idur-6*idur/p4-6*idur/p4,64000/p4

  ahpf      butterhp  alpf,  khp1 
  ahpf2     butterhp  alpf2, khp2
  ahpf3     butterhp  alpf3, khp3

  kbp1      oscil     1, 3.5*p8, 1
  kbp1      =  (kbp1+1)/2
  kbp1      =  kbp1*p4*idur*8*p7
  kbp2      oscil     1, 3.5*p8, 1
  kbp2      =  (kbp2+1)/2*p8
  kbp2      =  kbp2*p4*idur*4*p6

  kax1      expseg    p4*10,12*idur/p4,p4*60,8*idur/p4,64000/p4, idur-12*idur/p4-8*idur/p4, p4*200 
  kbp10     expseg    p4/2,12*idur/p4,p4*20,8*idur/p4,8000/p4, idur-12*idur/p4-6*idur/p4, p4*2 

  abpf1     butterbp  ahpf, kax1, kbp1            ; passing area ?Hz
       
  kax2      expseg    p4*10,8*idur/p4,p4*40,8*idur/p4,56000/p4, idur-8*idur/p4-8*idur/p4, p4*100 
  kbp20     expseg    p4,8*idur/p4,p4*10,8*idur/p4,6000/p4, idur-8*idur/p4-8*idur/p4, p4*2 

  abpf2     butterbp  ahpf, kax2, kbp2            ; passing area ?Hz
       

  kbal      line      .01, idur, .1*p7
  kbal      oscil     kbal, 1/idur, 1
  kbal      =  .5+kbal

            outs      abpf1*kbal, abpf2*(1-kbal)

endin


;;-----------------------------
;;-----------------------------

instr 10   ;; Timp_91

  idur      =  p3
  iamp      =  ampdb(p4)/2
  ifq1      =  cpspch(p5-1)*5
  if1       =  1
  ifq2      =  cpspch(p5-1)*7
  if2       =  1
  ifmindex  =  p6        
  imax      =  (idur*p4/30)*ifmindex

  i1f1      =  ifq1*(p4/40)
  i1f2      =  ifq1*(60/p4)
  ifat1     =  1/p4                               ;1/p4
  ifat2     =  2/p4                               ;2/p4
  idec1     =  4/p4                               ;4/p4
  idec2     =  idur-ifat1-ifat2-idec1

  i2f1      =  ifq2*(p4/40)
  i2f2      =  ifq2*(60/p4)

  iat       =  1.6/p4 
  irel1     =  p4/100        
  irel2     =  idur-iat-irel1
   ;aenv  oscil  iamp, 1/idur, 51
  kenv      linseg    0,iat,iamp,irel1,iamp*.6,irel2,0

  kf2       expseg    i1f1,ifat1,ifq2,ifat2,i1f2,idec1,ifq2, idec2,ifq2*1.1
  adyn      oscil     kf2*imax, 1/idur, 52
  amod      oscil     adyn, ifq2, if2
  kf1       expseg    i2f1,ifat1,ifq1,ifat2,i2f2,idec1,ifq1, idec2,ifq1*1.1
  a1        oscil     kenv, kf1+amod, if1

  kf4       expseg    i1f1*2,ifat1,ifq2*2,ifat2,i1f2*2,idec1,ifq2*2, idec2,ifq2*1.9
  adyn      oscil     2*kf2*imax, 1/idur, 52
  amod      oscil     adyn, ifq2*2, if2
  kf3       expseg    i2f1*2,ifat1,ifq1*2,ifat2,i2f2*2,idec1,ifq1*2, idec2,ifq1*1.9
  a2        oscil     kenv, 2*kf1 + amod, if1

  i1rf1     =  ifq1*(40/p4)
  i1rf2     =  ifq1*(p4/60)
  i1rf3     =  ifq1*(70/p4)
  i2rf1     =  ifq2*(40/p4)
  i2rf2     =  ifq2*(p4/60)
  i2rf3     =  ifq2*(60/p4)
  irfat1    =  p4/500                             ;p4/1000
  irfat2    =  p4/250                             ;p4/500
  irdec1    =  p4/125                             ;p4/250
  irdec2    =  idur-irfat1-irfat2-irdec1

  kafq1     expseg    i1rf1*2,irfat1,ifq1*2,irfat2,i1rf2*2,irdec1,i1rf3*2,irdec2,ifq1*2.5
  kafq2     expseg    i2rf1*2,irfat1,ifq2*2,irfat2,i2rf2*2,irdec1,i2rf3*2,irdec2,ifq2*1.5
  kfam      expseg    1, irfat1*2, p4/4, irfat2*4, p4/8, idur-irfat1*2-irfat2*4, idur
  kfen      expseg    1, irfat1*2, p4/2, irfat2*4, p4/4, idur-irfat1*2-irfat2*4, p4/16
;;klfq  oscil kfam,kfen, 1

  kren      line      1, idur, .4
  klfq1     randh     p7*kafq1*kren, p4/10*p6     ; .8*idur*p6 
  kbw       linseg    p4/20, 1/p4, p4*1.2, irfat2*20, p4/2, idur-1/p4-irfat2*20, p4/8/idur
                  
  aflt1     reson     a1,kafq1*2+klfq1, kbw*(p4/20), 2 ;kbw/4
  aflt2     reson     a2,kafq2*2+klfq1, kbw*(p4/40), 2 ;kbw/8

  kbw1      oscil     1, p4/9.6, 1
  kbw1      =  (kbw1+1)/2
  kbw1      =  kbw1*p4*p6*p7
  kbw2      oscil     1, p4/10.4, 1
  kbw2      =  (kbw2+1)/2
  kbw2      =  kbw2*p4*p6*p7

;;kenv1 linseg .001, idur/p4,1, 8*idur/p4, ..8,10*idur/p4,1,idur-idur/p4-8*idur/p4-10*idur/p4, .001
;;kenv2 linseg .001, idur/p4,1, 12*idur/p4, ..6,8*idur/p4,1,idur-idur/p4-12*idur/p4-8*idur/p4, .001

  kenv22    linseg    0,iat*1.6,.1,irel1,1,idur-iat*1.6-irel1,0
  kenv1     oscil     1 , 1/idur, 1 
  kenv2     oscil     kenv22, 1/idur, 1, .25
  klfq3     randh     kafq2*p7, idur*p6
  klfq4     randh     kafq2*p7*kenv22, idur*p6
  aflt3     reson     a1*kenv1,kafq1*4*p7+klfq3, kbw1, 2
  aflt4     reson     a2*kenv2,kafq2*4*p7+klfq4, kbw2, 2

  aleft     =  aflt1
  aright    =  aflt2
  afin      =  aflt1+aflt2
  astip1    =  aflt3
  astip2    =  aflt4

  klp1      expseg    p4*3,  7*idur/p4,p4*160,6*idur/p4,160000/p4, idur-7*idur/p4-6*idur/p4, p4*180
  klp2      expseg    p4*2.4,8*idur/p4,p4*180,7*idur/p4,180000/p4, idur-8*idur/p4-7*idur/p4, p4*90 
  klp3      expseg    p4*2,  9*idur/p4,p4*200,8*idur/p4,200000/p4, idur-9*idur/p4-8*idur/p4, p4*45         
        
  alpf      butterlp  afin, klp1 
  alpf2     butterlp  aleft, klp2
  alpf3     butterlp  aright, klp3

  khp1      expseg    32000/p4,4*idur/p4,16000/p4,8*idur/p4,24000/p4,idur-4*idur/p4-8*idur/p4,36000/p4
  khp2      expseg    40000/p4,5*idur/p4,24000/p4,7*idur/p4,36000/p4,idur-5*idur/p4-7*idur/p4,48000/p4
  khp3      expseg    48000/p4,6*idur/p4,32000/p4,6*idur/p4,48000/p4,idur-6*idur/p4-6*idur/p4,64000/p4

  ahpf      butterhp  alpf,  khp1 
  ahpf2     butterhp  alpf2, khp2
  ahpf3     butterhp  alpf3, khp3

  kbp1      oscil     1, p4/5.1, 1
  kbp1      =  (kbp1+1)/2
  kbp1      =  kbp1*p4*idur*p7
  kbp2      oscil     1, p4/4.9, 1
  kbp2      =  (kbp2+1)/2
  kbp2      =  kbp2*p4*idur*p6

  kax1      expseg    p4*80,12*idur/p4,p4*60,8*idur/p4,64000/p4, idur-12*idur/p4-8*idur/p4, p4*200 

  abpf1     butterbp  aleft, kax1, kbp1 
       
  kax2      expseg    p4*60,8*idur/p4,p4*40,8*idur/p4,56000/p4, idur-8*idur/p4-8*idur/p4, p4*100 

  abpf2     butterbp  aright, kax2, kbp2 
       
            outs      ahpf2+astip2+abpf2, ahpf3+astip1*.8+abpf1

endin


;;----------------------------------------
;;----------------------------------------
;;--------- B - T O M ---5----------------   
;;----------------------------------------
;;----------------------------------------
  
instr 15              ;; B-tom_5

  idur      =  p3
  iamp      =  ampdb(p4)*1.1

  ifq1      =  cpspch(p5)*5
  ifq2      =  cpspch(p5)*7
  if1       =  1
  if2       =  1
  ifmindex  =  p6                                 ; 1.0 - 3.0     
  imax      =  p4/6*ifmindex 
           
  i1f1      =  ifq1*(p4/60)
  i1f2      =  ifq1*(60/p4)
  ifat1     =  .4/p4       
  ifat2     =  .8/p4      
  idec1     =  1.6/p4     
  idec2     =  idur-ifat1-ifat2-idec1

  i2f1      =  ifq2*(p4/60)
  i2f2      =  ifq2*(60/p4)

  iat       =  .8/p4   
  irel1     =  .8/p4   
  irel2     =  idur-iat-irel1
   
  kenv      linseg    0,iat,iamp,irel1,iamp*.2,irel2,0

  kmax      expon     imax*.8, idur, imax*1.6

if (p7==1) kgoto rand1
if (p7>=1.5) kgoto rand2
if (p7<=.5) kgoto short      
           
rand1:
  krand1    randi     imax*(p6/8),p4/10           ;8
  kmax      =  kmax-krand1

            kgoto     cont
rand2:
  krand2    randi     imax*(p6/10),p4/6           ;12
  kmax      =  kmax+krand2
            kgoto     cont
short:
;kf1 expseg ifq1,ifat1,i1f1,ifat2,i1f2,idec1,ifq1, idec2,ifq1*1.8
            kgoto     cont

cont:
  kf2       expseg    ifq2+.0001,ifat1,i2f1,ifat2,i2f2,idec1,ifq2*p3*p6, idec2,ifq2/p3/p6
  adyn      oscil     kf2*kmax, 1/idur, 52
  amod      oscil     adyn, ifq2, if2

  kf1       expseg    ifq1+.0001,ifat1,i1f1,ifat2,i1f2,idec1,ifq1*p3*p6, idec2,ifq1/p3/p6

  a1        oscil     kenv, kf1 + amod, if1

  i1rf1     =  ifq1*(60/p4)
  i1rf2     =  ifq1*(p4/60)
  i1rf3     =  ifq1*(70/p4)
  i2rf1     =  ifq2*(60/p4)
  i2rf2     =  ifq2*(p4/60)*p3*p6
  i2rf3     =  ifq2*(70/p4)*p3*p6
  irfat1    =  p4/4000
  irfat2    =  p4/2000
  irdec1    =  p4/1000
  irdec2    =  idur-irfat1-irfat2-irdec1

  kafq1     expseg    i1rf1,irfat1,ifq1,irfat2,i1rf2,irdec1,i1rf3,irdec2,ifq1/p3/p6
  kafq2     expseg    i2rf1,irfat1,ifq2,irfat2,i2rf2,irdec1,i2rf3,irdec2,ifq2/p3/p6
  kfam      expseg    1, irfat1, p4/4, irfat2, p4/8, idur-irfat1-irfat2, p4/16
  kfen      expseg    p4, irfat1, p4/4, irfat2, p4/2, idur-irfat1-irfat2, p4
  kfq       oscil     kfam,kfen, 1

  ibw       =  p4*4*p7/p6
  kbw       expseg    ibw/20, irfat1, ibw, irfat2, ibw/1.4, irdec1, ibw/2,irdec2,ibw/8
  krenv     linseg    0,iat,1,irel1,.2,irel2*.9,0, irel2*.1, 0 

  aflt1     reson     a1*krenv,kafq1+kfq, kbw/1, 2
  aflt2     reson     a1*krenv,kafq2+kfq, kbw/1, 2

  a2        rand      iamp
  ibw2      =  p4*p7/p6
  kbw2      expseg    ibw/20, irfat1, ibw, irfat2, ibw/1.4, irdec1, ibw/2,irdec2,ibw/8   
  aflt3     reson     a2,kafq1*60/p4/p7, kbw2, 2
  aflt4     reson     a2,kafq2*60/p4/p7, kbw2, 2
  krenv2    linseg    0,iat,1,irel1,.02,irel2*.1,0, irel2*.9, 0  
  aflt3     =  aflt3*krenv*p4/80*p6
  aflt4     =  aflt4*krenv*p4/80*p6

  kpan      expseg    .01, idur/2, .2*p6, idur/2, .1
  kbal      randi     kpan, p4/12 
  kbal      oscil     kbal, 1/idur, 1
  kbal      =  .5+kbal

  aleft     =  (aflt1+aflt2)*kbal
  aright    =  (aflt2+aflt1)*(1-kbal)

            outs      aleft, aright
endin





;steven sodders           dexter morrill trumpet            tpt.orc
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1
;                          INSTRUMENT 1 BLOCK                         
instr     1
  ifc1      =  p4                                 ;CARRIER FRQ
  ifc2      =  p6                                 ;FORMANT FRQ
  ifm       =  ifc1                               ;CARFRQ:MODFRQ 1:1
  iamp      =  p5                                 ;AMPLITUDE
  iratio    =  1.8/2.66
  idur      =  p3

  kvibwth   envlpx    .006,.8,1,.3,5,1.7,.01,.7   ;VIBWIDTH=.007
  kport     oscil1i   0,.03,p3,4                  ;PORTDEV=.03
  avsig     oscil     kvibwth,5,1                 ;VIBRATE=7CPS
  kfrqdev   randi     .007,125                    ;RANDEV=.007,FRQ
  avib      =  (kfrqdev+1)*(avsig+1)*(kport+1)
  kindex    envlpx    2.66*ifm,.08,idur,.01,3,1.2,.7,.7 ;MAXINDEX = 2.66
  amodsig   oscil     kindex,ifm*avib,1
  kfgate    envlpx    iamp*.2,.03,idur,.3,2,1,.01 ;FORMANT GATE             
  kpgate    envlpx    iamp,.03,idur,.15,2,1,.01   ;FUNDAMENTAL GATE
  aform     oscili    kfgate,((ifc2*avib)+(amodsig*iratio)),1
  apitch    oscili    kpgate,((ifc1*avib)+amodsig),1
  asig      =  apitch+aform
            out       asig
endin               
                                                     
                               
        
                

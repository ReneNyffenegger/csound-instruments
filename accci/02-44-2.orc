; ************************************************************************
; ACCCI:      02-44-2.ORC
; synthesis:  additive, same building blocks(02)
;             continuous pitch control and amp control(44)
; source:     endless.orc   MIT 1993
; notes:      Prior to running this, make sure that the table 
;             with the bell-shaped function that controls the amplitudes
;             has been created: 88-01-2.TAB
; coded:      jpg 10/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *****************************************************************
  idur      =  p3
  iamp      =  p4
  ifq       =  p5
  icycle    =  p6

if (ifq >= 20) igoto    continue
  ifq       =  cpspch (p5)                        ; optional: p5 in oct.pch
continue:
  kphase    phasor    1/icycle                    ; speed at which tables are scanned
  kenvlp    linen     iamp, 1, idur, 1

  kamp1     table     kphase,71,1,0,1
  kcps1     tablei    kphase,51,1,0,1
  asig1     oscili    kamp1,kcps1*ifq,1

  kamp2     table     kphase+.1,71,1,0,1
  kcps2     tablei    kphase+.1,51,1,0,1
  asig2     oscili    kamp2,kcps2*ifq,1

  kamp3     table     kphase+.2,71,1,0,1
  kcps3     tablei    kphase+.2,51,1,0,1
  asig3     oscili    kamp3,kcps3*ifq,1

  kamp4     table     kphase+.3,71,1,0,1
  kcps4     tablei    kphase+.3,51,1,0,1
  asig4     oscili    kamp4,kcps4*ifq,1

  kamp5     table     kphase+.4,71,1,0,1
  kcps5     tablei    kphase+.4,51,1,0,1
  asig5     oscili    kamp5,kcps5*ifq,1

  kamp6     table     kphase+.5,71,1,0,1
  kcps6     tablei    kphase+.5,51,1,0,1
  asig6     oscili    kamp6,kcps6*ifq,1

  kamp7     table     kphase+.6,71,1,0,1
  kcps7     tablei    kphase+.6,51,1,0,1
  asig7     oscili    kamp7,kcps7*ifq,1

  kamp8     table     kphase+.7,71,1,0,1
  kcps8     tablei    kphase+.7,51,1,0,1
  asig8     oscili    kamp8,kcps8*ifq,1

  kamp9     table     kphase+.8,71,1,0,1
  kcps9     tablei    kphase+.8,51,1,0,1
  asig9     oscili    kamp9,kcps9*ifq,1

  kamp10    table     kphase+.9,71,1,0,1
  kcps10    tablei    kphase+.9,51,1,0,1
  asig10    oscili    kamp10,kcps10*ifq,1

  asum      =  asig1+asig2+asig3+asig4+asig5+asig6+asig7+asig8+asig9+asig10
            out       asum*kenvlp                 ; apply envelope    
endin

;---------------------------;
; Pinkston: FM Instrument 2 ;
;---------------------------;

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr   2       ;better simple FM instrument
  isine     =  1                                  ;f01 has a sine wave - best for simple FM
  iamp      =  p4                                 ;peak amp of carrier
  ihz0      =  cpspch(p5)+p18                     ;basic pitch + detune
  icfac     =  p6                                 ;carrier factor
  imfac     =  p7                                 ;modulator factor
  index     =  p8                                 ;maximum index value
  ieva      =  p9                                 ;attack time of main envelope
  ievd      =  p10                                ;decay time of main envelope
  iamp2     =  p11*iamp                           ;main amp sustain level
  ievr      =  p12                                ;release time of main envelope
  ievss     =  p3-ieva-ievd-ievr                  ;env steady state
  indx1     =  p13*index                          ;initial/final index
  idxa      =  p14                                ;attack time of index
  idxd      =  p15                                ;decay time of index
  indx2     =  p16*index                          ;sustained index
  idxr      =  p17                                ;release time of index
  idxss     =  p3-idxa-idxd-idxr                  ;index steady state
  kndx      linseg    indx1,idxa,index,idxd,indx2,idxss,indx2,idxr,indx1      
  kamp      linseg    0,ieva,iamp,ievd,iamp2,ievss,iamp2,ievr,0       
  asig      foscili   kamp,ihz0,icfac,imfac,kndx,isine        
            out       asig    
endin           

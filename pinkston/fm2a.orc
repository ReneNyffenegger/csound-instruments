;----------------------------;
; Pinkston: FM Instrument 2a ;
;----------------------------;

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr   2               ;simple PM instrument
  isine     =  1                                  ;f01 has a sine wave
  iamp      =  p4                                 ;peak amp of carrier
  ihz0      =  cpspch(p5)+p18                     ;theoretical fundamental+detune
  icfac     =  p6                                 ;carrier factor
  imfac     =  p7                                 ;modulator factor
  i2pi      =  6.2832                             ;2 PI radians per cycle
  indx      =  p8/i2pi                            ;maximum index value/2PI
  ieva      =  p9                                 ;attack time of main envelope
  ievd      =  p10                                ;decay time of main envelope
  iamp2     =  p11*iamp                           ;main amp sustain level
  ievr      =  p12                                ;release time of main envelope
  ievss     =  p3-ieva-ievd-ievr                  ;env steady state
  indx1     =  p13*indx                           ;initial/final index
  idxa      =  p14                                ;attack time of index
  idxd      =  p15                                ;decay time of index
  indx2     =  p16*indx                           ;sustained index
  idxr      =  p17                                ;release time of index
  idxss     =  p3-idxa-idxd-idxr                  ;index steady state
  kndx      linseg    indx1,idxa,indx,idxd,indx2,idxss,indx2,idxr,indx1       
  kamp      linseg    0,ieva,iamp,ievd,iamp2,ievss,iamp2,ievr,0       
  amodsig   oscili    kndx,ihz0*imfac,isine       ;the modulator
  acarphs   phasor    ihz0*icfac                  ;moving phase at the carrier frequency
;Phase modulation of carrier takes place here:                  
  asig      tablei    acarphs+amodsig,isine,1,0,1 ; normalized index and wrap flag on
            out       asig*kamp                   ;apply the envlp here
endin           


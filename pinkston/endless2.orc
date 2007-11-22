;===========================================;
; Dodge/Risset Endless Glissando Instrument ;
; Coded by Russell Pinkston                 ;
;===========================================;                           
  sr        =  44100                           
  kr        =  4410                            
  ksmps     =  10                              
  nchnls    =  1               
                
instr   1                               
  iampfn    =  2                                  ;bell-shaped amplitude function
  iglissfn  =  3                                  ;10-octave gliss control function       
  ifreq     =  p5                                 ;p5 can either by pch or cps    
if (ifreq >= 20) igoto continue                   ;assume ifreq in cps if > 20    
  ifreq     =  cpspch(p5)                         ;p5 must be in oct.pch  
continue:                                                                               
  kphase    phasor    1/p6                        ;p6 is duration of complete 10-octave cycle     
  kenvlp    linen     p4,1,p3,1                               
;Ten octaves of sine waves; each oscili gets amp and cps args from tables
  kamp1     table     kphase,iampfn,1,0,1         ;kphase used for both tables    
  kcps1     tablei    kphase,iglissfn,1,0,1                           
  asig1     oscili    kamp1,kcps1*ifreq,1                             
  kamp2     table     kphase+.1,iampfn,1,0,1      ;kphase is offset by 10%        
  kcps2     tablei    kphase+.1,iglissfn,1,0,1                                
  asig2     oscili    kamp2,kcps2*ifreq,1                             
  kamp3     table     kphase+.2,iampfn,1,0,1      ;kphase offset by 20%   
  kcps3     tablei    kphase+.2,iglissfn,1,0,1                                
  asig3     oscili    kamp3,kcps3*ifreq,1                             
  kamp4     table     kphase+.3,iampfn,1,0,1      ;kphase offset by 30%   
  kcps4     tablei    kphase+.3,iglissfn,1,0,1                                
  asig4     oscili    kamp4,kcps4*ifreq,1                             
  kamp5     table     kphase+.4,iampfn,1,0,1      ;kphase offset by 40%   
  kcps5     tablei    kphase+.4,iglissfn,1,0,1                                
  asig5     oscili    kamp5,kcps5*ifreq,1                             
  kamp6     table     kphase+.5,iampfn,1,0,1      ;kphase offset by 50%   
  kcps6     tablei    kphase+.5,iglissfn,1,0,1                                
  asig6     oscili    kamp6,kcps6*ifreq,1                             
  kamp7     table     kphase+.6,iampfn,1,0,1      ;kphase offset by 60%   
  kcps7     tablei    kphase+.6,iglissfn,1,0,1                                
  asig7     oscili    kamp7,kcps7*ifreq,1                             
  kamp8     table     kphase+.7,iampfn,1,0,1      ;kphase offset by 70%   
  kcps8     tablei    kphase+.7,iglissfn,1,0,1                                
  asig8     oscili    kamp8,kcps8*ifreq,1                             
  kamp9     table     kphase+.8,iampfn,1,0,1      ;kphase offset by 80%   
  kcps9     tablei    kphase+.8,iglissfn,1,0,1                                
  asig9     oscili    kamp9,kcps9*ifreq,1                             
  kamp10    table     kphase+.9,iampfn,1,0,1      ;kphase offset by 90%   
  kcps10    tablei    kphase+.9,iglissfn,1,0,1                                
  asig10    oscili    kamp10,kcps10*ifreq,1                           
  asum      =  asig1+asig2+asig3+asig4+asig5+asig6+asig7+asig8+asig9+asig10
            out       asum*kenvlp                 ;envelope & output the sum of all 10 sine waves
endin


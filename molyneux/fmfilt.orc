;***************************************************************;
;         FM FILTER ORCHESTRA                
;    P3  = DURATION      
;       P4  = AMPLITUDE
;    P5  = PITCH IN PCH
;    P6  = STARTING MOD TO CAR RATIO    
;    P7  = ENDING MOD TO CAR RATIO
;    P8  = FUNCTION NUMBER FOR RATIO CHANGE                           
;    P9  = STARTING INDEX LEVEL         
;    P10 = ENDING INDEX LEVEL                     
;    P11 = FUNCTION NUMBER FOR RATIO CHANGE                           
;    P12 = STARTING CENTER FREQUENCY    
;    P13 = ENDING CENTER FREQ                          
;    P14 = FUNCTION NUMBER FOR CF CHANGE                              
;    P15 = STARTING BAND WIDTH     
;    P16 = ENDING BAND WIDTH                           
;    P17 = FUNCTION NUMBER FOR BW CHANGE
;**************************************************************;
  sr        =  44100
  kr        =  44100
  ksmps     =  1 
  nchnls    =  1
          
instr          1
  ipitch1   =  cpspch(p5)
  ipitch2   =  ipitch1 * 1.001
  ipitch3   =  ipitch1 * 0.998
  imodbase  =  (p6 <= p7 ? p6 : p7)
  imodmax   =  (p6 <= p7 ? p7 : p6)
  indxbase  =  (p9 <= p10 ? p9 : p10)
  indxmax   =  (p9 <= p10 ? p10 : p9)
  kmodchg   oscil1i   0.00,(imodmax - imodbase),p3,p8
  kmod      =  imodbase + kmodchg
  kndxchg   oscil1i   0.00,(indxmax - indxbase),p3,p11
  kndx      =  indxbase + kndxchg
  afm1      foscili   (p4*.45),ipitch1,1,kmod,kndx,1
  afm2      foscili   (p4*.35),ipitch2,1,kmod,kndx,1
  afm3      foscili   (p4*.32),ipitch3,1,kmod,kndx,1
  afmttl    =  afm1+afm2+afm3
  aosc1     oscil     (p4 *.45),ipitch1,1
  aosc2     oscil     (p4 *.35),ipitch2,1
  aosc3     oscil     (p4 *.32),ipitch3,1
  aoscttl   =  aosc1+aosc2+aosc3
  afm       =  afmttl - aoscttl
                    ;    print     ipitch1,ipitch2,ipitch3
                    ;    print     imodbase,imodmax,indxbase,indxmax
  icfbase   =  (p12 <= p13 ? p12 : p13)
  icfmax    =  (p12 <= p13 ? p13 : p12)
  kcfchg    oscil1i   0.00,(icfmax - icfbase),p3,p14
  kcf       =  icfbase + kcfchg
  ibwbase   =  (p15 <= p16 ? p15 : p16)
  ibwmax    =  (p15 <= p16 ? p16 : p15)
  kbwchg    oscil1i   0.00,(ibwmax - ibwbase),p3,p17
  kbw       =  ibwbase + kbwchg
  aflt1     reson     afm,kcf,kbw,1
  aflt2     reson     afm,(kcf*.9),(kbw*1.11),1
  abal      balance   (aflt1+aflt2),afm
  asig      envlpx    abal,.2,p3,(p3*.39),5,1,.01
            out       asig
endin

;*********************************************************;
;                XENAKIS TEXTURE ORCHESTRA                ;
;                                                         ;     
;     P3 = DURATION           P4 = AMPLITUDE              ;
;     P5 = PITCH IN CPS                             ;
;                                                         ;
;     FUNCTIONS                                           ;
;                                                         ;     
;     F1 = SINE WAVE         F2 = LINEAR RISE             ;
;     F3 = LINEAR FALL       F4 = EXPONENTIAL RISE        ;
;     F5 = EXPONENTIAL FALL  F6 = MODULATION RATE         ;
;     F7 = MODULATION DEPTH  F8 = PORTAMENTO SHAPE        ;
;                                                         ;     
;*********************************************************;
;
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1 
                 
instr     1
;  ******  PORTAMENTO  ******
  ipitch    =  cpspch(p5)
;    idist     =         (sr*.4) - ipitch
;    kchange   oscil1    0.0, idist, p3, 8
;    kline     =         kchange + ipitch
;
; *****  AMPLITUDE MODULATION ******
  iampfac   =  (p4)*(.3)
  ktsamp    oscil1    0.00,iampfac,(p3),7
  kstfrq    oscil1    0.00,2345,(p3),6
  ktrem     oscil     ktsamp,kstfrq,1
  kamp      =  (p4)+ktrem
;
; *****  MAIN INSTRUMENT DESIGN  ***********
  asnd      foscili   kamp,ipitch,1,1.39,4.7,1
  aflt1     reson     asnd,22050,1000,1,1
  aflt      reson     aflt1,22050,10000,1,1
  abal      balance   aflt,asnd
  asig      envlpx    abal,(p3*.5),p3,(p3*.5),2,1,.01
            out       asig
endin

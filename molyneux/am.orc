;*********************************************************;
;      AMPLITUDE MODULATION   ORCHESTRA           
;                                                         ;     
;     P3 = DURATION           P4 = AMPLITUDE              ;
;     P5 = PITCH IN CPS       P6 = RATE OF MODULATION     ;
;     P7 = MODULATION DEPTH % P8 = FUNCTION FOR MOD RATE  ;
;     P9 = FUNCTION FOR MOD DEPTH                 
;     P10 = FUNCTION FOR PORTAMENTO                    
;                                                         ;
;     FUNCTIONS                                           ;
;                                                         ;     
;     F1 = SINE WAVE         F2 = LINEAR RISE             ;
;     F3 = LINEAR FALL       F4 = EXPONENTIAL RISE        ;
;     F5 = EXPONENTIAL FALL  F6 = SINE WAVE FOR BUZZ      ;
;     F7 = MODULATION RATES  F8 = MODULATION DEPTHS         
;                                                         ;
;*********************************************************;
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

                 
instr     1
;  ******  PORTAMENTO  ******
  ipitch    =  (p5)
  idist     =  (sr*.4) - ipitch
  kchange   oscil1    0.0, idist, p3, p10
  kline     =  kchange + ipitch
;
; *****  AMPLITUDE MODULATION ******
  iampfac   =  (p4)*(p7)
  ktsamp    oscil1    0.41,iampfac,(p3),(p9)
  kstfrq    oscil1    0.38,(p6),(p3),(p8)
  ktrem     oscil     ktsamp,kstfrq,1
  kamp      =  (p4)+ktrem
;
; *****  MAIN INSTRUMENT DESIGN  ***********
  knh       =  int((sr*.42)/kline)
  asrce     buzz      kamp,kline,knh,6
  amain     reson     asrce,12000,8000,1
  asnd      balance   amain,asrce 
  asig      envlpx    asnd,.1,p3,.01,2,1.001,.01
            out       asig
endin


;*********************************************************;
;      AMPLITUDE MODULATION   ORCHESTRA                   ;
;                                                         ;     
;     p3 = duration           p4 = amplitude              ;
;     p5 = pitch in cps       p6 = rate of modulation     ;
;     p7 = modulation depth % p8 = function for mod rate  ;
;     p9 = function for mod depth                         ;
;     p10 = function for portamento                       ;
;                                                         ;
;     FUNCTIONS                                           ;
;                                                         ;     
;     f1 = sine wave         f2 = linear rise             ;
;     f3 = linear fall       f4 = exponential rise        ;
;     f5 = exponential fall  f6 = sine wave for buzz      ;
;     f7 = modulation rates  f8 = modulation depths       ;
;                                                         ;
;*********************************************************;
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2
            massign   1,1
                 
instr     1

  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc, 0, .2, .01

;  ******  PORTAMENTO  ******
;ipitch        =         (p5)
  ipitch    =  (8000)
  idist     =  (sr*.4) - ipitch
;kchange       oscil1    0.0, idist, p3, p10
  kchange   oscil1    0.0, idist, 4.50, 9
  kline     =  kchange + ipitch
;
; *****  AMPLITUDE MODULATION ******
;iampfac       =         (p4)*(p7)
  iampfac   =  (10000)*(.3)
;ktsamp        oscil1    0.41,iampfac,(p3),(p9)
  ktsamp    oscil1    0.41,iampfac,(4.50),(8)
;kstfrq        oscil1    0.38,(p6),(p3),(p8)
  kstfrq    oscil1    0.38,(6000),(4.50),(7)
  ktrem     oscil     ktsamp,kstfrq,1
;kamp          =         (p4)+ktrem
  kamp      =  (10000)+ktrem
;
; *****  MAIN INSTRUMENT DESIGN  ***********
  knh       =  int((sr*.42)/kline)
;asrce         buzz      kamp,kline,knh,6
  asrce     buzz      kamp,knote,knh,6
  amain     reson     asrce,12000,8000,1
  asnd      balance   amain,asrce 
;asig          envlpx    asnd,.1,p3,.01,2,1.001,.01
  asig      envlpx    asnd,.1,4.50,.01,2,1.001,.01
               ;out      asig
            outs      asig*kgate, asig*kgate
endin


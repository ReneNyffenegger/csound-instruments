  sr        =  44100
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

;=======================================================================;
; AMBUZZ          Amplitude Modulation Buzz Instrument                  ;
;                 Designed by Garth Molyneux                            ;   
;                 University of Texas at Austin Computer Music Studio   ;
;=======================================================================;
; p6     =        rate of modulation                                    ;
; p7     =        modulation depth %                                    ;
; p8     =        function for mod rate                                 ;
; p9     =        function for mod depth                                ;
; p10    =        amount of portamento in oct.decimal                   ;
; p11    =        function for portamento                               ;
;=======================================================================;
instr        1
                                             
  icps      =  cpspch(p5)                         ; PORTAMENTO DESIGN
  ioct      =  octpch(p5)
  kchange   oscil1i   0,p10,p3,p11
  kline     =  cpsoct(ioct+kchange)
  ibend     =  cpsoct(ioct+p10)
  ilow      =  (ibend<icps ? ibend:icps)
  iampfac   =  p4*p7                              ; TREMOLO DESIGN 
  ktsamp    oscil1    0,iampfac,p3,p9
  kstfrq    oscil1    0,p6,p3,p8
  ktrem     oscil     ktsamp,kstfrq,1
  kamp      =  p4+ktrem
  knh       =  int((sr*.42)/kline)                ; MAIN INSTRUMENT DESIGN
  asrce     buzz      kamp,kline,knh,6
  kbwchg    oscil1i   0,(kline*knh),p3,p11
  kbw       =  kbwchg+(kline*.001)
  aflt1     reson     asrce,kline,kbw,1
  aflt      reson     aflt1,kline,kbw,1
  abal      balance   aflt,asrce 
  aplk      pluck     kamp,kline,ilow,0,2,1.00001
  asnd      =  (abal*.8)+(aplk*.41)
  asig      envlpx    asnd,.0001,p3,(p3*.98),2,1,.01
            out       asig
endin


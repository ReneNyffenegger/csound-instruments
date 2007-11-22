  nchnls    =  2

            massign   1,1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                     ; 
; FILTERED WHITENOISE INSTRUMENT WITH VIBRATO, HARMONICS, AND REVERB  ;
;                                                                     ;
; P4 = PITCH  P5 = AMPLITUDE  P6 = "Q"  P7 = FILTER VIBRATO WIDTH     ;                  
;                                                                     ;
; P8 = FILTER VIBRATO FREQUENCY  P9-P11 = PARTIAL NUMBERS             ;                                                               
;                                                                     ;                                                                                                          
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr          1
        
  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc, 0, .2, .01

;ifac1         =              p9                            ; PARTIAL NUMBERS
  ifac1     =  3
;ifac2         =              p10                
  ifac2     =  5
;ifac3         =              p11
  ifac3     =  7
;ifund         =              cpspch(p4)
  ifund     =  cpspch(9)
  ifreq1    =  ifund*ifac1                        ; THREE PARTIALS 
  ifreq2    =  ifund*ifac2
  ifreq3    =  ifund*ifac3
;ifrf          =              p8                            ; FREQUENCY OF FILTER VIBRATO
  ifrf      =  3
;indur         =              p3*.7                         ; ACTUAL "NOTE" DURATION (MINUS REVERB TIME)
  indur     =  3*.7
  irise     =  indur*.3                           ; ATTACK SPEED
  idec      =  indur*.1                           ; DECAY
;ivibwth       =              p7                            ; FILTER VIBRATO AMPLITUDE (WIDTH) IN CPS AT FIRST PARTIAL
  ivibwth   =  400
  inoysamp  =  .03                                ; WHITENOISE AMPLITUDE SCALED
;iq            =              p6                            ; FILTER "Q"
  iq        =  100
  ichngq    =  .5                                 ; DELAY OF CHANGING Q AS % OF INDUR

  kq        oscil1i   indur*ichngq, iq, idec, 2   ; CHANGE Q NEAR END OF INSTRUMENT
  kbw1      =  ifreq1/kq
  kbw2      =  ifreq2/kq
  kbw3      =  ifreq3/kq
;kngate        envlpx         p5, irise, indur, idec, 3, 1, .01       ; INDUR ENVELOPE     
  kngate    envlpx    20000, irise, indur, idec, 3, 1, .01
  anoys     rand      inoysamp*kngate             ; WHITENOISE
  kvib1     oscil     ivibwth, ifrf, 1            ; VIBRATO FOR FILTERS
  kvib2     oscil     ivibwth*1.27, ifrf*1.2, 1
  kvib3     oscil     ivibwth*.73, ifrf*.57, 1
;afnoy.1       reson          anoys, ifreq1+kvib1, kbw1, 2            ; FUNDAMENTAL FILTERS AND BALANCE STATEMENTS   
  afnoy.1   reson     anoys, knote+kvib1, kbw1, 2
;afnoy.2       reson          anoys, ifreq1+kvib2, kbw1, 2
  afnoy.2   reson     anoys, knote+kvib2, kbw1, 2
;afnoy.3       reson          anoys, ifreq1+kvib3, kbw1, 2
  afnoy.3   reson     anoys, knote+kvib3, kbw1, 2
;afnoy1        reson          afnoy.1, ifreq1+kvib1, kbw1, 2  
  afnoy1    reson     afnoy.1, knote+kvib1, kbw1, 2     
;afnoy2        reson          afnoy.2, ifreq1+kvib2, kbw1, 2
  afnoy2    reson     afnoy.2, knote+kvib2, kbw1, 2
;afnoy3        reson          afnoy.3, ifreq1+kvib3, kbw1, 2
  afnoy3    reson     afnoy.3, knote+kvib3, kbw1, 2
  kvib4     =  kvib1*ifac2                        ; VIBRATO SCALING
  kvib5     =  kvib2*ifac2
  kvib6     =  kvib3*ifac2
;afnoy.4       reson          anoys, ifreq2+kvib4, kbw2, 2            ; SECOND HARMONIC FILTERS AND BALANCE STATEMENTS   
  afnoy.4   reson     anoys, (knote*2)+kvib4, kbw2, 2
;afnoy.5       reson          anoys, ifreq2+kvib5, kbw2, 2
  afnoy.5   reson     anoys, (knote*2)+kvib5, kbw2, 2
;afnoy.6       reson          anoys, ifreq2+kvib6, kbw2, 2
  afnoy.6   reson     anoys, (knote*2)+kvib6, kbw2, 2
;afnoy4        reson          afnoy.4, ifreq2+kvib4, kbw2, 2     
  afnoy4    reson     afnoy.4, (knote*2)+kvib4, kbw2, 2    
;afnoy5        reson          afnoy.5, ifreq2+kvib5, kbw2, 2
  afnoy5    reson     afnoy.5, (knote*2)+kvib4, kbw2, 2
;afnoy6        reson          afnoy.6, ifreq2+kvib6, kbw2, 2
  afnoy6    reson     afnoy.6, (knote*2)+kvib6, kbw2, 2
  kvib7     =  kvib1*ifac3                        ; MORE VIBRATO SCALING
  kvib8     =  kvib2*ifac3
  kvib9     =  kvib3*ifac3
;afnoy.7       reson          anoys, ifreq3+kvib7, kbw3, 2            ; THIRD HARMONIC FILTERS AND BALANCE STATEMENTS     
  afnoy.7   reson     anoys, (knote*3)+kvib7, kbw3, 2
;afnoy.8       reson          anoys, ifreq3+kvib8, kbw3, 2
  afnoy.8   reson     anoys, (knote*3)+kvib8, kbw3, 2
;afnoy.9       reson          anoys, ifreq3+kvib9, kbw3, 2
  afnoy.9   reson     anoys, (knote*3)+kvib9, kbw3, 2
;afnoy7        reson          afnoy.7, ifreq3+kvib7, kbw3, 2 
  afnoy7    reson     afnoy.7, (knote*3)+kvib7, kbw3, 2      
;afnoy8        reson          afnoy.8, ifreq3+kvib8, kbw3, 2
  afnoy8    reson     afnoy.8, (knote*3)+kvib8, kbw3, 2
;afnoy9        reson          afnoy.9, ifreq3+kvib9, kbw3, 2
  afnoy9    reson     afnoy.9, (knote*3)+kvib9, kbw3, 2
  accombu   =  (afnoy3+afnoy6+afnoy9)
  arcombu   =  (afnoy1+afnoy4+afnoy7)
  alcombu   =  (afnoy2+afnoy5+afnoy8)
  accombb   balance   accombu, anoys
  arcombb   balance   arcombu, anoys
  alcombb   balance   alcombu, anoys
  arcomb    =  arcombb+accombb*.707
  alcomb    =  alcombb+accombb*.707     
;arsig         reverb         alcomb, p3
  arsig     reverb    alcomb, 5
;alsig         reverb         arcomb, p3
  alsig     reverb    arcomb, 5
;krgate        linen          1, .01, p3, p3*.3                       ; REVERB ENVELOPE  
  krgate    linen     1, .01, 5, 5*.3
               ;outs          (arsig*krgate)+(arcomb*1.27), (alsig*krgate)+(alcomb*1.27)
            outs      ((arsig*krgate)+(arcomb*1.27))*kgate, ((alsig*krgate)+(alcomb*1.27))*kgate
endin






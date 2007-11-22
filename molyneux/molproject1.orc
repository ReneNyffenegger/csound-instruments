  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                     ;
;                         "NAZOR'S FAZOR"                             ;                      
;                                                                     ; 
; PHASING INSTRUMENT:  P4 = PITCH  P5 = AMPLITUDE  P6 = DECAY TIME    ;                                            
;                                                                     ;
;   P7 = VIBRATO FREQUENCY  P8 = STEADY STATE ATTENUATION FACTOR      ;                  
;                                                                     ;
;      P9 = ATTACK COMPONENT AS PERCENTAGE OF TOTAL AMPLITUDE         ;
;                                                                     ;
;          P10 = CRUDE STEREO PLACEMENT ( 1 OR 0 FLIPFLOP )           ;
;                                                                     ;
;                 P11 = PHASING VIBRATO FREQUENCY                     ; 
;                                                                     ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr     1
  ifamp     =  p9                                 ; RELATIVE AMPLITUDE OF ATTACK TRANSIENT
  ivibamp   =  (1-p9)/2                           ; RELATIVE AMPLITUDE OF PHASING COMPONENT      
  iamp      =  ivibamp                            ; RELATIVE AMPLITUDE OF FUNDAMENTAL TIMBRE
  ifreq     =  cpspch(p4)
  ifunc     =  3                                  ; FUNDAMENTAL TIMBRE FUNCTION
  iarand    =  .1
  ifreqrand =  15
  ifreqvib  =  p7
  ifrise    =  .02                                ; ATTACK TRANSIENT SPEED
  iat       =  .01                                ; FUND. ATTACK SPEED
  idec      =  p6
  idelt     =  .2                                 ; DELAY TIME
  ifazamp   =  .09                                ; PHASING AMPLITUDE
  iatten    =  p8
  ifazvib   =  p11                                ; PHASING SPEED
;p10 IS CRUDE STEREO PLACEMENT

  kgate     envlpx    p5, iat, p3, idec, 2, iatten, .01 ; PHASING INSTRUMENT ENVELOPE
  ifac      table     ifreq, 6                    ; VIBRATO SCALING
  kfgate    oscil1i   0, ifamp, ifrise, 5         ; ATTACK ENVELOPE
  krand     randi     iarand, ifreqrand, -1       ; VIBRATO RANDOM FACTOR
  kvib      oscil     krand+ifac, ifreqvib+krand, 1 ; "BEATING" VIBRATO
  afazvib   oscili    ifazamp, ifazvib, 1         ; PHASING VIBRATO 
  aform     oscili    kfgate, ifreq, 4            ; 3 PHASING INSTRUMENT COMPONENTS
  avibsig   oscili    ivibamp, ifreq+kvib, ifunc
  asig      oscili    iamp, ifreq, ifunc                  
  ktrango   oscil1i   0, 1, p3*.2, 7              ; TRANSIENT REMOVAL GATE FOR DELAYED SIGNAL 
  adelin    =  (asig+avibsig)*ktrango
  adelsig   delayr    idelt                       ; DELAY FOR PHASE FILTERING
  aphasig   deltapi   idelt-ifazamp+afazvib-.0001 ; SCALED TO WITHIN DEFINED LIMITS
            delayw    adelin
if (p10 = 1)   goto      flipflop
            outs      (avibsig+asig+aform)*kgate*2, aphasig*kgate*2
if (p10 != 1)  goto      continue
flipflop:
            outs      aphasig*kgate*2, (avibsig+asig+aform)*kgate*2 
continue:        
endin

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                ;
;                           "SCALES"                             ;
;                                                                ;             
;    BEATING FOSCIL INSTRUMENT  P6 = DECAY TIME OF FUNDAMENTAL   ;                   
;                                                                ;             
;    P7 = ENVLPX IATSS PARAMETER  P8 = STEREO PLACEMENT          ;                            
;                                                                ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr     2
  ifreq     =  cpspch(p4)
  imod      =  5                                  ; FOSCILI MODULATOR RATIO 
  itatt     =  .03                                ; FUNDAMENTAL ATTACK TIME
  icar      =  3                                  ; FOSCILI CARRIER RATIO
  iattfreq  =  ifreq/2                            ; FREQUENCY OF ATTACK TRANSIENT
  iattdur   =  .03                                ; DURATION OF  "        "
  ifazrate  =  4                                  ; SPEED OF BEATING VIBRATO
  ivibamp   =  ifreq*.02                          ; DEPTH OF       "       "    SCALED TO FUNDAMENTAL FREQUENCY
  irevrate  =  p3*.6                              ; 60% OF NOTE DURATION IS THE REVERBERATION TIME
  idurt     =  p3-irevrate
  irevamp   =  .2                                 ; AMPLITUDE SCALING OF REVERB
  iattfac   =  p5/256                             ; VELOCITY SCALING OF ATTACK TRANSIENT AMPLITUDE
  iattamp   table     iattfac, 14
  indxfac   =  (octpch(p4)-5)*18.29               ; SCALING OF FOSCILI INDEX
  indxfac   =  (indxfac<=0? .001:indxfac)
  indxfac   =  (indxfac>=128? 128:indxfac)
  indx      table     indxfac, 11
  itamp     =  (1-iattamp-irevamp)*.9             ; AMPLITUDE SCALING OF COMPONENTS
  ifazamp   =  (1-iattamp-irevamp)*.6

  kgate     envlpx    1, itatt, idurt, p6, 9, p7, .01
  kcarfac   =  (kgate*p5)/256                     ; CARRIER FACTOR SCALING
  kcardev   tablei    kcarfac, 10
  kcarf     =  icar+kcardev
  asig      foscili   itamp, ifreq, kcarf, imod, indx, 1 ;SOUND GENERATION UNITS
  katgate   oscil1i   0, iattamp, iattdur, 12
  aatt      oscili    katgate, iattfreq, 13
  kvib      oscili    ivibamp, ifazrate, 1        ; BEATING VIBRATO
  afazer    foscili   ifazamp, ifreq+kvib, kcarf, imod, indx, 1
  arevin    =  (afazer+asig)*kgate                ; REVERB SCALING AND PRODUCTION
  asus      reverb    arevin, irevrate    
if (p8 = 1)    goto      flipflop                 ; STEREO PLACEMENT
            outs      (arevin+aatt)*p5, (asus*irevamp)*p5
if (p8 != 1)   goto      continue
flipflop:
            outs      (asus*irevamp)*p5, (arevin+aatt)*p5
continue:        
endin
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                     ; 
; FILTERED WHITENOISE INSTRUMENT WITH VIBRATO, HARMONICS, AND REVERB  ;
;                                                                     ;
; P4 = PITCH  P5 = AMPLITUDE  P6 = "Q"  P7 = FILTER VIBRATO WIDTH     ;                  
;                                                                     ;
; P8 = FILTER VIBRATO FREQUENCY                                       ;                                                               
;                                                                     ;                                                                                                          
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr     3
  ifac1     =  2                                  ; PARTIAL NUMBERS
  ifac2     =  3                        
  ifac3     =  5
  ifund     =  cpspch(p4)
  ifreq1    =  ifund*ifac1                        ; THREE PARTIALS 
  ifreq2    =  ifund*ifac2
  ifreq3    =  ifund*ifac3
  ifrf      =  p8                                 ; FREQUENCY OF FILTER VIBRATO
  indur     =  p3*.7                              ; ACTUAL "NOTE" DURATION (MINUS REVERB TIME)
  irise     =  indur*.4                           ; ATTACK SPEED
  idec      =  indur*.1                           ; DECAY
  ivibwth   =  p7                                 ; FILTER VIBRATO AMPLITUDE (WIDTH) IN CPS AT IFREQ
  inoysamp  =  .03                                ; WHITENOISE AMPLITUDE SCALED
  iq        =  p6                                 ; FILTER "Q"

  kq        oscil1i   indur*.1, iq, idec, 8       ; CHANGE Q NEAR END OF INSTRUMENT
  kbw1      =  ifreq1/kq
  kbw2      =  ifreq2/kq
  kbw3      =  ifreq3/kq
  kngate    envlpx    p5, irise, indur, idec, 7, 1, .01 ; INDUR ENVELOPE    
  anoys     rand      inoysamp*kngate             ; WHITENOISE
  kvib1     oscil     ivibwth, ifrf, 1            ; vibrato for filters
  kvib2     oscil     ivibwth*1.27, ifrf*1.2, 1
  kvib3     oscil     ivibwth*.73, ifrf*.57, 1
  afnoy.1   reson     anoys, ifreq1+kvib1, kbw1, 2 ; FUNDAMENTAL FILTERS AND BALANCE STATEMENTS   
  afnoy.2   reson     anoys, ifreq1+kvib2, kbw1, 2
  afnoy.3   reson     anoys, ifreq1+kvib3, kbw1, 2
  afnoy1    reson     afnoy.1, ifreq1+kvib1, kbw1, 2           
  afnoy2    reson     afnoy.2, ifreq1+kvib2, kbw1, 2
  afnoy3    reson     afnoy.3, ifreq1+kvib3, kbw1, 2
  kvib4     =  kvib1*ifac2                        ; VIBRATO SCALING
  kvib5     =  kvib2*ifac2
  kvib6     =  kvib3*ifac2
  afnoy.4   reson     anoys, ifreq2+kvib4, kbw2, 2 ; SECOND HARMONIC FILTERS AND BALANCE STATEMENTS    
  afnoy.5   reson     anoys, ifreq2+kvib5, kbw2, 2
  afnoy.6   reson     anoys, ifreq2+kvib6, kbw2, 2
  afnoy4    reson     afnoy.4, ifreq2+kvib4, kbw2, 2           
  afnoy5    reson     afnoy.5, ifreq2+kvib5, kbw2, 2
  afnoy6    reson     afnoy.6, ifreq2+kvib6, kbw2, 2
  kvib7     =  kvib1*ifac3                        ; MORE VIBRATO SCALING
  kvib8     =  kvib2*ifac3
  kvib9     =  kvib3*ifac3
  afnoy.7   reson     anoys, ifreq3+kvib7, kbw3, 2 ; THIRD HARMONIC FILTERS AND BALANCE STATEMENTS    
  afnoy.8   reson     anoys, ifreq3+kvib8, kbw3, 2
  afnoy.9   reson     anoys, ifreq3+kvib9, kbw3, 2
  afnoy7    reson     afnoy.7, ifreq3+kvib7, kbw3, 2           
  afnoy8    reson     afnoy.8, ifreq3+kvib8, kbw3, 2
  afnoy9    reson     afnoy.9, ifreq3+kvib9, kbw3, 2
  accombu   =  (afnoy3+afnoy6+afnoy9)
  arcombu   =  (afnoy1+afnoy4+afnoy7)
  alcombu   =  (afnoy2+afnoy5+afnoy8)
  accombb   balance   accombu, anoys
  arcombb   balance   arcombu, anoys
  alcombb   balance   alcombu, anoys
  arcomb    =  arcombb+accombb*.707
  alcomb    =  alcombb+accombb*.707     
  arsig     reverb    alcomb, p3
  alsig     reverb    arcomb, p3
  krgate    linen     1, .01, p3, p3*.3           ; REVERB ENVELOPE  
            outs      (arsig*krgate)+arcomb, (alsig*krgate)+alcomb
endin


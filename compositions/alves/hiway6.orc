;*******************************************************************
;*                                                                 *
;*  ORCHESTRA FILE FOR PART 6 OF HIGHWAY 70 BY BILL ALVES (C)1997  *
;*                                                                 *
;*******************************************************************

  sr        =  44100
  kr        =  147
  ksmps     =  300
  nchnls    =  2

  gaverbl   init      0                           ;INITIALIZE THE REVERB GLOBALS
  gaverbr   init      0
  gipref    init      14.475016                   ;PITCH REF = BB 1ST OCTAVE (A=440)
  gitempo   init      212.001                     ;FOR BEAT TO SECOND CONVERSION
  gklevell  init      0.8                         ;GLOBAL LEVEL CONTROLS
  gklevelr  init      0.6

;******************** PITCH REFERENCE CHANGE ******************** 
instr     1                        ;SETS NEW GLOBAL PITCH REF TO P4
                                        ;MUST BE NUMBERED 1 TO BE CALLED FIRST
  gipref    =  p4
endin

;********************** GLOBAL LEVEL CHANGE ********************** 
instr     2                        ;THIS INSTRUMENT EFFECTS OVERALL CHANGES IN VOLUME
  ilevellstart =      p4                          ;CRESCENDO OR DECRESCENDO FROM P4 (LEFT)
  ilevelrstart =      p5                          ;AND P5 (RIGHT) TO
  ilevellend   =      p6                          ;LEVEL P6 (LEFT)
  ilevelrend   =      p7                          ;AND P7 (RIGHT)
  itime     =  p3                                 ;OVER THE DURATION P3
  gklevell  line      ilevellstart,itime,ilevellend
  gklevelr  line      ilevelrstart,itime,ilevelrend
endin

;****************************** HIGH GTR ****************************** 
instr     3                        ;INSTRUMENT TO PLAY GUITAR SAMPLE WITH RESONANT UPPER 8VE
                                        ;P4       =    LOUDNESS
                                        ;P5-7     =    PITCH NUM/DEN, OCT
                                        ;P8-10         NOT USED
                                        ;P11      =    PAN
                                        ;P12      =    ATTACK
                                        ;P13      =    BRIGHTNESS
  ioct      pow       2,(p7-2)
  iorigpch  =  223                                ;ORIGINAL FREQ OF THE GUITAR SAMPLE
  ipan      =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
  imaxamp   =  0.0003                             ;OVERALL AMP FACTOR
  ifreq     =  gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
  irelease  =  0.05                               ;TO EXTEND THE RELEASE PAST P3
  p3        =  p3+irelease                        ;
  idepth    =  0.08                               ;MAX DEPTH OF DELAYS IN SECONDS
  idelay1   linrand   idepth                      ;RANDOM DELAY TIMES UP TO IDEPTH
  idelay2   linrand   idepth
  idelay3   linrand   idepth

  kenv1     linseg    0,p12,p4,p3-irelease-p12,p4,irelease,0 ;DIFFERENT EN-
  kenv2     linseg    0,0.08,p4,p3-irelease-0.08,p4,irelease,0 ;ELOPES
  aorig     diskin    "gtrA4.aiff",ifreq/iorigpch,0
  kfiltenv  line      ifreq*p13,p3,ifreq*2
  afilt     butterlp  aorig,kfiltenv              ;LP FILTER GTR
  afilt     balance   afilt,aorig                 ;NORMALIZE AMPLITUDE
  acomb     comb      aorig,9,2/ifreq             ;RESONATE UPPER OCTAVE
  acomb     balance   acomb,aorig                 ;NORMALIZE AMPLITUDE
  asig      =  acomb+afilt                        ;MIX THE COMBED AND FILTERED SAMPLES
  a0        delayr    idepth                      ;TRIPLE-TAP DELAY LINE AT RANDOM TIMES
  a1        deltapi   idelay1
  a2        deltapi   idelay2
  a3        deltapi   idelay3
            delayw    asig
  asig      =  (asig*kenv1+(a1+a2+a3)*kenv2)*imaxamp
  asigl     =  asig*ipan*gklevell
  asigr     =  asig*(1-ipan)*gklevelr
            outs      asigl,asigr
  gaverbl   =  gaverbl+asigl*0.1
  gaverbr   =  gaverbr+asigr*0.1
endin

;******************** VOICE-CONVOLVED GUITAR ******************** 
instr     4                        ;INSTRUMENT TO PLAY A GUITAR CONVOLVED WITH A VOICE SAMPLE
                                        ;P4       =    LOUDNESS
                                        ;P5-7     =    START PITCH NUM/DEN, OCT
                                        ;P8-10    =    END PITCH NUM/DEN, OCT
                                        ;P11      =    START PAN
                                        ;P12      =    END PAN
                                        ;P13      =    ATTACK
                                        ;P14      =    DECAY
  istartoct pow       2,(p7-1)
  iendoct   pow       2,(p10-1)
  istartp   =  gipref*istartoct*p5/p6             ;BEGINNING PITCH OF NOTE
  iendp     =  gipref*iendoct*p8/p9               ;ENDING PITCH OF NOTE
  istartpan =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
  iendpan   =  (p12+1)/2                          ;PAN AT END OF NOTE
  imaxamp   =  0.007                              ;OVERALL AMP FACTOR
  iattack   =  0.001+p13*60/gitempo               ;CONVERT TO SECONDS
  idecay    =  0.001+p14*60/gitempo               ;CONVERT TO SECONDS
  ipeak     =  0.001+p15*60/gitempo               ;CONVERT TO SECONDS
  igtrfreq  =  750                                ;FREQ OF ORIGINAL GUITAR SAMPLE
  ivcfreq   =  750                                ;FREQ OF ORIGINAL CONVOLVED SAMPLE
  idepth    =  0.5                                ;MAX DEPTH OF DELAYS IN SECONDS
  idelay1   linrand   idepth                      ;RANDOM DELAY TIMES UP TO IDEPTH
  idelay2   linrand   idepth
  idelay3   linrand   idepth
  irelease  =  0.2
  p3        =  p3+irelease
                                                  ;TRIANGULAR LOUDNESS ENVELOPE
  kenv      linseg    0,iattack,p4,p3-iattack-idecay,p4,idecay,0
  kfreqndx  linseg    0,ipeak,0.75,p3-ipeak,1     ;LOOKUP SPLINE PITCH ENVELOPE
  kfreq     tablei    kfreqndx,3,1                ;PITCH ENVELOPE
  kfreq     =  kfreq*(istartp-iendp)+iendp
  kpan      linseg    istartpan,ipeak,iendpan,p3-ipeak,iendpan
  agtr      diskin    "warpgtrfs4.aiff",kfreq/igtrfreq ;TIME-SHIFTED GTR SAMPLE
  avc       diskin    "gtrvcfs4.aiff",kfreq/ivcfreq ;VOICE-CONVOLVED GTR SAMPLE
  agtr      tone      agtr,kfreq*1.5              ;SMOOTH IT OUT SOMEWHAT
  ares      =  avc*2+agtr                         ;MIX THE TWO SAMPLES
  a0        delayr    idepth                      ;TRIPLE-TAP DELAY LINE AT RANDOM TIMES
  a1        deltapi   idelay1
  a2        deltapi   idelay2
  a3        deltapi   idelay3
            delayw    ares
  asig      =  ares+a1+a2+a3
  asig      balance   asig,agtr                   ;NORMALIZE AMPLITUDE
  asig      =  asig*kenv*imaxamp
  asigl     =  asig*kpan*gklevell
  asigr     =  asig*(1-kpan)*gklevelr
            outs      asigl,asigr
  gaverbl   =  gaverbl+asigl*0.2
  gaverbr   =  gaverbr+asigr*0.2
endin

;****************************** DOPPLER ****************************** 
instr     5                        ;PLAYS BACK CAR HORN SAMPLE WITH DOPPLER-LIKE PITCH SLIDE
                                        ;P4  =    LOUDNESS
                                        ;P5-7     =    START PITCH NUM/DEN, OCT
                                        ;P8-10 =  END PITCH NUM/DEN, OCT
                                        ;P11 =    START PAN
                                        ;P12 =    END PAN
                                        ;P13 =    BRIGHTNESS
                                        ;P14 =    DELAY DEPTH
                                        ;P15 =    PEAK TIME
  istartoct pow       2,(p7-2)
  iendoct   pow       2,(p10-3)
  istartp   =  gipref*istartoct*p5/p6             ;BEGINNING PITCH OF NOTE
  iendp     =  gipref*iendoct*p8/p9               ;ENDING PITCH OF NOTE
  iorigpch  =  376                                ;ORIGINAL FREQ OF THE CAR HORN FUND.
  imaxamp   =  0.0015                             ;OVERALL AMP FACTOR
  istartpan =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
  iendpan   =  (p12+1)/2                          ;PAN AT END OF NOTE
  idepth    =  p14                                ;MAX DEPTH OF DELAYS IN SECONDS
  idelay1   linrand   idepth                      ;RANDOM DELAY TIMES UP TO IDEPTH
  idelay2   linrand   idepth
  idelay3   linrand   idepth
  ipeak     =  p15*60/gitempo                     ;convert to seconds
                                                  ;TRIANGULAR LOUDNESS ENVELOPE
  kenv      linseg    0,ipeak,p4,p3-ipeak,0       ;P4 IS LOUDNESS, IPEAK IS PEAK TIME
  kpan      linseg    istartpan,ipeak,iendpan,p3-ipeak,iendpan
  kfreqndx  linseg    0,ipeak,0.895,p3-ipeak,1    ;LOOKUP SPLINE PITCH ENVELOPE
  kfreq     tablei    kfreqndx,2,1                ;PITCH ENVELOPE
  kspeed    =  (kfreq*(istartp-iendp)+iendp)/iorigpch
  asamp     diskin    "carhorn.aiff",kspeed
  ares      butterlp  asamp,kspeed*iorigpch*p13*(1+kenv)/p4
  aorig     balance   ares,asamp                  ;NORMALIZE AMPLITUDE
  a0        delayr    idepth                      ;TRIPLE-TAP DELAY LINE AT RANDOM TIMES
  a1        deltapi   idelay1
  a2        deltapi   idelay2
  a3        deltapi   idelay3
            delayw    aorig
  asig      =  (aorig+a1+a2+a3)*kenv*imaxamp
  asigl     =  asig*kpan*gklevell
  asigr     =  asig*(1-kpan)*gklevelr
            outs      asigl,asigr
  gaverbl   =  gaverbl+asigl
  gaverbr   =  gaverbr+asigr
endin

;****************************** GUITAR 1 ****************************** 
instr     6                   ;INSTRUMENT TO COMBINE GUITAR AND VOICE-CONVOLVED GUITAR SAMPLES
                                   ;P4       =    LOUDNESS
                                   ;P5-7     =    PITCH NUM/DEN, OCT
                                   ;P8-10         NOT USED
                                   ;P11      =    PAN
                                   ;P12           NOT USED
                                   ;P13      =    BRIGHTNESS
  ioct      pow       2,(p7-2)
  igtrpch   =  113                                ;FREQ OF ORIGINAL GUITAR SAMPLE
  ivcpch    =  375                                ;FREQ OF CONVOLVED SAMPLE
  ipan      =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
  imaxamp   =  0.012                              ;OVERALL AMP FACTOR
  ifreq     =  gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
  irelease  =  0.08                               ;TO EXTEND THE RELEASE PAST P3
  p3        =  p3+irelease                        ;

  kenv      linseg    0,p12,p4,p3-irelease,p4,irelease,0
  kfiltenv  line      ifreq*p13,p3,ifreq/5        ;LP FILTER ENVELOPE
  agtr      diskin    "gtrA4.aiff",ifreq/igtrpch,0 ;GUITAR SAMPLE
  avc       diskin    "gtrvcfs4.aiff",ifreq/ivcpch,0 ;CONVOLVED GUITAR SAMPLE
  asig      =  agtr+avc                           ;MIX THEM
  asig      tone      asig,kfiltenv               ;SMOOTH THEM OUT A LITTLE
  asig      =  asig*kenv*imaxamp
  asigl     =  asig*ipan*gklevell
  asigr     =  asig*(1-ipan)*gklevelr
            outs      asigl,asigr
  gaverbl   =  gaverbl+asigl*0.2
  gaverbr   =  gaverbr+asigr*0.2
endin

;****************************** GUITAR 2 ****************************** 
instr     7                                            ;INSTRUMENT TO PLAY ELECTRIC BASS SAMPLE
                                                            ;p4       =    loudness
                                                            ;p5-7     =    pitch num/den, oct
                                                            ;p8-10         not used
                                                            ;p11      =    pan
                                                            ;p12      =    attack
                                                            ;p13      =    brightness
  ioct      pow       2,(p7-2)
  iorigpch  =  113                                ;ORIGINAL FREQ OF THE BASS SAMPLE
  imaxamp   =  0.0035                             ;OVERALL AMP FACTOR
  ifreq     =  gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
  ipan      =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
  irelease  =  0.1                                ;TO EXTEND THE RELEASE PAST P3
  p3        =  p3+irelease                        ;

  kenv      linseg    0,p12,p4,p3-p12,0
  asig      diskin    "BassA3.aiff",ifreq/iorigpch,0
  ares      butterlp  asig,ifreq*p13              ;BUTTERWORTH LP, P13 IS BRIGHTNESS
  ares      tone      ares,ifreq*p13              ;NOW LP AGAIN WITH TONE
  aorig     balance   ares,asig                   ;NORMALIZE AMPLITUDE
  asig      =  asig*imaxamp*kenv
  asigl     =  asig*ipan*gklevell
  asigr     =  asig*(1-ipan)*gklevelr
            outs      asigl,asigr
  gaverbl   =  gaverbl+asigl*0.25
  gaverbr   =  gaverbr+asigr*0.25
endin

;****************************** GUITAR 3 ****************************** 
instr     8                        ;INSTRUMENT TO PLAY GUITAR SAMPLE WITH RESONANT 3RD HARMONIC
                                        ;P4       =    LOUDNESS
                                        ;P5-7     =    PITCH NUM/DEN, OCT
                                        ;P8-10         NOT USED
                                        ;P11      =    PAN
                                        ;P12      =    ATTACK
                                        ;P13      =    BRIGHTNESS
  ioct      pow       2,(p7-2)
  igtrpch   =  113                                ;ORIGINAL FREQ OF THE GUITAR SAMPLE
  ipan      =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
  imaxamp   =  0.008                              ;OVERALL AMP FACTOR
  ifreq     =  gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
  irelease  =  0.1                                ;TO EXTEND THE RELEASE PAST P3
  p3        =  p3+irelease                        ;

  kenv      linseg    0,p12,p4,p3-p12,0
  kfiltenv  line      ifreq*p13,p3,ifreq/5        ;LP FILTER ENVELOPE, P13 IS BRIGHTNESS
  asig      diskin    "gtrA4.aiff",ifreq/igtrpch,0
  abp       butterbp  asig,ifreq*3,20             ;RESONATE 3RD HARMONIC (12TH)
  abp       butterbp  abp,ifreq*3,20              ;bp again in series
  alp       tone      asig,kfiltenv               ;MEANWHILE LP FILTER ORIGINAL SAMPLE
  alp       tone      alp,kfiltenv                ;AGAIN IN SERIES
  asig      =  (alp+abp*50)*kenv*imaxamp          ;MIX THEM
  asigl     =  asig*ipan*gklevell
  asigr     =  asig*(1-ipan)*gklevelr
            outs      asigl,asigr
  gaverbl   =  gaverbl+asigl*0.2
  gaverbr   =  gaverbr+asigr*0.2
endin

;******************************* BASS ******************************* 
instr     9                             ;INSTRUMENT TO PLAY AND DISTORT BASS SAMPLE
                                             ;P4       =    LOUDNESS
                                             ;P5-7     =    PITCH NUM/DEN, OCT
                                             ;P8-10         NOT USED
                                             ;P11      =    START PAN
                                             ;P12      =    END PAN
                                             ;P13      =    BRIGHTNESS
  ioct      pow       2,(p7-1)
  iorigpch  =  113                                ;ORIGINAL FREQ OF THE GUITAR SAMPLE
  imaxamp   =  0.01                               ;OVERALL AMP FACTOR
  istartpan =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
  iendpan   =  (p12+1)/2                          ;PAN AT END OF NOTE
  ifreq     =  gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
  irelease  =  0.05                               ;TO EXTEND THE RELEASE PAST P3
  p3        =  p3+irelease                        ;

  kpan      linseg    istartpan,p3,iendpan
  kenv      linseg    0,0.03,p4,p3-irelease,p4,irelease,0
  asig      diskin    "BassA3.aiff",ifreq/iorigpch,0
  asamp     tablei    ((asig/32768)+1)/2,1,1      ;NON-LINEAR DISTORTION LOOKUP
  kfiltenv  linseg    ifreq*p13,0.5,ifreq*p13/8,0.5,ifreq*p13,p3-1,ifreq*p13
  ares      butterlp  asamp,kfiltenv              ;LP FILTER SWEEP (ON LONG NOTES)
  aorig     balance   ares,asamp                  ;NORMALIZE AMPLITUDE
  asig      =  asig*imaxamp*kenv
  asigl     =  asig*kpan*gklevell
  asigr     =  asig*(1-kpan)*gklevelr
            outs      asigl,asigr
  gaverbl   =  gaverbl+asigl*0.5
  gaverbr   =  gaverbr+asigr*0.5
endin

;***************************** GLOCK ***************************** 
instr     10                                      ;INSTRUMENT TO PLAY A GLOCK SAMPLE
                                                       ;P4       =    LOUDNESS
                                                       ;P5-7     =    PITCH NUM/DEN, OCT
                                                       ;P8-12         NOT USED
                                                       ;P13      =    BRIGHTNESS
  ioct      pow       2,p7
  iorigpch  =  3520                               ;ORIGINAL FREQ OF THE GLOCK SAMPLE
  imaxamp   =  0.0035                             ;OVERALL AMP FACTOR
  ifreq     =  gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
  ipan      =  (1+p11)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
  irelease  =  0.25                               ;TO EXTEND THE RELEASE PAST P3
  p3        =  p3+irelease                        ;

  kenv      linseg    p4,p3-0.1,p4,0.1,0
  aorig     diskin    "glockA5.aiff",ifreq/iorigpch,0
  kfiltenv  line      ifreq*p13,p3,ifreq/5        ;LP FILTER ENVELOPE
  afilt     tone      aorig,kfiltenv
  asig      balance   afilt,aorig                 ;NORMALIZE AMPLITUDE
  asig      =  asig*imaxamp*kenv
  asigl     =  asig*ipan*gklevell
  asigr     =  asig*(1-ipan)*gklevelr
            outs      asigl,asigr
  gaverbl   =  gaverbl+asigl
  gaverbr   =  gaverbr+asigr
endin

;***************************** GONG ***************************** 
instr     12                                      ;INSTRUMENT TO PLAY GONG SAMPLE
                                                       ;P4       =    LOUDNESS
                                                       ;P5-7     =    PITCH NUM/DEN, OCT
                                                       ;P8-10         NOT USED
                                                       ;P11      =    PAN
  ioct      pow       2,(p7-2)
  iorigpch  =  55                                 ;ORIGINAL FREQ OF THE GONG SAMPLE
  imaxamp   =  0.003                              ;OVERALL AMP FACTOR
  ipan      =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
  ifreq     =  gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
  irelease  =  0                                  ;TO EXTEND THE RELEASE PAST P3
  p3        =  p3+irelease                        ;

  kenv      linseg    p4,p3-0.1,p4,0.1,0
  aorig     diskin    "Gong.aiff",ifreq/iorigpch,0
  asig      =  aorig*imaxamp*kenv
  asigl     =  asig*ipan*gklevell
  asigr     =  asig*(1-ipan)*gklevelr
            outs      asigl,asigr
  gaverbl   =  gaverbl+asigl
  gaverbr   =  gaverbr+asigr
endin

;***************************** REVERB ***************************** 
instr     99                            ;REVERB INSTRUMENT, RUNS ALWAYS, MUST BE NUMBERED LAST
  averbl    reverb    gaverbl,2                   ;USE DIFFERENT REVERB ALGORITHMS
  averbr    reverb2   gaverbr,1.5,0.3             ;FOR LEFT AND RIGHT CHANNELS
            outs      averbl*0.2+averbr*0.05,averbl*0.05+averbr*0.2
  gaverbl   =  0                                  ;REINITIALIZE GLOBAL REVERB VARIABLES
  gaverbr   =  0
endin


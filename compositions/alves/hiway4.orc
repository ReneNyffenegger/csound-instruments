;*******************************************************************
;*                                                                 *
;*  ORCHESTRA FILE FOR PART 4 OF HIGHWAY 70 BY BILL ALVES (C)1997  *
;*                                                                 *
;*******************************************************************

  sr        =  44100
  kr        =  147
  ksmps     =  300
  nchnls    =  2

  gaverbl   init      0                           ;INITIALIZE THE REVERB GLOBALS
  gaverbr   init      0
  gipref    init      16.88751                    ;INITIALIZE THE PITCH REFERENCE (C# OCTAVE 1)
  gitempo   init      212.001                     ;FOR BEAT TO SECOND CONVERSION
  gklevell  init      1                           ;GLOBAL LEVEL CONTROLS
  gklevelr  init      1

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
instr     3                                  ;GUITAR SAMPLE WITH RESONANT UPPER OCTAVE
                                                  ;P4       =    LOUDNESS
                                                  ;P5-7     =    PITCH NUM/DEN, OCT
                                                  ;P8-10         NOT USED
                                                  ;P11      =    PAN
                                                  ;P12           NOT USED
                                                  ;P13      =    BRIGHTNESS
  ioct      pow       2,(p7-2)
  iorigpch  =  223                                ;ORIGINAL FREQ OF THE GUITAR SAMPLE
  ipan      =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
  imaxamp   =  0.001                              ;OVERALL AMP FACTOR
  ifreq     =  gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
  irelease  =  0.08                               ;TO EXTEND THE RELEASE PAST P3
  p3        =  p3+irelease                        ;

  kenv      linseg    0,0.03,p4,p3-irelease,p4,irelease,0
  aorig     diskin    "gtrA4.aiff",ifreq/iorigpch,0
  kfiltenv  line      ifreq*p13,p3,ifreq*2        ;LP FILTER ENVELOPE
  afilt     butterlp  aorig,kfiltenv
  afilt     balance   afilt,aorig                 ;NORMALIZE AMPLITUDE
  acomb     comb      aorig,9,2/ifreq             ;RESONATE UPPER OCTAVE
  acomb     balance   acomb,aorig
  asig      =  (acomb+afilt)*imaxamp*kenv         ;MIX THE TWO
  asigl     =  asig*ipan*gklevell
  asigr     =  asig*(1-ipan)*gklevelr
            outs      asigl,asigr
  gaverbl   =  gaverbl+asigl*0.1
  gaverbr   =  gaverbr+asigr*0.1
endin

;****************************** DOPPLER ****************************** 
instr     5                        ;PLAYS BACK CAR HORN SAMPLE WITH DOPPLER-LIKE PITCH SLIDE
                                        ;P4       =    LOUDNESS
                                        ;P5-7     =    START PITCH NUM/DEN, OCT
                                        ;P8-10    =    END PITCH NUM/DEN, OCT
                                        ;P11      =    START PAN
                                        ;P12      =    END PAN
                                        ;P13      =    BRIGHTNESS
                                        ;P14      =    DELAY DEPTH
                                        ;P15      =    PEAK TIME
  istartoct pow       2,(p7-2)
  iendoct   pow       2,(p10-3)
  istartp   =  gipref*istartoct*p5/p6             ;BEGINNING PITCH OF NOTE
  iendp     =  gipref*iendoct*p8/p9               ;ENDING PITCH OF NOTE
  imaxamp   =  0.0015                             ;OVERALL AMP FACTOR
  istartpan =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
  iendpan   =  (p12+1)/2                          ;PAN AT END OF NOTE
  iorigpch  =  376                                ;ORIGINAL FREQ OF THE CAR HORN FUND.
  idepth    =  p14                                ;MAX DEPTH OF DELAY IN SECONDS
  idelay1   linrand   idepth                      ;RANDOM DELAY TIMES UP TO IDEPTH
  idelay2   linrand   idepth
  idelay3   linrand   idepth
  ipeak     =  p15*60/gitempo                     ;CONVERT TO SECONDS
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
instr     6                                  ;INSTRUMENT TO PLAY BACK ELECTRIC BASS SAMPLE
                                                  ;P4       =    LOUDNESS
                                                  ;P5-7     =    PITCH NUM/DEN, OCT
                                                  ;P8-10         NOT USED
                                                  ;P11      =    PAN
                                                  ;P12      =    ATTACK
                                                  ;P13      =    BRIGHTNESS
  ioct      pow       2,(p7-2)
  iorigpch  =  113                                ;ORIGINAL FREQ OF THE BASS SAMPLE
  ipan      =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
  imaxamp   =  0.006                              ;OVERALL AMP FACTOR
  ifreq     =  gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
  irelease  =  0.2                                ;TO EXTEND THE RELEASE PAST P3
  p3        =  p3+irelease                        ;

  kenv      linseg    0,p12,p4,p3-0.06,0
  asamp     diskin    "BassA3.aiff",ifreq/(4*iorigpch),0
  asigf     butterlp  asamp,ifreq*p13             ;LP FILTER, P13 IS BRIGHTNESS
  asigh     butterhp  asigf,ifreq/2               ;HP TOO FOR RUMBLE
  asig      balance   asigh,asamp                 ;NORMALIZE AMPLITUDE
  asig      =  asig*imaxamp*kenv
  asigl     =  asig*ipan*gklevell
  asigr     =  asig*(1-ipan)*gklevelr
            outs      asigl,asigr
  gaverbl   =  gaverbl+asigl*0.2
  gaverbr   =  gaverbr+asigr*0.2
endin

;****************************** GUITAR 2 ****************************** 
instr     7                             ;INSTRUMENT TO PLAY AND DISTORT ELECTRIC BASS SAMPLE
                                             ;P4       =    LOUDNESS
                                             ;P5-7     =    PITCH NUM/DEN, OCT
                                             ;P8-10         NOT USED
                                             ;P11      =    PAN
                                             ;P12           NOT USED
                                             ;P13      =    BRIGHTNESS
  ioct      pow       2,(p7-2)
  iorigpch  =  113                                ;ORIGINAL FREQ OF THE BASS SAMPLE
  imaxamp   =  0.0045                             ;OVERALL AMP FACTOR
  istartpan =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
  iendpan   =  (p12+1)/2                          ;PAN AT END OF NOTE
  ifreq     =  gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
  irelease  =  0.05                               ;TO EXTEND THE RELEASE PAST P3
  p3        =  p3+irelease                        ;

  kpan      linseg    istartpan,p3,iendpan
  kenv      linseg    p4,p3-irelease,p4,irelease,0
  asig      diskin    "BassA3.aiff",ifreq/iorigpch,0
  asamp     tablei    ((asig/32768)+1)/2,1,1      ;NON-LINEAR DISTORTION LOOKUP
  ares      butterlp  asamp,ifreq*p13             ;LP FILTER, P13 IS BRIGHTNESS
  aorig     balance   ares,asamp                  ;NORMALIZE AMPLITUDE
  asig      =  asig*imaxamp*kenv
  asigl     =  asig*kpan*gklevell
  asigr     =  asig*(1-kpan)*gklevelr
            outs      asigl,asigr
  gaverbl   =  gaverbl+asigl*0.5
  gaverbr   =  gaverbr+asigr*0.5
endin

;****************************** GUITAR 3 ****************************** 
instr     8                                  ;INSTRUMENT TO PLAY BACK ELECTRIC BASS SAMPLE
                                                  ;P4       =    LOUDNESS
                                                  ;P5-7     =    PITCH NUM/DEN, OCT
                                                  ;P8-10         NOT USED
                                                  ;P11      =    PAN
                                                  ;P12      =    ATTACK
                                                  ;P13      =    BRIGHTNESS
  ioct      pow       2,(p7-2)
  iorigpch  =  113                                ;ORIGINAL FREQ OF THE BASS SAMPLE
  ipan      =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
  imaxamp   =  0.005                              ;OVERALL AMP FACTOR
  ifreq     =  gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
  irelease  =  0.2                                ;TO EXTEND THE RELEASE PAST P3
  p3        =  p3+irelease                        ;

  kenv      linseg    0,p12,p4,p3-0.06,0
  asamp     diskin    "BassA3.aiff",ifreq/(4*iorigpch),0
  asigf     butterlp  asamp,ifreq*p13             ;LP FILTER, P13 IS BRIGHTNESS
  asigh     butterhp  asigf,ifreq/2               ;HP TOO FOR RUMBLE
  asig      balance   asigh,asamp                 ;NORMALIZE AMPLITUDE
  asig      =  asig*imaxamp*kenv
  asigl     =  asig*ipan*gklevell
  asigr     =  asig*(1-ipan)*gklevelr
            outs      asigl,asigr
  gaverbl   =  gaverbl+asigl*0.2
  gaverbr   =  gaverbr+asigr*0.2
endin

;******************************* BASS ******************************* 
instr     9                                  ;ANOTHER INSTRUMENT TO DISTORT BASS SAMPLE
                                                  ;P4       =    LOUDNESS
                                                  ;P5-7     =    PITCH NUM/DEN, OCT
                                                  ;P8-10         NOT USED
                                                  ;P11      =    START PAN
                                                  ;P12      =    END PAN
                                                  ;P13      =    BRIGHTNESS
  ioct      pow       2,(p7-2)
  iorigpch  =  113                                ;ORIGINAL FREQ OF THE BASS SAMPLE
  imaxamp   =  0.007                              ;OVERALL AMP FACTOR
  istartpan =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
  iendpan   =  (p12+1)/2                          ;PAN AT END OF NOTE
  ifreq     =  gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
  irelease  =  0.05                               ;TO EXTEND THE RELEASE PAST P3
  p3        =  p3+irelease                        ;

  kpan      linseg    istartpan,p3,iendpan
  kenv      linseg    p4,p3-irelease,p4,irelease,0
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

;***************************** CAR DOOR ***************************** 
instr     11                                 ;DRUM-LIKE SOUND
                                                  ;P4       =    LOUDNESS
                                                  ;P5-7     =    PITCH NUM/DEN, OCT
                                                  ;P8-10         NOT USED
                                                  ;P11      =    PAN
  ioct      pow       2,(p7-2)
  iorigpch  =  175                                ;REFERENCE FREQ OF THE CAR DOOR SAMPLE
  imaxamp   =  0.004                              ;OVERALL AMP FACTOR
  ifreq     =  gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
  irelease  =  0                                  ;TO EXTEND THE RELEASE PAST P3
  p3        =  p3+irelease                        ;
  ipan      =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE

  kenv      linseg    p4,p3-0.1,p4,0.1,0
  aorig     diskin    "LoCarDr.aiff",ifreq/iorigpch,0
  asig      =  aorig*imaxamp*kenv
  asigl     =  asig*ipan*gklevell
  asigr     =  asig*(1-ipan)*gklevelr
            outs      asigl,asigr
  gaverbl   =  gaverbl+asigl*0.01
  gaverbr   =  gaverbr+asigr*0.01
endin

;***************************** GONG ***************************** 
instr     12                                 ;INSTRUMENT TO PLAY GONG SAMPLE
                                                  ;P4       =    LOUDNESS
                                                  ;P5-7     =    PITCH NUM/DEN, OCT
                                                  ;P8-10         NOT USED
                                                  ;P11      =    PAN
  ioct      pow       2,(p7-2)
  iorigpch  =  55                                 ;ORIGINAL FREQ OF THE GONG SAMPLE
  imaxamp   =  0.003                              ;OVERALL AMP FACTOR
  ifreq     =  gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
  irelease  =  0                                  ;TO EXTEND THE RELEASE PAST P3
  p3        =  p3+irelease                        ;
  ipan      =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE

  kenv      linseg    p4,p3-0.1,p4,0.1,0
  aorig     diskin    "Gong.aiff",ifreq/iorigpch,0
  asig      =  aorig*imaxamp*kenv
  asigl     =  asig*ipan*gklevell
  asigr     =  asig*(1-ipan)*gklevelr
            outs      asigl,asigr
  gaverbl   =  gaverbl+asigl
  gaverbr   =  gaverbr+asigr
endin

;***************************** MID DRUMS ***************************** 
instr     13                                 ;DRUM-LIKE SOUND
                                                  ;P4       =    LOUDNESS
                                                  ;P5-7     =    PITCH NUM/DEN, OCT
                                                  ;P8-10         NOT USED
                                                  ;P11      =    PAN
  ioct      pow       2,(p7-2)
  iorigpch  =  175                                ;REFERENCE FREQ OF THE CAR DOOR SAMPLE
  imaxamp   =  0.0015                             ;OVERALL AMP FACTOR
  ifreq     =  gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
  irelease  =  0                                  ;TO EXTEND THE RELEASE PAST P3
  p3        =  p3+irelease                        ;
  ipan      =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE

  kenv      linseg    p4,p3-0.1,p4,0.1,0
  aorig     diskin    "MidCarDr.aiff",ifreq/iorigpch,0
  asig      =  aorig*imaxamp*kenv
  asigl     =  asig*ipan*gklevell
  asigr     =  asig*(1-ipan)*gklevelr
            outs      asigl,asigr
  gaverbl   =  gaverbl+asigl*0.01
  gaverbr   =  gaverbr+asigr*0.01
endin

;***************************** REVERB ***************************** 
instr     99                            ;REVERB INSTRUMENT, RUNS ALWAYS, MUST BE NUMBERED LAST
  averbl    reverb    gaverbl,2                   ;USE DIFFERENT REVERB ALGORITHMS
  averbr    reverb2   gaverbr,1.5,0.3             ;FOR LEFT AND RIGHT CHANNELS
            outs      averbl*0.2+averbr*0.05,averbl*0.05+averbr*0.2
  gaverbl   =  0                                  ;REINITIALIZE GLOBAL REVERB VARIABLES
  gaverbr   =  0
endin


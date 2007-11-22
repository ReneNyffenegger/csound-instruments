;*******************************************************************
;*                                                                 *
;*  ORCHESTRA FILE FOR PART 3 OF HIGHWAY 70 BY BILL ALVES (C)1997  *
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
  gklevell  init      1.14                        ;GLOBAL LEVEL CONTROLS
  gklevelr  init      1.14

;******************** PITCH REFERENCE CHANGE ******************** 
instr     1                                  ;SETS NEW GLOBAL PITCH REF TO P4
                                                  ;MUST BE NUMBERED 1 TO BE CALLED FIRST
  gipref    =  p4
endin

;********************** GLOBAL LEVEL CHANGE ********************** 
instr     2                                  ;THIS INSTRUMENT EFFECTS OVERALL CHANGES IN VOLUME
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
                                                  ;P4  =    LOUDNESS
                                                  ;P5-7     =    PITCH NUM/DEN, OCT
                                                  ;P8-10         NOT USED
                                                  ;P11 =    PAN
                                                  ;P12      NOT USED
                                                  ;P13 =    BRIGHTNESS
  ioct      pow       2,(p7-2)
  iorigpch  =  223                                ;ORIGINAL FREQ OF THE GUITAR SAMPLE
  ipan      =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
  imaxamp   =  0.001                              ;OVERALL AMP FACTOR
  ifreq     =  gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
  irelease  =  0.08                               ;TO EXTEND THE RELEASE PAST P3
  p3        =  p3+irelease                        ;

  kenv      linseg    0,0.03,p4,p3-irelease,p4,irelease,0
  aorig     diskin    "gtrA4.aiff",ifreq/iorigpch,0
  kfiltenv  line      ifreq*p13,p3,ifreq*2        ;FILTER ENVELOPE, P13 IS BRIGHTNESS
  afilt     butterlp  aorig,kfiltenv
  afilt     balance   afilt,aorig                 ;NORMALIZE AMPLITUDE
  acomb     comb      aorig,9,2/ifreq             ;RESONATE UPPER OCTAVE
  acomb     balance   acomb,aorig                 ;NORMALIZE AMPLITUDE
  asig      =  (acomb+afilt)*imaxamp*kenv
  asigl     =  asig*ipan*gklevell
  asigr     =  asig*(1-ipan)*gklevelr
            outs      asigl,asigr
  gaverbl   =  gaverbl+asigl*0.1
  gaverbr   =  gaverbr+asigr*0.1
endin

;********************* VOICE CONVOLVED GUITAR ********************* 
instr     4                                  ;INSTRUMENT TO PLAY A GUITAR CONVOLVED WITH A VOICE SAMPLE
                                                  ;P4       =    LOUDNESS
                                                  ;P5-7     =    START PITCH NUM/DEN, OCT
                                                  ;P8-10    =    END PITCH NUM/DEN, OCT
                                                  ;P11      =    START PAN
                                                  ;P12      =    END PAN
                                                  ;P13      =    ATTACK
                                                  ;P14      =    DECAY
                                                  ;P15      =    PEAK
  istartoct pow       2,(p7-1)
  iendoct   pow       2,(p10-1)
  istartp   =  gipref*istartoct*p5/p6             ;BEGINNING PITCH OF NOTE
  iendp     =  gipref*iendoct*p8/p9               ;ENDING PITCH OF NOTE
  istartpan =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
  iendpan   =  (p12+1)/2                          ;PAN AT END OF NOTE
  imaxamp   =  0.015                              ;OVERALL AMP FACTOR
  iattack   =  p13*60/gitempo                     ;CONVERT TO SECONDS
  idecay    =  p14*60/gitempo                     ;CONVERT TO SECONDS
  ipeak     =  p15*60/gitempo                     ;CONVERT TO SECONDS
  igtrfreq  =  750                                ;ORIGINAL FREQ OF GUITAR SAMPLE
  ivcfreq   =  750                                ;ORIGINAL FREQ OF CONVOLVED SAMPLE
  idepth    =  0.5                                ;MAX DEPTH OF DELAY IN SECONDS
  idelay1   linrand   idepth                      ;RANDOM DELAY TIME UP TO IDEPTH
  idelay2   linrand   idepth
  idelay3   linrand   idepth
  irelease  =  0.2                                ;TO EXTEND THE RELEASE PAST P3
  p3        =  p3+irelease
                                                  ;TRIANGULAR LOUDNESS ENVELOPE
  kenv      linseg    0,iattack,p4,p3-iattack-idecay,p4,idecay,0
  kfreqndx  linseg    0,ipeak,0.75,p3-ipeak,1     ;LOOKUP SPLINE PITCH ENVELOPE
  kfreq     tablei    kfreqndx,3,1                ;PITCH ENVELOPE LOOKUP
  kfreq     =  kfreq*(istartp-iendp)+iendp
  kpan      linseg    istartpan,ipeak,iendpan,p3-ipeak,iendpan
  agtr      diskin    "warpgtrfs4.aiff",kfreq/igtrfreq ;TIME-STRETCHED GTR
  avc       diskin    "gtrvcfs4.aiff",kfreq/ivcfreq ;GTR CONVOLVED W/VOICE
  agtr      tone      agtr,kfreq*1.5              ;smooth out with lp filter
  ares      =  avc*2+agtr                         ;MIX GTR WITH CONVOLUTION
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
                                        ;P4       =    LOUDNESS
                                        ;P5-7     =    START PITCH NUM/DEN, OCT
                                        ;P8-10    =    END PITCH NUM/DEN, OCT
                                        ;P11      =    START PAN
                                        ;P12      =    END PAN
                                        ;P13      =    BRIGHTNESS
                                        ;P14      =    DELAY DEPTH
                                        ;P15      =    PEAK TIME
  istartoct pow       2,(p7-3)
  iendoct   pow       2,(p10-3)
  istartp   =  gipref*istartoct*p5/p6             ;BEGINNING PITCH OF NOTE
  iendp     =  gipref*iendoct*p8/p9               ;ENDING PITCH OF NOTE
  imaxamp   =  0.001                              ;OVERALL AMP FACTOR
  iorigpch  =  376                                ;ORIGINAL FREQ OF THE CAR HORN FUND.
  istartpan =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
  iendpan   =  (p12+1)/2                          ;PAN AT END OF NOTE
  idepth    =  p14                                ;MAX DEPTH OF DELAY IN SECONDS
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
  kfiltenv  =  kspeed*iorigpch*p13*(1+kenv)/p4    ;LP FILTER ENVELOPE
  ares      butterlp  asamp,kfiltenv
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
instr     6                                       ;INSTRUMENT TO PLAY A COMBED DISTORTED GUITAR
                                                       ;P4       =    LOUDNESS
                                                       ;P5-7     =    PITCH NUM/DEN, OCT
                                                       ;P8-10         NOT USED
                                                       ;P11      =    PAN
                                                       ;P12      =    ATTACK
                                                       ;P13      =    BRIGHTNESS
  ioct      pow       2,(p7-3)
  iorigpch  =  113                                ;ORIGINAL FREQ OF THE GUITAR SAMPLE
  ipan      =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
  imaxamp   =  0.002                              ;OVERALL AMP FACTOR
  ifreq     =  gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
  irelease  =  0.2                                ;TO EXTEND THE RELEASE PAST P3
  p3        =  p3+irelease

  kenv      linseg    0,p12,p4,p3-0.06,0
  asamp     diskin    "disgtrA4.aiff",ifreq/(4*iorigpch),0
  acomb     comb      asamp,99,1/ifreq            ;FILTER OUT EVERYTHING BUT HARMONICS
  asigf     butterlp  acomb,ifreq*p13             ;LP FILTER, P13 IS BRIGHTNESS
  asigh     butterhp  asigf,ifreq/2               ;ALSO HP
  asig      balance   asigh,asamp                 ;NORMALIZE AMPLITUDE
  asig      =  asig*imaxamp*kenv
  asigl     =  asig*ipan*gklevell
  asigr     =  asig*(1-ipan)*gklevelr
            outs      asigl,asigr
  gaverbl   =  gaverbl+asigl*0.2
  gaverbr   =  gaverbr+asigr*0.2
endin

;****************************** GUITAR 2 ****************************** 
instr     7                                       ;INSTRUMENT TO RING MODULATE GLOCK SAMPLE
                                                       ;P4       =    LOUDNESS
                                                       ;P5-7     =    PITCH NUM/DEN, OCT
                                                       ;P8-10         NOT USED
                                                       ;P11      =    PAN
                                                       ;P12      =    ATTACK
                                                       ;P13      =    BRIGHTNESS
  ioct      pow       2,(p7-3)
  iorigpch  =  440                                ;ORIGINAL FREQ OF THE GLOCK SAMPLE
  ipan      =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
  imaxamp   =  0.005                              ;OVERALL AMP FACTOR
  ifreq     =  gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
  irelease  =  0.08                               ;TO EXTEND THE RELEASE PAST P3
  p3        =  p3+irelease

  kcenv     linseg    0,p12,p4,p3-irelease-0.02,p4,irelease,0 ;CARRIER ENV.
  kmenv     linseg    0,0.08,p13/10,0.2,0         ;MODULATOR ENVELOPE
  amod      oscili    kmenv,11.4142*ifreq,4       ;SINE WAVE AT NONHARMONIC FREQ
  acar      diskin    "glockA5.aiff",ifreq/iorigpch,0 ;GLOCK SAMPLE
  acarf     tone      acar,ifreq*3                ;LP FILTER SAMPLE
  acarf     balance   acarf,acar                  ;NORMALIZE AMPLITUDE
  asig      =  acarf*kmenv*amod                   ;RING MODULATE SAMPLE
  asig      butterhp  asig,ifreq                  ;FILTER OUT LF SIDEBANDS
  asig      balance   asig,acar                   ;NORMALIZE AMPLITUDE
  asig      =  (asig*0.2+acarf*2)*imaxamp*kcenv   ;MIX MODULATED SIGNAL
  asigl     =  asig*ipan*gklevell                 ;with original
  asigr     =  asig*(1-ipan)*gklevelr
            outs      asigl,asigr
  gaverbl   =  gaverbl+asigl*0.2
  gaverbr   =  gaverbr+asigr*0.2
endin

;****************************** GUITAR 3 ****************************** 
instr     8                                                 ;INSTRUMENT TO PLAY GLOCK SAMPLE
                                                                 ;P4  =    LOUDNESS
                                                                 ;P5-7     =    PITCH NUM/DEN, OCT
                                                                 ;P8-10    NOT USED
                                                                 ;P11 =    PAN
                                                                 ;P12 =    ATTACK
                                                                 ;P13 =    BRIGHTNESS
  ioct      pow       2,(p7-4)
  iorigpch  =  440                                ;ORIGINAL FREQ OF THE GLOCK SAMPLE
  ipan      =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
  imaxamp   =  0.05                               ;OVERALL AMP FACTOR
  ifreq     =  gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
  irelease  =  0.08                               ;TO EXTEND THE RELEASE PAST P3
  p3        =  p3+irelease
            print     ifreq

  kenv      linseg    0,p12,p4,p3-p12,0
  aorig     diskin    "glockA5.aiff",ifreq/iorigpch,0.05
  acarf     tone      aorig,ifreq*p13             ;LP FILTER SAMPLE, P13 IS BRIGHTNESS
  asig      butterhp  acarf,ifreq/2               ;HP TOO
  asig      =  asig*imaxamp*kenv
  asigl     =  asig*ipan*gklevell
  asigr     =  asig*(1-ipan)*gklevelr
            outs      asigl,asigr
  gaverbl   =  gaverbl+asigl*0.1
  gaverbr   =  gaverbr+asigr*0.1
endin

;******************************* BASS ******************************* 
instr     9                                       ;INSTRUMENT TO PLAY AND DISTORT BASS SAMPLE
                                                       ;P4       =    LOUDNESS
                                                       ;P5-7     =    PITCH NUM/DEN, OCT
                                                       ;P8-10         NOT USED
                                                       ;P11      =    START PAN
                                                       ;P12      =    END PAN
                                                       ;P13      =    BRIGHTNESS
  ioct      pow       2,(p7-2)
  iorigpch  =  113                                ;ORIGINAL FREQ OF THE BASS SAMPLE
  imaxamp   =  0.002                              ;OVERALL AMP FACTOR
  istartpan =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
  iendpan   =  (p12+1)/2                          ;PAN AT END OF NOTE
  ifreq     =  gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
  irelease  =  0.05                               ;TO EXTEND THE RELEASE PAST P3
  p3        =  p3+irelease                        ;

  kpan      linseg    istartpan,p3,iendpan
  kenv      linseg    0,0.05,p4,p3-irelease-0.05,p4,irelease,0
  asig      diskin    "BassA3.aiff",ifreq/iorigpch,0
  asamp     tablei    ((asig/32768)+1)/2,1,1      ;NON-LINEAR DISTORTION LOOKUP
  kfiltenv  linseg    ifreq*p13,0.5,ifreq*p13/8,0.5,ifreq*p13,p3-1,ifreq*p13
  ares      butterlp  asamp,kfiltenv              ;LP FILTER SWEEP (ON LONG NOTES)
  ares      butterhp  ares,ifreq/2                ;HP TOO
  aorig     balance   ares,asamp                  ;NORMALIZE AMPLITUDE
  asig      =  asig*imaxamp*kenv
  asigl     =  asig*kpan*gklevell
  asigr     =  asig*(1-kpan)*gklevelr
            outs      asigl,asigr
  gaverbl   =  gaverbl+asigl*0.5
  gaverbr   =  gaverbr+asigr*0.5
endin

;***************************** GLOCK ***************************** 
instr     10                                      ;INSTRUMENT TO PLAY GLOCK SAMPLE WITH RANDOM PAN
                                                       ;P4       =    LOUDNESS
                                                       ;P5-7     =    PITCH NUM/DEN, OCT
                                                       ;P8-12         NOT USED
                                                       ;P13      =    BRIGHTNESS
  ioct      pow       2,(p7+1)
  iorigpch  =  3520                               ;ORIGINAL FREQ OF THE GLOCK SAMPLE
  imaxamp   =  0.004                              ;OVERALL AMP FACTOR
  ifreq     =  gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
  irelease  =  1                                  ;TO EXTEND THE RELEASE PAST P3
  p3        =  p3+irelease                        ;
  ipan      linrand   1                           ;RANDOM PAN FOR EACH NOTE

  kenv      linseg    p4,p3-0.1,p4,0.1,0
  aorig     diskin    "glockA5.aiff",ifreq/iorigpch,0
  kfiltenv  line      ifreq*p13,p3,ifreq/5        ;LP FILTER ENVELOPE
  afilt     tone      aorig,kfiltenv
  asig      balance   afilt,aorig                 ;NORMALIZE AMPLITUDE
  asig      =  asig*imaxamp*kenv
  asigl     =  asig*ipan*gklevell
  asigr     =  asig*(1-ipan)*gklevelr
            outs      asigl,asigr
  gaverbl   =  gaverbl+asigl*1.7
  gaverbr   =  gaverbr+asigr*1.5
endin

;***************************** CAR DOOR ***************************** 
instr     11                            ;DRUM-LIKE SOUND
                                                       ;P4       =    LOUDNESS
                                                       ;P5-7     =    PITCH NUM/DEN, OCT
                                                       ;P8-10         NOT USED
                                                       ;P11      =    PAN
  ioct      pow       2,(p7-2)
  iorigpch  =  175                                ;REFERENCE FREQ OF THE CAR DOOR SAMPLE
  imaxamp   =  0.002                              ;OVERALL AMP FACTOR
  ifreq     =  gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
  ipan      =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
  irelease  =  0                                  ;TO EXTEND THE RELEASE PAST P3
  p3        =  p3+irelease                        ;    

  kenv      linseg    p4,p3-0.1,p4,0.1,0
  aorig     diskin    "LoCarDr.aiff",ifreq/iorigpch,0
  asig      =  aorig*imaxamp*kenv
  asigl     =  asig*ipan*gklevell
  asigr     =  asig*(1-ipan)*gklevelr
            outs      asigl,asigr
  gaverbl   =  gaverbl+asigl*0.01                 ;MINIMUM REVERB SEND FOR DRUM
  gaverbr   =  gaverbr+asigr*0.01
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
  ifreq     =  gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
  irelease  =  0                                  ;TO EXTEND THE RELEASE PAST P3
  p3        =  p3+irelease
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

;***************************** REVERB ***************************** 
instr     99                            ;REVERB INSTRUMENT, RUNS ALWAYS, MUST BE NUMBERED LAST
  averbl    reverb    gaverbl,2                   ;USE DIFFERENT REVERB ALGORITHMS
  averbr    reverb2   gaverbr,1.5,0.3             ;FOR LEFT AND RIGHT CHANNELS
            outs      averbl*0.2+averbr*0.05,averbl*0.05+averbr*0.2
  gaverbl   =  0                                  ;REINITIALIZE GLOBAL REVERB VARIABLES
  gaverbr   =  0
endin


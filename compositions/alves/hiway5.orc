;*******************************************************************
;*                                                                 *
;*  ORCHESTRA FILE FOR PART 5 OF HIGHWAY 70 BY BILL ALVES (C)1997  *
;*                                                                 *
;*******************************************************************

  sr        =  44100     
  kr        =  147
  ksmps     =  300
  nchnls    =  2

  gaverbl   init      0                           ;INITIALIZE THE REVERB GLOBALS
  gaverbr   init      0
  gipref    init      15.238173                   ;PITCH REF = B 1ST OCTAVE (A=440)
  gitempo   init      212.001                     ;FOR BEAT TO SECOND CONVERSION
  gklevell  init      1.5                         ;GLOBAL LEVEL CONTROLS
  gklevelr  init      1.5

;******************** PITCH REFERENCE CHANGE ******************** 
instr     1                        ;SETS NEW GLOBAL PITCH REF TO P4
                                        ;MUST BE NUMBERED 1 TO BE CALLED FIRST
  gipref    =  p4
endin

;********************** GLOBAL LEVEL CHANGE ********************** 
instr     2                        ;THIS INSTRUMENT EFFECTS OVERALL CHANGES IN VOLUMe
  ilevellstart =      p4                          ;CRESCENDO OR DECRESCENDO FROM P4 (LEFT)
  ilevelrstart =      p5                          ;AND P5 (RIGHT) TO
  ilevellend   =      p6                          ;LEVEL P6 (LEFT)
  ilevelrend   =      p7                          ;AND P7 (RIGHT)
  itime     =  p3                                 ;OVER THE DURATION P3
  gklevell  line      ilevellstart,itime,ilevellend
  gklevelr  line      ilevelrstart,itime,ilevelrend
endin

;****************************** GLOCK ****************************** 
instr     3                             ;INSTRUMENT TO PLAY BACK GLOCK SAMPLE
                                             ;P4       =    LOUDNESS
                                             ;P5-7     =    PITCH NUM/DEN, OCT
                                             ;P8-10         NOT USED
                                             ;P11      =    PAN
                                             ;P12           NOT USED
                                             ;P13      =    BRIGHTNESS
  ioct      pow       2,(p7-2)
  iorigpch  =  3520                               ;ORIGINAL FREQ OF THE GLOCK SAMPLE
  imaxamp   =  0.004                              ;OVERALL AMP FACTOR
  ipan      =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
  ifreq     =  gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
  irelease  =  0.5                                ;TO EXTEND THE RELEASE PAST P3
  p3        =  p3+irelease

  kenv      linseg    0,0.05,p4,p3-0.05,0
  aorig     diskin    "glockA5.aiff",ifreq/iorigpch,0
  kfiltenv  line      ifreq*p13,p3,ifreq/5        ;LP FILTER ENVELOPE
  afilt     tone      aorig,kfiltenv
  asig      balance   afilt,aorig                 ;NORMALIZE AMPLITUDE
  asig      =  asig*imaxamp*kenv
  asigl     =  asig*ipan*gklevell
  asigr     =  asig*(1-ipan)*gklevelr
            outs      asigl,asigr
  gaverbl   =  gaverbl+asigl*0.5
  gaverbr   =  gaverbr+asigr*0.5
endin

;******************** VOICE-CONVOLVED GUITAR ******************** 
instr     4                             
                                             ;P4       =    LOUDNESS
                                             ;P5-7     =    START PITCH NUM/DEN, OCT
                                             ;P8-10         NOT USED
                                             ;P11      =    PAN
                                             ;P12           NOT USED
                                             ;P13      =    ATTACK
                                             ;P14      =    DECAY
  ioct      pow       2,(p7-2)
  ifreq     =  gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
  ipan      =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
  imaxamp   =  0.004                              ;OVERALL AMP FACTOR
  iattack   =  0.001+p13*60/gitempo               ;CONVERT TO SECONDS
  idecay    =  0.001+p14*60/gitempo               ;CONVERT TO SECONDS
  igtrfreq  =  750                                ;ORIGINAL FREQ OF THE GUITAR SAMPLE
  ivcfreq   =  750                                ;ORIGINAL FREQ OF THE CONVOLVED SAMPLE
  idepth    =  1                                  ;MAX DEPTH OF DELAYS IN SECONDS
  idelay1   linrand   idepth                      ;RANDOM DELAY TIMES UP TO IDEPTH
  idelay2   linrand   idepth
  idelay3   linrand   idepth
  irelease  =  0.2                                ;TO EXTEND THE RELEASE PAST P3
  p3        =  p3+irelease
                                             ;TRIANGULAR LOUDNESS ENVELOPE
  kenv      linseg    0,iattack,p4,p3-iattack-idecay,p4,idecay,0
  agtr      diskin    "warpgtrfs4.aiff",ifreq/igtrfreq ;TIME-SHIFTED GTR SAMPLE
  avc       diskin    "gtrvcfs4.aiff",ifreq/ivcfreq ;GTR CONVOLVED W/VOICE
  agtr      tone      agtr,ifreq                  ;LP FILTER GUITAR
  ares      =  avc*2+agtr                         ;mix them (with more voice)
  a0        delayr    idepth                      ;TRIPLE-TAP DELAY LINE AT RANDOM TIMES
  a1        deltapi   idelay1
  a2        deltapi   idelay2
  a3        deltapi   idelay3
            delayw    ares
  asig      =  ares+a1+a2+a3
  asig      balance   asig,agtr                   ;NORMALIZE AMPLITUDE
  asig      =  asig*kenv*imaxamp
  asigl     =  asig*ipan*gklevell
  asigr     =  asig*(1-ipan)*gklevelr
            outs      asigl,asigr
  gaverbl   =  gaverbl+asigl*0.2
  gaverbr   =  gaverbr+asigr*0.2
endin

;****************************** GUITAR 1 ****************************** 
instr     6                   ;PLAYS A MIX OF TIME-SHIFTED GUITAR AND GLOCK
                                             ;P4       =    LOUDNESS
                                             ;P5-7     =    PITCH NUM/DEN, OCT
                                             ;P8-10         NOT USED
                                             ;P11      =    PAN
                                             ;P12           NOT USED
                                             ;P13      =    BRIGHTNESS
  ioct      pow       2,(p7-3)
  ivcpch    =  750                                ;ORIGINAL FREQ OF THE GUITAR SAMPLE
  iglockpch =  1760                               ;ORIGINAL FREQ OF THE GLOCK SAMPLE
  ipan      =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 SCALE
  imaxamp   =  0.005                              ;OVERALL AMP FACTOR
  ifreq     =  gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
  irelease  =  0.08                               ;TO EXTEND THE RELEASE PAST P3
  p3        =  p3+irelease                        ;

  kenv      linseg    0,0.03,p4,p3-0.03,0
  agtr      diskin    "warpgtrfs4.aiff",ifreq/ivcpch,0 ;SUSTAINED GTR TIMBRE
  agtr      butterlp  agtr,ifreq*p13              ;LP FILTER IT, P13 IS BRIGHTNESS
  aglock    diskin    "glockA5.aiff",ifreq/iglockpch,0
  asig      =  aglock+agtr                        ;MIX THE TWO
  asig      balance   asig,aglock                 ;NORMALIZE AMPLITUDE
  asig      =  asig*kenv*imaxamp
  asigl     =  asig*ipan*gklevell
  asigr     =  asig*(1-ipan)*gklevelr
            outs      asigl,asigr
  gaverbl   =  gaverbl+asigl*0.2
  gaverbr   =  gaverbr+asigr*0.2
endin

;****************************** GUITAR 2 ****************************** 
instr     7                             ;INSTRUMENT TO PLAY DISTORTED GUITAR SAMPLE
                                             ;P4       =    LOUDNESS
                                             ;P5-7     =    PITCH NUM/DEN, OCT
                                             ;P8-10         NOT USED
                                             ;P11      =    PAN
                                             ;P12           NOT USED
                                             ;P13      =    BRIGHTNESS
  ioct      pow       2,(p7-3)
  iorigpch  =  113                                ;ORIGINAL FREQ OF THE GUITAR SAMPLE
  ipan      =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 SCALE
  imaxamp   =  0.0025                             ;OVERALL AMP FACTOR
  ifreq     =  gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
  irelease  =  0.08                               ;TO EXTEND THE RELEASE PAST P3
  p3        =  p3+irelease                        ;

  kenv      linseg    0,0.03,p4,p3-irelease-0.01,p4,irelease,0
  kfiltenv  line      ifreq*p13,p3,ifreq/5        ;LP FILTER ENVELOPE
  asamp     diskin    "disgtrA4.aiff",ifreq/iorigpch,0
  acomb     comb      asamp,99,1/ifreq            ;FILTER OUT EVERYTHING BUT HARMONICS
  aorig     diskin    "disgtrA4.aiff",iorigpch,0
  anoise    comb      aorig,99,1.4142/iorigpch    ;FILTER OUT HARMONICS
  asig      =  anoise+acomb                       ;MIX THE NOISY ATTACK W/ HARMONICS
  asig      butterlp  asig,ifreq*p13              ;AND LP THE RESULT, P13 IS BRIGHTNESS
  asig      balance   asig,asamp                  ;NORMALIZE AMPLITUDE
  asig      =  asig*imaxamp*kenv
  asigl     =  asig*ipan*gklevell
  asigr     =  asig*(1-ipan)*gklevelr
            outs      asigl,asigr
  gaverbl   =  gaverbl+asigl*0.2
  gaverbr   =  gaverbr+asigr*0.2
endin

;****************************** GUITAR 3 ****************************** 
instr     8                                       ;INSTRUMENT TO PLAY DISTORTED GUITAR SAMPLE
                                                       ;P4       =    LOUDNESS
                                                       ;P5-7     =    PITCH NUM/DEN, OCT
                                                       ;P8-10         NOT USED
                                                       ;P11      =    PAN
                                                       ;P12           NOT USED
                                                       ;P13      =    BRIGHTNESS
  ioct      pow       2,(p7-2)
  iorigpch  =  113                                ;ORIGINAL FREQ OF THE GUITAR SAMPLE
  ipan      =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 SCALE
  imaxamp   =  0.0032                             ;OVERALL AMP FACTOR
  ifreq     =  gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
  irelease  =  0.08                               ;TO EXTEND THE RELEASE PAST P3
  p3        =  p3+irelease

  kenv      linseg    0,0.06,p4,p3-irelease-0.01,p4,irelease,0
  kfiltenv  line      ifreq*p13,p3,ifreq/5        ;LP FILTER ENVELOPE
  asamp     diskin    "disgtrA4.aiff",ifreq/iorigpch,0
  asig      comb      asamp,99,1/ifreq            ;FILTER OUT EVERYTHING BUT HARMONICS
  asig      butterlp  asig,ifreq*p13              ;LP FILTER THE REST, P13 IS BRIGHTNESS
  asig      balance   asig,asamp                  ;NORMALIZE AMPLITUDE
  asig      =  asig*imaxamp*kenv
  asigl     =  asig*ipan*gklevell
  asigr     =  asig*(1-ipan)*gklevelr
            outs      asigl,asigr
  gaverbl   =  gaverbl+asigl*0.2
  gaverbr   =  gaverbr+asigr*0.2
endin

;******************************* BASS ******************************* 
instr     9                             ;INSTRUMENT TO PLAY AND DISTORT ELECTRIC BASS SAMPLE
                                             ;P4       =    LOUDNESS
                                             ;P5-7     =    PITCH NUM/DEN, OCT
                                             ;P8-10         NOT USED
                                             ;P11      =    START PAN
                                             ;P12      =    END PAN
                                             ;P13      =    BRIGHTNESS
  ioct      pow       2,(p7-2)
  iorigpch  =  113                                ;ORIGINAL FREQ OF THE GUITAR SAMPLE
  imaxamp   =  0.006                              ;OVERALL AMP FACTOR
  istartpan =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 SCALE
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
  ares      butterhp  ares,ifreq/2                ;FILTER OUT ANY RUMBLE
  aorig     balance   ares,asamp                  ;NORMALIZE AMPLITUDE
  asig      =  asig*imaxamp*kenv
  asigl     =  asig*kpan*gklevell
  asigr     =  asig*(1-kpan)*gklevelr
            outs      asigl,asigr
  gaverbl   =  gaverbl+asigl*0.5
  gaverbr   =  gaverbr+asigr*0.5
endin

;***************************** GLOCK ***************************** 
instr     10                                      ;INSTRUMENT TO PLAY GLOCK SAMPLE
                                                       ;P4       =    LOUDNESS
                                                       ;P5-7     =    PITCH NUM/DEN, OCT
                                                       ;P8-12         NOT USED
                                                       ;P13      =    RELEASE
  ioct      pow       2,(p7+1)
  iorigpch  =  3520                               ;ORIGINAL FREQ OF THE GLOCK SAMPLE
  imaxamp   =  0.003                              ;OVERALL AMP FACTOR
  ifreq     =  gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
  irelease  =  p13                                ;TO EXTEND THE RELEASE PAST P3
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
  ifreq     =  gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
  ipan      =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 SCALE

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


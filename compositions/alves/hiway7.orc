;*******************************************************************
;*                                                                 *
;*  ORCHESTRA FILE FOR PART 7 OF HIGHWAY 70 BY BILL ALVES (C)1997  *
;*                                                                 *
;*******************************************************************

  sr        =  44100
  kr        =  147
  ksmps     =  300
  nchnls    =  2

  gaverbl   init      0                           ;INITIALIZE THE REVERB GLOBALS
  gaverbr   init      0
  gipref    init      13.75                       ;INITIALIZE THE PITCH REFERENCE (A OCTAVE 1)
  gitempo   init      212.001                     ;FOR BEAT TO SECOND CONVERSION
  gklevell  init      0.6                         ;GLOBAL LEVEL CONTROLS
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
instr     3                        ;GUITAR SAMPLE WITH RESONANT UPPER OCTAVE
                                        ;P4       =    LOUDNESS
                                        ;P5-7     =    PITCH NUM/DEN, OCT
                                        ;P8-10         NOT USED
                                        ;P11      =    PAN
                                        ;P12           NOT USED
                                        ;P13      =    BRIGHTNESS
  ioct      pow       2,(p7-2)
  iorigpch  =  223                                ;ORIGINAL FREQ OF THE GUITAR SAMPLE
  ipan      =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
  imaxamp   =  0.0015                             ;OVERALL AMP FACTOR
  ifreq     =  gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
  irelease  =  0.2                                ;TO EXTEND THE RELEASE PAST P3
  p3        =  p3+irelease

  kenv      linseg    0,0.03,p4,p3-irelease,p4,irelease,0
  aorig     diskin    "gtrA4.aiff",ifreq/iorigpch,0
  kfiltenv  line      ifreq*p13,p3,ifreq*2
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

;*********************** FILTER TRAFFIC NOISE *********************** 
instr     4                             ;FILTER TRAFFIC NOISE WITH PORTAMENTO
                                             ;P4       =    LOUDNESS
                                             ;P5-7     =    START PITCH NUM/DEN, OCT
                                             ;P8-10    =    END PITCH NUM/DEN, OCT
                                             ;P11      =    START PAN
                                             ;P12      =    END PAN
                                             ;P13      =    START Q
                                             ;P14      =    END Q
                                             ;P15      =    PEAK TIME
                                             ;P16      =    ATTACK
                                             ;P17      =    DECAY
  istartoct pow       2,(p7-2)
  iendoct   pow       2,(p10-2)
  istartp   =  gipref*istartoct*p5/p6             ;BEGINNING PITCH OF NOTE
  iendp     =  gipref*iendoct*p8/p9               ;ENDING PITCH OF NOTE
  istartq   =  p13                                ;FILTER Q AT BEGINNING OF NOTE
  iendq     =  p14                                ;FILTER Q AT END OF NOTE
  istartpan =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
  iendpan   =  (p12+1)/2                          ;PAN AT END OF NOTE
  imaxamp   =  0.007                              ;OVERALL AMP FACTOR
  ih1       =  ampdb(90)/32000                    ;DEFINE RELATIVE AMPLITUDES OF
  ih3       =  ampdb(80)/32000                    ;HARMONICS
  ih7       =  ampdb(90)/32000
  ipeak     =  p15*60/gitempo                     ;CONVERT TO SECONDS
  iattack   =  p16*60/gitempo                     ;CONVERT TO SECONDS
  idecay    =  p17*60/gitempo                     ;CONVERT TO SECONDS
  idepth    =  0.5                                ;MAX DEPTH OF DELAY IN SECONDS
  idelay1   linrand   idepth                      ;RANDOM DELAY TIME UP TO IDEPTH
  idelay2   linrand   idepth
  idelay3   linrand   idepth
                                                  ;TRIANGULAR LOUDNESS ENVELOPE
  kenv      linseg    0,iattack,p4,p3-iattack-idecay,p4,idecay,0
  kfreqndx  linseg    0,ipeak,0.75,p3-ipeak,1     ;LOOKUP SPLINE PITCH ENVELOPE
  kfreq     tablei    kfreqndx,3,1                ;PITCH ENVELOPE
  kfreq     =  kfreq*(istartp-iendp)+iendp
  kq        expseg    istartq,ipeak,iendq,p3-ipeak,iendq ;Q ENVELOPE
  kbw       =  kfreq/kq                           ;CONVERT TO BANDWIDTH
  kpan      linseg    istartpan,ipeak,iendpan,p3-ipeak,iendpan
  kspeed    linseg    7.5/ipeak,ipeak,7.5/ipeak,p3-ipeak,(8.6/(p3-ipeak))-(7.5/ipeak) ;NATURAL PEAK AT 7.5 SECS IN SAMPLE
  asamp     diskin    "traffic.aiff",kspeed       ;READ NOISY SOUND FILE

  ares1     butterbp  asamp,kfreq,kbw             ;RESONATE EACH HARMONIC IN PARALLEL
  ares3     butterbp  asamp,kfreq*3,kbw
  ares7     butterbp  asamp,kfreq*7,kbw

  ares      =  ares1*ih1+ares3*ih3+ares7*ih7      ;AND MIX THEM TOGETHER
  ares      butterhp  ares,kfreq/2                ;ELIMINATE ANY RUMBLE
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
  istartpan =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
  iendpan   =  (p12+1)/2                          ;PAN AT END OF NOTE
  imaxamp   =  0.001                              ;OVERALL AMP FACTOR
  iorigpch  =  376                                ;ORIGINAL FREQ OF THE GUITAR SAMPLE
  idepth    =  p14                                ;MAX DEPTH OF DELAY IN SECONDS
  idelay1   linrand   idepth                      ;RANDOM DELAY TIMES UP TO IDEPTH
  idelay2   linrand   idepth
  idelay3   linrand   idepth
  ipeak     =  p15*60/gitempo                     ;CONVERT TO SECONDS
                                                       ;TRIANGULAR LOUDNESS ENVELOPE
  kenv      linseg    0,ipeak,p4,0.5*(p3-ipeak),0.2,0.5*(p3-ipeak),0
  kfreqndx  linseg    0,ipeak,0.895,p3-ipeak,1    ;LOOKUP SPLINE PITCH ENVELOPE
  kdoppler  tablei    kfreqndx,2,1                ;PITCH ENVELOPE
  kpan      =  kdoppler*(istartpan-iendpan)+iendpan
  kspeed    =  (kdoppler*(istartp-iendp)+iendp)/iorigpch
  asamp     diskin    "carhorn.aiff",kspeed
  kfiltenv  =  kspeed*iorigpch*p13*(1+kenv)/p4    ;LP FILTER ENVELOPE
  ares      tone      asamp,kfiltenv
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
  gaverbl   =  gaverbl+asigl*3
  gaverbr   =  gaverbr+asigr*3
endin

;****************************** GUITAR 1 ****************************** 
instr     6                        ;INSTRUMENT TO PLAY BASS SAMPLE WITH RESONANT 3RD HARMONIC
                                        ;P4       =    LOUDNESS
                                        ;P5-7     =    PITCH NUM/DEN, OCT
                                        ;P8-10         NOT USED
                                        ;P11      =    PAN
                                        ;P12      =    ATTACK
                                        ;P13      =    BRIGHTNESS
  ioct      pow       2,(p7-1)
  iorigpch  =  113                                ;ORIGINAL FREQ OF THE BASS SAMPLE
  ipan      =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
  imaxamp   =  0.005                              ;OVERALL AMP FACTOR
  ifreq     =  gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
  irelease  =  0.1                                ;TO EXTEND THE RELEASE PAST P3
  p3        =  p3+irelease                        ;

  kenv      linseg    0,p12,p4,p3*0.5,p4,p3*0.5-p12,0
  kfiltenv  linseg    ifreq*p13,p3,ifreq*p13/2    ;LP FILTER ENVELOPE
  asamp     diskin    "BassExtA3.aiff",ifreq/iorigpch,0.3
  aharm     butterbp  asamp,ifreq*3,10            ;RESONATE 3RD HARMONIC (12TH)
  alp       butterlp  asamp,kfiltenv              ;LP FILTER IN PARALLEL
  alp       tone      alp,kfiltenv                ;AND AGAIN IN SERIES
  asig      =  aharm*3+alp                        ;MIX THE TWO
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
                                             ;P12      =    ATTACK
                                             ;P13      =    BRIGHTNESS
  ioct      pow       2,(p7-1)
  iorigpch  =  113                                ;ORIGINAL FREQ OF THE BASS SAMPLE
  imaxamp   =  0.003                              ;OVERALL AMP FACTOR
  ipan      =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
  ifreq     =  gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
  irelease  =  0.05                               ;TO EXTEND THE RELEASE PAST P3
  p3        =  p3+irelease                        ;

  kenv      linseg    0,p12,p4,p3-irelease,p4,irelease,0
  asig      diskin    "BassA3.aiff",ifreq/iorigpch,0
  asamp     tablei    ((asig/32768)+1)/2,1,1      ;NON-LINEAR DISTORTION LOOKUP
  kfiltenv  linseg    ifreq*p13,0.5,ifreq*p13/8,0.5,ifreq*p13,p3-1,ifreq*p13
  ares      butterlp  asamp,kfiltenv              ;LP FILTER SWEEP (ON LONG NOTES)
  aorig     balance   ares,asamp                  ;NORMALIZE AMPLITUDE
  asig      =  asig*imaxamp*kenv
  asigl     =  asig*ipan*gklevell
  asigr     =  asig*(1-ipan)*gklevelr
            outs      asigl,asigr
  gaverbl   =  gaverbl+asigl*0.5
  gaverbr   =  gaverbr+asigr*0.5
endin

;****************************** GUITAR 3 ****************************** 
instr     8                             ;ANOTHER INSTRUMENT TO DISTORT ELECTRIC BASS SAMPLE
                                             ;P4       =    LOUDNESS
                                             ;P5-7     =    PITCH NUM/DEN, OCT
                                             ;P8-10         NOT USED
                                             ;P11      =    START PAN
                                             ;P12      =    END PAN
                                             ;P13      =    BRIGHTNESS
  ioct      pow       2,(p7-1)
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

;************************* DISTORTED GUITAR ************************* 
instr     9                                       ;INSTRUMENT TO PLAY DISTORTED GUITAR SAMPLE
                                                       ;P4       =    LOUDNESS
                                                       ;P5-7     =    PITCH NUM/DEN, OCT
                                                       ;P8-10         NOT USED
                                                       ;P11      =    PAN
                                                       ;P12           NOT USED
                                                       ;P11      =    BRIGHTNESS
  ioct      pow       2,(p7-1)
  iorigpch  =  113                                ;ORIGINAL FREQ OF THE GUITAR SAMPLE
  ipan      =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
  imaxamp   =  0.0013                             ;OVERALL AMP FACTOR
  ifreq     =  gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
  irelease  =  0.08                               ;TO EXTEND THE RELEASE PAST P3
  p3        =  p3+irelease                        ;

  kenv      linseg    p4,p3*0.5,p4,p3*0.5,0
  aorig     diskin    "disgtrA4.aiff",ifreq/iorigpch,0
  asig      =  aorig*imaxamp*kenv
  asig      tone      asig,ifreq*p13              ;LP FILTER, P13 IS BRIGHTNESS
  asig      balance   asig,aorig                  ;NORMALIZE AMPLITUDE
  asigl     =  asig*ipan*gklevell
  asigr     =  asig*(1-ipan)*gklevelr
            outs      asigl,asigr
  gaverbl   =  gaverbl+asigl
  gaverbr   =  gaverbr+asigr
endin

;***************************** GLOCK ***************************** 
instr     10                                      ;INSTRUMENT TO PLAY GLOCK SAMPLE
                                                       ;P4       =    LOUDNESS
                                                       ;P5-7     =    PITCH NUM/DEN, OCT
                                                       ;P8-11         NOT USED
                                                       ;P12      =    RELEASE
                                                       ;P13      =    BRIGHTNESS
  ioct      pow       2,p7+1
  iorigpch  =  3520                               ;ORIGINAL FREQ OF THE GLOCK SAMPLE
  imaxamp   =  0.006                              ;OVERALL AMP FACTOR
  ipan      =  (1+p11)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
  ifreq     =  gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
  irelease  =  p12                                ;TO EXTEND THE RELEASE PAST P3
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

;***************************** CAR DOOR ***************************** 
instr     11                                      ;DRUM-LIKE SOUND
                                                       ;P4       =    LOUDNESS
                                                       ;P5-7     =    PITCH NUM/DEN, OCT
                                                       ;P8-10         NOT USED
                                                       ;P11      =    PAN
  ioct      pow       2,(p7-2)
  iorigpch  =  175                                ;REFERENCE FREQ OF THE CAR DOOR SAMPLE
  ipan      =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
  imaxamp   =  0.005                              ;OVERALL AMP FACTOR
  ifreq     =  gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
  irelease  =  0                                  ;TO EXTEND THE RELEASE PAST P3
  p3        =  p3+irelease                        ;

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
instr     12                                      ;INSTRUMENT TO PLAY GONG SAMPLE IN 8VES
                                                       ;P4       =    LOUDNESS
                                                       ;P5-7     =    PITCH NUM/DEN, OCT
                                                       ;P8-10         NOT USED
                                                       ;P11      =    PAN
  ioct      pow       2,(p7-3)
  iorigpch  =  55                                 ;ORIGINAL FREQ OF THE GONG SAMPLE
  imaxamp   =  0.004                              ;OVERALL AMP FACTOR
  ipan      =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
  ifreq     =  gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
  irelease  =  0                                  ;TO EXTEND THE RELEASE PAST P3
  p3        =  p3+irelease                        ;

  kenv      linseg    p4,p3-0.1,p4,0.1,0
  aorig     diskin    "Gong.aiff",ifreq/iorigpch,0 ;READ GONG SAMPLE
  aoct      diskin    "Gong.aiff",2*ifreq/iorigpch,0 ;GONG SAMPLE 8VA
  asig      =  (aoct+aorig)*imaxamp*kenv          ;MIX THEM
  asigl     =  asig*ipan*gklevell
  asigr     =  asig*(1-ipan)*gklevelr
            outs      asigl,asigr
  gaverbl   =  gaverbl+asigl
  gaverbr   =  gaverbr+asigr
endin

;*************************** MID CAR DOOR *************************** 
instr     13                                           ;DRUM-LIKE SOUND
                                                            ;P4       =    LOUDNESS
                                                            ;P5-7     =    PITCH NUM/DEN, OCT
                                                            ;P8-10         NOT USED
                                                            ;P11      =    PAN
  ioct      pow       2,(p7-2)
  iorigpch  =  175                                ;REFERENCE FREQ OF THE CAR DOOR SAMPLE
  imaxamp   =  0.005                              ;OVERALL AMP FACTOR
  ipan      =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
  ifreq     =  gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
  irelease  =  0                                  ;TO EXTEND THE RELEASE PAST P3
  p3        =  p3+irelease                        ;

  kenv      linseg    p4,p3-0.1,p4,0.1,0
  aorig     diskin    "MidCarDr.aiff",ifreq/iorigpch,0
  asig      =  aorig*imaxamp*kenv
  asigl     =  asig*ipan*gklevell
  asigr     =  asig*(1-ipan)*gklevelr
            outs      asigl,asigr
  gaverbl   =  gaverbl+asigl*0.01
  gaverbr   =  gaverbr+asigr*0.01
endin

;******************** VOICE-CONVOLVED GUITAR ******************** 
instr     14                       ;INSTRUMENT TO PLAY GUITAR CONVOLVED WITH VOICE SAMPLE
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
  imaxamp   =  0.01                               ;OVERALL AMP FACTOR
  iattack   =  0.001+p13*60/gitempo               ;CONVERT TO SECONDS
  idecay    =  0.001+p14*60/gitempo               ;CONVERT TO SECONDS
  ipeak     =  0.001+p15*60/gitempo               ;CONVERT TO SECONDS
  igtrfreq  =  750                                ;ORIGINAL FREQ OF THE GUITAR SAMPLE
  ivcfreq   =  750                                ;ORIGINAL FREQ OF THE CONVOLVED SAMPLE
  idepth    =  0.5                                ;MAX DEPTH OF DELAY IN SECONDS
  idelay1   linrand   idepth                      ;RANDOM DELAY TIMES UP TO IDEPTH
  idelay2   linrand   idepth
  idelay3   linrand   idepth
  irelease  =  0.2                                ;TO EXTEND RELEASE PAST P3
  p3        =  p3+irelease
                                                  ;TRIANGULAR LOUDNESS ENVELOPE
  kenv      linseg    0,iattack,p4,p3-iattack-idecay,p4,idecay,0
  kfreqndx  linseg    0,ipeak,0.75,p3-ipeak,1     ;LOOKUP SPLINE PITCH ENVELOPE
  kfreq     tablei    kfreqndx,3,1                ;PITCH ENVELOPE
  kfreq     =  kfreq*(istartp-iendp)+iendp
  kpan      linseg    istartpan,ipeak,iendpan,p3-ipeak,iendpan
  agtr      diskin    "warpgtrfs4.aiff",kfreq/igtrfreq ;TIME-SHIFTED GUITAR SAMPLE
  avc       diskin    "gtrvcfs4.aiff",kfreq/ivcfreq ;VOICE-CONVOLVED GTR SAMPLE
  agtr      tone      agtr,kfreq*1.5              ;lp filter gtr
  ares      =  avc*2+agtr                         ;AND MIX THEM
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

;******************************* BASS ******************************* 
instr     15                            ;another instrument to distort electric bass sample
                                             ;p4       =    loudness
                                             ;p5-7     =    pitch num/den, oct
                                             ;p8-10         not used
                                             ;p11      =    start pan
                                             ;p12      =    end pan
                                             ;p13      =    brightness
  ioct      pow       2,(p7-1)
  iorigpch  =  113                                ;ORIGINAL FREQ OF THE BASS SAMPLE
  imaxamp   =  0.01                               ;OVERALL AMP FACTOR
  istartpan =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
  iendpan   =  (p12+1)/2                          ;PAN AT END OF NOTE
  ifreq     =  gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
  irelease  =  0.05                               ;TO EXTEND THE RELEASE PAST P3
  p3        =  p3+irelease                        ;

  kpan      linseg    istartpan,p3,iendpan
  kenv      linseg    0,0.02,p4,p3-irelease,p4,irelease,0
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

;****************************** HIGH GTR ****************************** 
instr     16                                 ;INSTRUMENT TO PLAY A COMBED DISTORTED GUITAR
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
  p3        =  p3 + irelease

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
  gaverbl   =  gaverbl+ asigl*0.2
  gaverbr   =  gaverbr+asigr*0.2
endin

;************************** BREAKING GLASS ************************** 
instr     17                  ;INSTRUMENT TO BANDPASS HARMONICS FROM A BREAKING GLASS SAMPLE
                                   ;P4       =    LOUDNESS
                                   ;P5-7     =    PITCH NUM/DEN, OCT
                                   ;P8-10         NOT USED
                                   ;P11      =    PAN
                                   ;P12      =    ATTACK
                                   ;P13      =    BRIGHTNESS
  ioct      pow       2,p7+1
;iorigpch      =         3520                ;REFERENCE FREQ OF THE GLASS SAMPLE
  ipan      =  (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
  imaxamp   =  0.005                              ;OVERALL AMP FACTOR
  ifreq     =  gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
  irelease  =  0.2                                ;TO EXTEND THE RELEASE PAST P3
  p3        =  p3 + irelease

  kenv      linseg    0,p12,p4,p3-0.06,0
  asamp     diskin    "glass.aiff",1,0.2
  asamp     butterhp  asamp,ifreq/2               ;ELIMINATE ANYTHING BELOW FUND.
  ah2       butterbp  asamp,ifreq*2,50            ;RESONATE HARMONICS 2-19
  ah3       butterbp  asamp,ifreq*3,50            ;IN PARALLEL
  ah4       butterbp  asamp,ifreq*4,50            ;COMB COULD DO SOMETHING SIMILAR
  ah5       butterbp  asamp,ifreq*5,50            ;BUT PROVED TOO UNSTABLE
  ah6       butterbp  asamp,ifreq*6,50
  ah7       butterbp  asamp,ifreq*7,50
  ah8       butterbp  asamp,ifreq*8,50
  ah9       butterbp  asamp,ifreq*9,50
  ah10      butterbp  asamp,ifreq*10,50
  ah11      butterbp  asamp,ifreq*11,50
  ah12      butterbp  asamp,ifreq*12,50
  ah13      butterbp  asamp,ifreq*13,50
  ah14      butterbp  asamp,ifreq*14,50
  ah15      butterbp  asamp,ifreq*15,50
  ah16      butterbp  asamp,ifreq*16,50
  ah17      butterbp  asamp,ifreq*17,50
  ah18      butterbp  asamp,ifreq*18,50
  ah19      butterbp  asamp,ifreq*19,50
  asig      =  ah2+ah3+ah4+ah5+ah6+ah7+ah8+ah9+ah10+ah11+ah12+ah13+ah14+ah15+ah16+ah17+ah18+ah19+asamp*0.5 ;mix the harmonics with original
  asig      balance   asig,asamp                  ;NORMALIZE AMPLITUDE
  asig      =  asig*imaxamp*kenv
  asigl     =  asig*ipan*gklevell
  asigr     =  asig*(1-ipan)*gklevelr
            outs      asigl,asigr
  gaverbl   =  gaverbl+ asigl*0.2
  gaverbr   =  gaverbr+asigr*0.2
endin

;***************************** REVERB ***************************** 
instr     99                            ;REVERB INSTRUMENT, RUNS ALWAYS, MUST BE NUMBERED LAST
  averbl    reverb    gaverbl,2                   ;USE DIFFERENT REVERB ALGORITHMS
  averbr    reverb2   gaverbr,1.5,0.3             ;FOR LEFT AND RIGHT CHANNELS
            outs      averbl*0.2+averbr*0.05,averbl*0.05+averbr*0.2
  gaverbl   =  0                                  ;REINITIALIZE GLOBAL REVERB VARIABLES
  gaverbr   =  0
endin


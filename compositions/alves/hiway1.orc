;*******************************************************************
;*                                                                 *
;*  ORCHESTRA FILE FOR PART 1 OF HIGHWAY 70 BY BILL ALVES (C)1997  *
;*                                                                 *
;*******************************************************************

sr             =         44100
kr             =         147
ksmps          =         300
nchnls         =         2

gaverbl        init      0              ;INITIALIZE THE REVERB GLOBALS
gaverbr        init      0
gipref         init      18.715278      ;INITIALIZE THE PITCH REFERENCE (EB OCTAVE 1)
gitempo        init      212.001        ;FOR BEAT TO SECOND CONVERSION
gklevell       init      0.5            ;GLOBAL LEVEL CONTROLS
gklevelr       init      0.4

;******************** PITCH REFERENCE CHANGE ******************** 
     instr     1                        ;SETS NEW GLOBAL PITCH REF TO P4
                                        ;MUST BE NUMBERED 1 TO BE CALLED FIRST
gipref         =         p4
               endin

;********************** GLOBAL LEVEL CHANGE ********************** 
     instr     2                        ;THIS INSTRUMENT EFFECTS OVERALL CHANGES IN VOLUME
ilevellstart   =         p4             ;CRESCENDO OR DECRESCENDO FROM P4 (LEFT)
ilevelrstart   =         p5             ;AND P5 (RIGHT) TO
ilevellend     =         p6             ;LEVEL P6 (LEFT)
ilevelrend     =         p7             ;AND P7 (RIGHT)
itime          =         p3             ;OVER THE DURATION P3
gklevell       line      ilevellstart,itime,ilevellend
gklevelr       line      ilevelrstart,itime,ilevelrend
               endin

;****************************** HIGH GTR ****************************** 
     instr     3                        ;Guitar sample with resonant upper octave
                                        ;p4       =    LOUDNESS
                                        ;p5-7     =    PITCH NUM/DEN, OCT
                                        ;p8-10         NOT USED
                                        ;p11      =    PAN
                                        ;p12           NOT USED
                                        ;p13      =    BRIGHTNESS
ioct           pow      2,(p7-2)
iorigpch       =         223            ;ORIGINAL FREQ OF THE GUITAR SAMPLE
ipan           =         (p11+1)/2      ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
imaxamp        =         0.002               ;OVERALL AMP FACTOR
ifreq          =         gipref*ioct*p5/p6   ;CALCULATE FREQUENCY OF NOTE
irelease       =         0.2                 ;TO EXTEND THE RELEASE PAST P3
p3             =         p3+irelease

kenv           linseg    0,0.03,p4,p3-irelease,p4,irelease,0
aorig          diskin    "gtrA4.aiff",ifreq/iorigpch,0
kfiltenv       line      ifreq*p13,p3,ifreq*2     ;FILTER ENVELOPE, P13 IS BRIGHTNESS
afilt          butterlp  aorig,kfiltenv
afilt          balance   afilt,aorig              ;NORMALIZE AMPLITUDE
acomb          comb      aorig,9,2/ifreq          ;RESONATE UPPER OCTAVE
acomb          balance   acomb,aorig              ;NORMALIZE AMPLITUDE
asig           =         (acomb+afilt)*imaxamp*kenv
asigl          =         asig*ipan*gklevell
asigr          =         asig*(1-ipan)*gklevelr
               outs      asigl,asigr
gaverbl        =         gaverbl+asigl*0.1
gaverbr        =         gaverbr+asigr*0.1
               endin

;*********************** FILTER TRAFFIC NOISE *********************** 
     instr     4                                  ;FILTER TRAFFIC NOISE WITH PORTAMENTO
                                                  ;p4       =    LOUDNESS
                                                  ;p5-7     =    START PITCH NUM/DEN, OCT
                                                  ;p8-10    =    END PITCH NUM/DEN, OCT
                                                  ;p11      =    START PAN
                                                  ;p12      =    END PAN
                                                  ;p13      =    START Q
                                                  ;p14      =    END Q
                                                  ;p15      =    PEAK TIME
                                                  ;p16      =    ATTACK
                                                  ;p17      =    DECAY
istartoct      pow      2,(p7-2)
iendoct        pow      2,(p10-2)
istartp        =         gipref*istartoct*p5/p6   ;BEGINNING PITCH OF NOTE
iendp          =         gipref*iendoct*p8/p9     ;ENDING PITCH OF NOTE
istartq        =         p13                      ;FILTER Q AT BEGINNING OF NOTE
iendq          =         p14                      ;FILTER Q AT END OF NOTE
istartpan      =         (1+p11)/2                ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
iendpan        =         (1+p12)/2
imaxamp        =         0.002                    ;OVERALL AMP FACTOR
ih1            =         ampdb(90)/32000          ;DEFINE RELATIVE AMPLITUDES OF
ih3            =         ampdb(80)/32000          ;HARMONICS
ih7            =         ampdb(90)/32000
ipeak          =         p15*60/gitempo           ;CONVERT TO SECONDS
iattack        =         p16*60/gitempo           ;CONVERT TO SECONDS
idecay         =         p17*60/gitempo           ;CONVERT TO SECONDS
idepth         =         0.5                      ;MAX DEPTH OF DELAYS IN SECONDS
idelay1        linrand  idepth                   ;RANDOM DELAY TIME UP TO IDEPTH
idelay2        linrand  idepth
idelay3        linrand  idepth
                                                  ;TRIANGULAR LOUDNESS ENVELOPE
kenv           linseg    0,iattack,p4,p3-iattack-idecay,p4,idecay,0
kfreqndx       linseg    0,ipeak,0.75,p3-ipeak,1  ;LOOKUP SPLINE PITCH ENVELOPE
kfreq          tablei    kfreqndx,3,1             ;PITCH ENVELOPE
kfreq          =         kfreq*(istartp-iendp)+iendp
kq             expseg    istartq,ipeak,iendq,p3-ipeak,iendq ;q envelope
kbw            =         kfreq/kq       ;convert to bandwidth
kpan           linseg    istartpan,ipeak,iendpan,p3-ipeak,iendpan
kspeed         linseg    7.5/ipeak,ipeak,7.5/ipeak,p3-ipeak,(8.6/(p3-ipeak))-(7.5/ipeak)  ;NATURAL PEAK AT 7.5 SECS IN SAMPLE
asamp          diskin    "traffic.aiff",kspeed    ;READ NOISY SOUND FILE

ares1          butterbp  asamp,kfreq,kbw          ;RESONATE EACH HARMONIC IN PARALLEL
ares3          butterbp  asamp,kfreq*3,kbw
ares7          butterbp  asamp,kfreq*7,kbw

ares           =         ares1*ih1+ares3*ih3+ares7*ih7      ;mix the harmonics
ares           butterhp  ares,kfreq/2                       ;MAKE SURE THERE IS NO RUMBLE
aorig          balance   ares,asamp                         ;NORMALIZE AMPLITUDE
a0             delayr    idepth                             ;TRIPLE-TAP DELAY LINE AT RANDOM TIMES
a1             deltapi   idelay1
a2             deltapi   idelay2
a3             deltapi   idelay3
               delayw    aorig
asig           =         (aorig+a1+a2+a3)*kenv*imaxamp
asigl          =         asig*kpan*gklevell
asigr          =         asig*(1-kpan)*gklevelr
               outs      asigl,asigr
gaverbl        =         gaverbl+asigl
gaverbr        =         gaverbr+asigr
               endin

;****************************** DOPPLER ****************************** 
     instr     5                        ;PLAYS BACK CAR HORN SAMPLE WITH DOPPLER-LIKE PITCH SLIDE
                                        ;p4       =    LOUDNESS
                                        ;p5-7     =    START PITCH NUM/DEN, OCT
                                        ;p8-10    =    END PITCH NUM/DEN, OCT
                                        ;p11      =    START PAN
                                        ;p12      =    END PAN
                                        ;p13      =    BRIGHTNESS
                                        ;p14           NOT USED
                                        ;p15      =    PEAK TIME
istartoct      pow      2,(p7-3)
iendoct        pow      2,(p10-3)
istartp        =         gipref*istartoct*p5/p6             ;BEGINNING PITCH OF NOTE
iendp          =         gipref*iendoct*p8/p9               ;ENDING PITCH OF NOTE
istartpan      =         (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 SCALE
iendpan        =         (p12+1)/2                          ;PAN AT END OF NOTE
imaxamp        =         0.008                              ;OVERALL AMP FACTOR
iorigpch       =         376                                ;ORIGINAL PITCH OF CAR HORN FUND.
ipeak          =         p15*60/gitempo ;convert to seconds

                                                            ;TRIANGULAR LOUDNESS ENVELOPE
kenv           linseg    0,ipeak,p4,p3-ipeak,0 ;p4 is loudness, ipeak is peak time
kpan           linseg    istartpan,ipeak,iendpan,p3-ipeak,iendpan
kfreqndx       linseg    0,ipeak,0.895,p3-ipeak,1           ;LOOKUP SPLINE PITCH ENVELOPE
kfreq          tablei    kfreqndx,2,1                       ;PITCH ENVELOPE
kspeed         =         (kfreq*(istartp-iendp)+iendp)/iorigpch
asamp          diskin    "carhorn.aiff",kspeed
kfiltenv       =         kspeed*iorigpch*p13*(1+kenv)/p4    ;LP FILTER ENVELOPE
ares           tone      asamp,kfiltenv
aorig          balance   ares,asamp                         ;NORMALIZE AMPLITUDE
asig           =         aorig*kenv*imaxamp
asigl          =         asig*kpan*gklevell
asigr          =         asig*(1-kpan)*gklevelr
               outs      asigl,asigr
gaverbl        =         gaverbl+asigl
gaverbr        =         gaverbr+asigr
               endin

;****************************** GUITAR 1 ****************************** 
     instr     6                             ;INSTRUMENT TO PLAY AND DISTORT ELECTRIC BASS SAMPLE
                                             ;p4       =    LOUDNESS
                                             ;p5-7     =    PITCH NUM/DEN, OCT
                                             ;p8-10         NOT USED
                                             ;p11      =    PAN
                                             ;p12      =    ATTACK
                                             ;p13      =    BRIGHTNESS
ioct           pow      2,(p7-2)
iorigpch       =         113                 ;FREQ OF ORIGINAL BASS SAMPLE
imaxamp        =         0.003               ;OVERALL AMP FACTOR
ipan           =         (1+p11)/2           ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
ifreq          =         gipref*ioct*p5/p6   ;CALCULATE FREQUENCY OF NOTE
irelease       =         0.05                ;TO EXTEND THE RELEASE PAST P3
p3             =         p3+irelease         ;

kenv           linseg    0,p12,p4,p3-irelease-p12,p4,irelease,0
asig           diskin    "BassA3.aiff",ifreq/iorigpch,0
asamp          tablei    ((asig/32768)+1)/2,1,1             ;NON-LINEAR DISTORTION LOOKUP
kfiltenv       linseg    ifreq*p13,0.5,ifreq*p13/8,0.5,ifreq*p13,p3-1,ifreq*p13
ares           butterlp  asamp,kfiltenv                     ;LP FILTER SWEEP (ON LONG NOTES)
aorig          balance   ares,asamp                         ;NORMALIZE AMPLITUDE
asig           =         asig*imaxamp*kenv
asigl          =         asig*ipan*gklevell
asigr          =         asig*(1-ipan)*gklevelr
               outs      asigl,asigr
gaverbl        =         gaverbl+asigl*0.5
gaverbr        =         gaverbr+asigr*0.5
               endin

;****************************** GUITAR 2 ****************************** 
     instr     7                                            ;INSTRUMENT TO DISTORT BASS SAMPLE
                                                            ;p4       =    LOUDNESS
                                                            ;p5-7     =    PITCH NUM/DEN, OCT
                                                            ;p8-10         NOT USED
                                                            ;p11      =    PAN
                                                            ;p12      =    ATTACK
                                                            ;p13      =    BRIGHTNESS
ioct           pow      2,(p7-2)
iorigpch       =         113                                ;FREQ OF ORIGINAL BASS SAMPLE
imaxamp        =         0.0035                             ;OVERALL AMP FACTOR
ipan           =         (1+p11)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
ifreq          =         gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
irelease       =         0.05                               ;TO EXTEND THE RELEASE PAST P3
p3             =         p3+irelease;

kenv           linseg    0,p12,p4,p3-irelease-p12,p4,irelease,0
asig           diskin    "BassA3.aiff",ifreq/iorigpch,0
asamp          tablei    ((asig/32768)+1)/2,1,1             ;NON-LINEAR DISTORTION LOOKUP
kfiltenv       linseg    ifreq*p13,0.5,ifreq*p13/8,0.5,ifreq*p13,p3-1,ifreq*p13
ares           butterlp  asamp,kfiltenv                     ;LP FILTER SWEEP (ON LONG NOTES)
aorig          balance   ares,asamp                         ;NORMALIZE AMPLITUDE
asig           =         asig*imaxamp*kenv
asigl          =         asig*ipan*gklevell
asigr          =         asig*(1-ipan)*gklevelr
               outs      asigl,asigr
gaverbl        =         gaverbl+asigl*0.5
gaverbr        =         gaverbr+asigr*0.5
               endin

;****************************** GUITAR 3 ****************************** 
     instr     8                                            ;ANOTHER INSTRUMENT TO DISTORT BASS
                                                            ;p4       =    LOUDNESS
                                                            ;p5-7     =    PITCH NUM/DEN, OCT
                                                            ;p8-10         NOT USED
                                                            ;p11      =    START PAN
                                                            ;p12      =    END PAN
                                                            ;p13      =    BRIGHTNESS
ioct           pow      2,(p7-2)  
iorigpch       =         113                                ;FREQ OF ORIGINAL BASS SAMPLE
imaxamp        =         0.003                              ;OVERALL AMP FACTOR
istartpan      =         (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 SCALE
iendpan        =         (p12+1)/2
ifreq          =         gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
irelease       =         0.05                               ;TO EXTEND THE RELEASE PAST P3
p3             =         p3+irelease;

kpan           linseg    istartpan,p3,iendpan
kenv           linseg    p4,p3-irelease,p4,irelease,0
asig           diskin    "BassA3.aiff",ifreq/iorigpch,0
asamp          tablei    ((asig/32768)+1)/2,1,1             ;NON-LINEAR DISTORTION LOOKUP
kfiltenv       linseg    ifreq*p13,0.5,ifreq*p13/8,0.5,ifreq*p13,p3-1,ifreq*p13
ares           butterlp  asamp,kfiltenv ;lp filter sweep (on long notes)
aorig          balance   ares,asamp                         ;NORMALIZE AMPLITUDE
asig           =         asig*imaxamp*kenv
asigl          =         asig*kpan*gklevell
asigr          =         asig*(1-kpan)*gklevelr
               outs      asigl,asigr
gaverbl        =         gaverbl+asigl*0.5
gaverbr        =         gaverbr+asigr*0.5
               endin

;******************************* BASS ******************************* 
     instr     9                                            ;BASS INSTRUMENT
                                                            ;p4       =    LOUDNESS
                                                            ;p5-7     =    PITCH NUM/DEN, OCT
                                                            ;p8-10         NOT USED
                                                            ;p11      =    START PAN
                                                            ;p12      =    END PAN
                                                            ;p13      =    BRIGHTNESS
ioct           pow      2,(p7-2)
iorigpch       =         113                                ;FREQ OF ORIGINAL BASS SAMPLE
imaxamp        =         0.008                              ;OVERALL AMP FACTOR
istartpan      =         (p11+1)/2                          ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
iendpan        =         (p12+1)/2
ifreq          =         gipref*ioct*p5/p6                  ;CALCULATE FREQUENCY OF NOTE
irelease       =         0.07                               ;TO EXTEND THE RELEASE PAST P3
p3             =         p3+irelease;

kpan           linseg    istartpan,p3,iendpan
kenv           linseg    p4,p3-irelease,p4,irelease,0
asig           diskin    "BassA3.aiff",ifreq/iorigpch,0
asamp          tablei    ((asig/32768)+1)/2,1,1             ;NON-LINEAR DISTORTION LOOKUP
kfiltenv       linseg    ifreq*p13,0.5,ifreq*p13/8,0.5,ifreq*p13,p3-1,ifreq*p13
ares           butterlp  asamp,kfiltenv                     ;LP FILTER SWEEP (ON LONG NOTES)
aorig          balance   ares,asamp                         ;NORMALIZE AMPLITUDE
asig           =         asig*imaxamp*kenv
asigl          =         asig*kpan*gklevell
asigr          =         asig*(1-kpan)*gklevelr
               outs      asigl,asigr
gaverbl        =         gaverbl+asigl*0.5
gaverbr        =         gaverbr+asigr*0.5
               endin

;***************************** GLOCK ***************************** 
     instr     10                  ;INSTRUMENT TO PLAY GLOCK SAMPLE WITH LONG RELEASE & RANDOM PAN
                                   ;p4       =    LOUDNESS
                                   ;p5-7     =    PITCH NUM/DEN, OCT
                                   ;p8-12         NOT USED
                                   ;p13      =    BRIGHTNESS
ioct           pow      2,p7
iorigpch       =         3520                     ;FREQ OF ORIGINAL GLOCK SAMPLE
imaxamp        =         0.003                    ;OVERALL AMP FACTOR
ifreq          =         gipref*ioct*p5/p6        ;CALCULATE FREQUENCY OF NOTE
irelease       =         5                        ;TO EXTEND THE RELEASE WAY PAST p3
p3             =         p3+irelease;
ipan           linrand  1                        ;RANDOM PAN FOR EACH NOTE

kenv           linseg    p4,p3-0.1,p4,0.1,0
aorig          diskin    "glockA5.aiff",ifreq/iorigpch,0
kfiltenv       line      ifreq*p13,p3,ifreq/5     ;LP FILTER ENVELOPE
afilt          butterlp  aorig,kfiltenv
asig           balance   afilt,aorig              ;NORMALIZE AMPLITUDE
asig           =         asig*imaxamp
asigl          =         asig*ipan*gklevell
asigr          =         asig*(1-ipan)*gklevelr
               outs      asigl,asigr
gaverbl        =         gaverbl+asigl
gaverbr        =         gaverbr+asigr
               endin

;************************* DISTORTED GUITAR ************************* 
     instr     11                                 ;INSTRUMENT TO PLAY DISTORTED GUITAR SAMPLE
                                                  ;p4  =    LOUDNESS
                                                  ;p5-7     =    PITCH NUM/DEN, OCT
                                                  ;p8-10         NOT USED
                                                  ;p11 =    PAN
ioct           pow      2,(p7-3)
iorigpch       =         113                      ;FREQ OF ORIGINAL GUITAR SAMPLE
ipan           =         (p11+1)/2                ;CONVERT PAN FROM -1/1 TO 0/1 RANGE
imaxamp        =         0.0025                   ;OVERALL AMP FACTOR
ifreq          =         gipref*ioct*p5/p6        ;CALCULATE FREQUENCY OF NOTE
irelease       =         0.08                     ;TO EXTEND THE RELEASE PAST P3
p3             =         p3+irelease;

kenv           linseg    p4,p3-irelease,p4,irelease,0
aorig          diskin    "disgtrA4.aiff",ifreq/iorigpch,0
asig           =         aorig*imaxamp*kenv
asigl          =         asig*ipan*gklevell
asigr          =         asig*(1-ipan)*gklevelr
               outs      asigl,asigr
gaverbl        =         gaverbl+asigl
gaverbr        =         gaverbr+asigr
               endin

;***************************** GONG ***************************** 
     instr     12                                 ;INSTRUMENT TO PLAY GONG SAMPLE IN OCTAVES
                                                  ;p4       =    LOUDNESS
                                                  ;p5-7     =    PITCH NUM/DEN, OCT
                                                  ;p8-10         NOT USED
                                                  ;p11      =    PAN
ioct           pow      2,(p7-3)
iorigpch       =         55                       ;FREQ OF ORIGINAL GONG SAMPLE
imaxamp        =         0.004                    ;OVERALL AMP FACTOR
ifreq          =         gipref*ioct*p5/p6        ;CALCULATE FREQUENCY OF NOTE
irelease       =         0                        ;TO EXTEND THE RELEASE PAST P3
p3             =         p3+irelease;
ipan           =         (p11+1)/2                ;CONVERT PAN FROM -1/1 TO 0/1 RANGE

kenv           linseg    p4,p3-0.1,p4,0.1,0
aorig          diskin    "Gong.aiff",ifreq/iorigpch,0       ;ORIGINAL FREQ
aoct           diskin    "Gong.aiff",2*ifreq/iorigpch,0     ;OCTAVE HIGHER
asig           =         (aoct+aorig)*imaxamp*kenv          ;MIX THE TWO
asigl          =         asig*ipan*gklevell
asigr          =         asig*(1-ipan)*gklevelr
               outs      asigl,asigr
gaverbl        =         gaverbl+asigl
gaverbr        =         gaverbr+asigr
               endin

;***************************** REVERB ***************************** 
     instr     99                                 ;REVERB INSTRUMENT, RUNS ALWAYS, MUST BE NUMBERED LAST
averbl         reverb    gaverbl,2                ;USE DIFFERENT REVERB ALGORITHMS
averbr         reverb2   gaverbr,1.5,0.3          ;FOR LEFT AND RIGHT CHANNELS
               outs      averbl*0.2+averbr*0.05,averbl*0.05+averbr*0.2
gaverbl        =         0                        ;REINITIALIZE GLOBAL REVERB VARIABLES
gaverbr        =         0
               endin


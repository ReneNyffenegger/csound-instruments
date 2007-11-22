  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

; TWO SYNTHETIC FM INSTRUMENTS

;************************
;FM-SITAR
;[CODED BY E.W.WILLIAMS]
;--------------------------
;f11 0 513 7  0 64 1 64 .4 384 .2
;f2 0 513 10 1
;f13 0 513 7  0 64 .8 128 1 320 .5
;f14 0 513 7  0 64 1 448 .5
;f15 0 513 7  0 16 1 128 .3 368 .8
;************************
instr          1
  icps      =  cpspch(p4)                         ; P4 = PCH
  ioct      =  octpch(p4)
  iamp      =  ampdb(p5)                          ; P5 = DB
  ilft      =  sqrt(p6)                           ; P6 = PANNER
  irght     =  sqrt(1-p6)
  iris      =  .02
  isnf      =  2
  ia3f      =  13                                 ; ENVLPX RISE FUNCTIONS...
  ia1f      =  11
  ia5f      =  15
  ia4f      =  14
  idur      =  (p3-.025)/4
    ;-------------------------  PARALLEL MOD/CAR
  kprt      linseg    0,.005,.2,.005,.07,.0025,.06,.0025,-.04,.005,-.02,.005,-.01,idur,.015,idur,.0035,idur,-.01,idur,0
  koct      =  kprt+ioct
  kcps      =  cpsoct(koct)
  kdtn1     =  cpsoct(koct*.04)
  kdtn2     =  cpsoct(koct*.07)
  k5        envlpx    iamp,iris,p3,p3*.25,ia5f,.9,.01
  a5        oscili    k5,kcps,isnf
  a6        oscili    .71*iamp,kcps*11,isnf
  acps4     =  a5+a6+kcps-kdtn2
  k4        envlpx    iamp,iris,p3,p3*.25,ia4f,.01,.01
  a4        oscili    k4,acps4,isnf
    ;-------------------------  STACKED MOD/CAR
  k3        envlpx    .75*iamp,iris,p3,p3*.25,ia3f,.9,.01
  a3        oscili    k3,kcps*1.15,isnf
  acps2     =  a3+kcps+kdtn1
  a2        oscili    1,acps2,isnf
  acps1     =  a2+kcps+kdtn1
  k1        envlpx    .75*iamp,iris,p3,p3*.25,ia1f,.01,.01
  a1        oscili    k1,acps1,isnf
    ;-------------------------  MIX/OUT
  asig      =  (a1+a4)/2
  galt      =  asig*ilft
  gart      =  asig*irght
            outs      galt,gart
endin
;************************
;MORRIL FM-TRUMPET
;[CODED BY E.W.WILLIAMS]
;---------------------------
;f02 0 513 10 1
;f12 0 513 8  0 128 .6 192 1 144 .4 32 .3 16 0
;f13 0 513 6  0 32 .9 32 1 456 .9
;****************************
instr          2
  idur      =  p3
  ioct      =  octpch(p4)
  iamp      =  ampdb(p5)
  ilft      =  sqrt(p6)
  irght     =  sqrt(1-p6)
  ivbfn     =  12
  iprtf     =  13
  isnf      =  2
  icar1     =  cpspch(p4)                         ; <========== OCT!!!!!!!
  icar2     =  int((1500/icar1)+.5)*icar1         ; KEEPS FORMANT PEAK AT 1500HZ
  imod      =  icar1
  imax      =  2.66                               ; IMAX = CA. 1 GIVE FLUTE SND.
  iratid    =  .6766917
  iatk3     =  .03
  iatk4     =  .03
  iatk5     =  .03
  idec3     =  .15
  idec4     =  .01
  idec5     =  .3
  irndev    =  .007
  ifrnd     =  125
  ivbw      =  .007
  ivbrt     =  4                                  ;   ORIGINALLY 7
  iprtdv    =  .03                 
    ;-----------------------------  VIBRATO
  k1        oscili    ivbw,1/idur,ivbfn
  k2        oscili    k1,ivbrt,isnf
  k2        =  k2+1
    ;-----  RAND VARI.
  k3        randi     irndev,ifrnd,-1
  k3        =  k3+1
    ;-----  PORTAMENTO
  k4        oscili    iprtdv,1/p3,iprtf
  k4        =  k4+1
    ;-----  COMBINE
  k5        =  k2*k3*k4
    ;----------------------------   PLAY
  k6        linseg    0,iatk4,1,iatk4,.6,(idur-iatk4-iatk4-idec4)/2,.8,(idur-iatk4-iatk4-idec4)/2,.5,idec4,0
  k6        =  k6*imax*imod
  a1        oscili    k6,imod*k5,isnf
  a2        =  (a1*iratid)+(icar2*k5)
  a3        =  a1+(icar1*k5)
    ;-------------  CARRIER1
  k7        linseg    0,iatk3,1,iatk3,.6,(idur-iatk3-iatk3-idec3)/2,.8,(idur-iatk3-iatk3-idec3)/2,.5,idec3,0
  k7        =  k7*iamp
  a4        oscili    k7,a3,isnf
    ;-------------  CARRIER2
  k8        linseg    0,iatk5,1,iatk5,.6,(idur-iatk5-iatk5-idec5)/2,.8,(idur-iatk5-iatk5-idec5)/2,.5,idec5,0
  k8        =  k8*iamp*.2
  a5        oscili    k8,a2,isnf
  asig      =  a4+a5
  galt      =  asig*ilft
  gart      =  asig*irght
            outs      galt,gart
endin

; TWO DISCRETE-SUMMATION-FORMULA INSTRUMENTS

;********************************
;DSF BRASS
;[CODED BY E.W.WILIAMS AFTER MOORER]
;IN BOTH DSF INSTRUMENTS, THE INDEX ENVELOPE
;EFFECTIVELY CONTROLS THE AMPLITUDE.  SEE MOORER'S
;ARTICLE IN CMJ FOR MORE INFO.
;-------------------------------
;f1  0   513 11  1
;f2  0   513 10  1
;   SAMPLE AMP ENVELOPES:
;f3 0 512 7  0 50 .4 100 .9 50 1 20 1 42 .85 50 .5 100 .2 100 0       ; SLOW RISE
;f4 0 513 7 0 64 1 32 1 32 .65 21 .75 85 .75 22 .65  171 .50  85 0    ; ADSR
;*********************************
instr 3
  icps      =  cpspch(p4)                         ; P4 = PCH
  iamp      =  ampdb(p5)                          ; P5 = DB
  iampf     =  p6                                 ; P6 = AMP ENV FN.
  ipan      =  p7                                 ; P7 = PANNER
  iamx      =  .78                                ; MAX INDEX IAMX<=.78
  icsf      =  1
  isnf      =  2
  kamp      oscili    iamp,1/p3,iampf             ; AMP ENV
  k1        oscili    iamx,1/p3,iampf             ; INDEX ENV
  ksq       =  k1*k1
  kmp       =  -2*k1
  k2        =  1+ksq
  a2        oscili    kmp,icps,icsf
  a3        =  a2+k2
  k3        =  sqrt((1-ksq)/(1+ksq))              ; AMP NORM. FUNC.
  a1        oscili    k3,icps,isnf
  a3        =  a1/a3
  asig      =  kamp*a3
  alt       =  asig*sqrt(ipan)
  art       =  asig*sqrt(1-ipan)
            outs      alt,art
endin
;************************************
;DISCRETE-SUMMATION-FORMULA INSTRUMENT
;WITH A REEDY TIMBRE
;[CODED BY E.W.WILLIAMS AFTER MOORER]
;-----------------------------------
;f1  0   513 11  1
;f2  0   513 10  1
;f3 0 512 7  0 50 .4 100 .9 50 1 20 1 42 .85 50 .5 100 .2 100 0       ; SLOW RISE
;************************************
instr          4                                            ; P4=PCH
  ifc       =  cpspch(p4)                         ; P5=DB 
  ifm       =  ifc*3                              ; P6=ENVELOPE
  iamp      =  ampdb(p5)*.27                      ; P7=MAX INDEX (P8 < .65)
  ipan      =  p8                                 ; P8=PANNER
  iamx      =  p7
  ienvf     =  p6
  k1        oscili    iamx,1/p3,ienvf
  ksq       =  k1*k1
  kmp       =  -2*k1
  k2        =  1+ksq
  a2        oscili    kmp,ifm,1
  a3        =  a2+k2
  k3        =  sqrt((1-ksq)/(1+ksq))              ; AMP NORM. FUNC.
  a1        oscili    k3,ifc,2
  a3        =  a1/a3
  k4        oscili    iamp,1/p3,ienvf
  asig      =  k4*a3
  alt       =  asig*sqrt(ipan)
  art       =  asig*sqrt(1-ipan)
            outs      alt,art
endin
;****************************
; WAVE-SHAPED, RING-MODULATED "WOOD-DRUM" 
;AFTER DODGE (COMPUTER MUSIC, P.145)
;[CODED BY E.W.WILLIAMS]
;-------------------------
;f02 0 513 10 1
;f12 0 513 7 0 13 .6 23 .9 25 1 17 .9 34 .5 64 .2 84 .1 84 .05 168 0  ; AMP ENV
;f13 0 513 3 -1 1 1 .841 -.707 -.595 .5 .42 -.354 -.297 .25 .210      ; SHAPER
;******************************
instr          5
  idur      =  p3                                 ; P4 = PCH
  iamp      =  ampdb(p5)                          ; P5 = DB
  icps      =  cpspch(p4)*2                       ; P6 = PANNER
  ilft      =  sqrt(p6)
  irght     =  sqrt(1-p6)
  isnf      =  2 
  iampf     =  12
  itblf     =  13
  k1        oscili    iamp,1/idur,iampf
  a1        oscili    k1,icps,isnf
  k2        linseg    255,.04,0,.16,0             ; DISTORTION ENV
  a2        oscili    k2,icps*.7071,isnf
  a3        =  a2+256
  a4        tablei    a3,itblf
  asig      =  a4*a1
  galt      =  asig*ilft
  gart      =  asig*irght
            outs      galt,gart
endin
;**********************************
;RISSET "ELECTRIC PIANO" (#301 FROM CATALOG...)
;[CODED BY E.W.WILLIAMS]
;SIMULATES AN OUT-OF-TUNE PIANO, MORE OR LESS.  NICE,
;ESPECIALLY IN LOWER REGISTER.
;--------------------------------------------------------
;f1 0 513 10 .158 .316 1 1 .282 .112 .063 .079 .126 .071         ; 10 HRM
;f2 0 513 10 1 .282 .089 .1 .071 .089 .05                        ; 7 HRM: SHORT/HIGH
;f3 0 513 7 1 190 .4 210 .2 112 0                                ; SHORT AMP ENV
;f4 0 513 5 1 512 .015625                                        ; LONG AMP ENV
;**********************************
instr          6
  icps      =  cpspch(p4)                         ; P4 = PCH
  iamp      =  ampdb(p5)/2.8                      ; P5 = DB
  ipan      =  p6                                 ; P6 = PANNING FAC
if (icps > 249 && p3 < .2)  goto highshort
if (icps > 249 && p3 > .19) goto highlong
if (icps < 250 && p3 > .19) goto lowlong
lowshort:
  ifn       =  1
  k1        oscili    iamp,1/p3,3
  icps1     =  cpsoct(octpch(p4)*1.001)
  icps2     =  cpsoct(octpch(p4)*.999)
            goto      play
highshort:
  ifn       =  2
  k1        oscili    iamp,1/p3,3
  icps1     =  cpsoct(octpch(p4)*1.0002)
  icps2     =  cpsoct(octpch(p4)*.9998)
            goto      play
lowlong:
  ifn       =  1
  k1        oscili    iamp,1/p3,4
  icps1     =  cpsoct(octpch(p4)*1.001)
  icps2     =  cpsoct(octpch(p4)*.999)
            goto      play
highlong:
  ifn       =  2
  k1        oscili    iamp,1/p3,4
  icps1     =  cpsoct(octpch(p4)*1.0002)
  icps2     =  cpsoct(octpch(p4)*.9998)
play:
  a1        oscili    k1,icps,1
  a2        oscili    k1,icps1,1
  a3        oscili    k1,icps2,1
  asig      =  a1+a2+a3
            outs      asig*sqrt(ipan),asig*sqrt(1-ipan)
endin




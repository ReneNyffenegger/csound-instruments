;Macchu Picchu orchestra
  sr        =  44100 
  kr        =  4410  
  ksmps     =  10 
  nchnls    =  2
;----------------------------------------------------------
;STEREO: always p6: 0=left, 1=right, neg.values= random 
;----------------------------------------------------------
; functions: 1 = sine
;        7 = panflute
;----------------------------------------------------------
  ga1       init      0
  ga2       init      0
  ga3       init      0
  ga4       init      0
  ga5       init      0
;----------------------------------------------------------
;         INSTRUMENT 1   FLOU
;----------------------------------------------------------
instr   1
  iatak     =  p6
  iatak     =  (p6 = 0. ? 1 : p6 )
  ifrq      =  cpspch(p5)
  iamp      =  ampdb(p4)
  kenv1     linseg    0,.89*iatak,.4,p3-.89*iatak,0
  kenv2     linseg    0,.83*iatak,.5,p3-.83*iatak,0
  kenv3     linseg    0,.80*iatak,.4,p3-.80*iatak,0
  kenv4     linseg    0,.95*iatak,.6,p3-.95*iatak,0
  kenv5     linseg    0,.90*iatak,.5,p3-.90*iatak,0
  kenv6     linseg    0,.70*iatak,.3,p3-.70*iatak,0
  kenv7     linseg    0,.65*iatak,.4,p3-.65*iatak,0
  krnd1     randi     .2,3,-1 
  krnd2     randi     .2,4,-1
  krnd3     randi     .2,2,-1
  krnd4     randi     .2,5,-1
  krnd5     randi     .2,6,-1
  krnd6     randi     .2,1,-1
  krnd7     randi     .2,2,-1
  a1        oscil     kenv1*krnd1,ifrq,1
  a2        oscil     kenv2*krnd2,ifrq*1.23,1
  a3        oscil     kenv3*krnd3,ifrq*1.17,1
  a4        oscil     kenv4*krnd4,ifrq*1.67,1
  a5        oscil     kenv5*krnd5,ifrq*2.11,1
  a6        oscil     kenv6*krnd6,ifrq*2.24,1
  a7        oscil     kenv7*krnd7,ifrq*2.36,1
  atot      =  (a1+a2+a3+a4+a5+a7+a7)*iamp
            outs      atot*(1-p7),atot*p7
endin
;----------------------------------------------------------
;         INSTRUMENT 2   BAND PASSED NOISE
;----------------------------------------------------------
instr     2
;p4       =         amplitude in dB
;p5       =         pitch (in octave-poit-pitch-class
;p6       =         stereo (if <0, then random position)
;p7       =         bandwidth (in cps)
;----------------------------------------------------------
  ifrq      =  cpspch(p5)                         ; OPPC TO CPS CONVERSION
  iamp      =  ampdb(p4)                          ; dB TO ABSOLUTE AMP CONVERSION
  itim      =  p3/3                               ;
;--------- STEREO --------------------------------------------
if        p6 >= 0 goto stereo                     ; STEREO POSITION ASSIGNED OR 
                                             ; RANDOM?
  kst       randh     .5,1/p3,-1                  ; RANDOM, SO CALCULATE kst
  kst       =  kst + .5                           ; AND RESCALE TO 0...1
            kgoto     donest
stereo:
  kst       =  p6                                 ; STEREO ASSIGNED, kst=p6
donest:
;----------- AMPLITUDE ENVELOPE
  k1        linseg    0,itim,iamp,itim,iamp,itim-.01,0.,.01,0
;----------- random (“white noise”) generation
  a1        rand      1,.4
;----------- BAND PASS FILTERING OF RANDOM: CENTER FREQUENCY = ifrq,
;bandwidth =        p4, rescaling =2
  aout      reson     a1*k1,ifrq,p7,2
  ga2       =  ga2+aout
            outs      aout*(1-kst)*2,aout*kst*2
endin
;----------------------------------------------------------
;         INSTRUMENT 4 BAND PASS FILTERED PULSE
;----------------------------------------------------------
instr   4
;p4       =         amplitude in dB
;p5       =         pitch (in octave-point-pitch-class
;p6       =         stereo (if <0, then random position)
;----------------------------------------------------------
  ifrq      =  cpspch(p5)                         ; OPPC TO CPS CONVERSION
  iamp      =  ampdb(p4)                          ; dB TO ABSOLUTE AMP CONVERSION
if        p6 >= 0 goto stereo                     ; STEREO ASSIGNMENT 
                                             ; (SEE INSTR 2)
  kst       randh     .5,1/p3,-1
  kst       =  kst + .5
            kgoto     donest
stereo:
  kst       =  p6
donest:
;--------- LET’S GENERATE A PULSE (NOT REALLY A PULSE, SINCE
                                             ; RISE TIME IT’S .01 SEC)
  a1        linseg    0,.01,p4,.001,0,p3-.003,0.,.01,0
;--------- BAND PASS FILTERING
  aout      reson     a1,ifrq,ifrq/12             ; BAND PASS FILTER, BANDWIDTH
                                             ; IS ALWAYS A 1/12d OF CENTRE
                                             ; FREQUENCY
  ga4       =  aout                               ; COPY aout TO ga4 
                                             ; (FOR REVERB)
            outs      aout*(1-kst),aout*kst
endin
;----------------------------------------------------------
;         INSTRUMENT 7 “PANFLUTE”
;----------------------------------------------------------
instr     7
;p4       =         amplitude in dB
;p5       =         pitch (in octave-poit-pitch-class
;----------------------------------------------------------
  ioct      =  octpch(p5)
  iamp      =  ampdb(p4)
  kenv1     linseg    0,.02,iamp,.02,iamp*.7,p3-.08,iamp*.3,.03,0,.01,0
  kenv2     linseg    0,.02,iamp*.2,p3-.02,0,.01,0
  kvibr     randi     .01,6,-1
  kfrq      =  cpsoct(ioct+kvibr)
  a1        oscili    kenv1,kfrq,7                ; GENERATE A TONE
                                             ; BASED ON Fn 7 (1st AND 2nd HARMONICS)
  a2        rand      kenv2
  a3        reson     a2,kfrq*2,kfrq/48,2         ;ADD A BIT OF RANDOM
                                             ;NOISE BAND-PASS FILTERED AT 2 TIMES THE PITCH
                                             ;OF OSCILLATOR, BANDWIDTH 1/48th OF CENTER
                                             ;FREQUENCY
  ga4       =  (a1+a3)/2
            outs      ga4*(1-p6)*2,ga4*p6*2
endin
;----------------------------------------------------------
;         INSTRUMENT 17  REVERB FOR PANFLUTE
;----------------------------------------------------------
instr     17
  a0        tone      ga4,sr/4
  a1        reverb    a0/2,3
            outs      a1,a1
endin
;----------------------------------------------------------
;         INSTRUMENT 10 REVERB RB
;----------------------------------------------------------
; p4      =         reverb time
instr     10
  gax       atone     ga1 + ga2 + ga3 + ga4 + ga5,20
  a1        comb      gax,p4,.011
  a2        comb      gax,p4,.02
  a3        comb      gax,p4,.037
  a4        comb      gax,p4,.051
  a5        =  (a1+a2+a3+a4)/4
  a6        alpass    a5,p4,.76
  a7        alpass    a6,p4,.37
  ax        =  (a2+a3+a1+a2+a3+a4)/6
            outs      ax,ax
  ga1       =  0
  ga2       =  0
  ga3       =  0
  ga4       =  0
  ga5       =  0
endin

;GSC8.ORC
;
;EFFECTIVE MULTIPLE AND TRULY INDEPENDENT VOICES CAN BE OBTAINED ADDING
;TRIPLETS OF CSOUND INSTRUMENTS.
;
;--------------   ORCHESTRA HEADER   ----------
;NOTE 0):FOR A BETTER QUALITY LET KSMPS = 1
;
  sr        =  44100
  kr        =  44100
  ksmps     =  1         
;----------    INIT GLOBAL VARIABLES ---------
  gkdur1    init      0                           ;GRAIN CENTER DURATION 
  gkrdd1    init      0                           ;GRAIN RANDOMIC DURATION RANGE
  gkprt1    init      0                           ;GRAIN RISE TIME
  gkamp1    init      0                           ;GLOBAL EVENT OVERALL AMPLITUDE
  gkrd1     init      0                           ;GRAIN RANDOMIC FREQUENCY RANGE
  gkfreq1   init      0                           ;GRAIN CENTER FREQUENCY
  gkdel1    init      0                           ;GRAIN CENTER DELAY
  gkph1     init      0                           ;FUNCTION TABLE INIT PHASE
  gkran1    init      0                           ;RANDOMIC FREQUENCY
  gkrnd1    init      0                           ;RANDOMIC DURATION 
;---------------------------------------------------------------------------
;                   
instr          1
;NOTE 1): 
;ONE INDEPENDENT VOICE ( 8 PSEUDO VOICES ) CONSISTS OF 3 INTRUMENTS WORKING
;IN PARALLEL MODE.( INSTR 1 ; INSTR 11; INSTR 21 )
;
;NOTE2: 
;EACH GRAIN IS INTENDED AS THE SUM OF TWO PARTS: A TRAPEZOID AND A DELAY.
;THE TRAPEZOID DURATION IS THE SUM OF A DETERMINISTIC (CENTER) VALUE PLUS (OR
;MINUS) A RANDOM TIME QUANTITY . THE RISE AND DECAY TIME ARE TWO
;EQUAL QUANTITIES THAT ARE A FRACTIONAL PART OF THIS SUM (SEE FIG. 1)
;
;
;         -------------
;             .                .
;           .            ._________________________    fig. 1
;
;        <--  idur + irdd --><--------- idel ---------->
;
;WARNING : P4,P5 AND P6 MUST BE EXPRESSED INTO THE SCORE FILE IN MSECS.!!!!!
;========
  idur      =  p4/1000                            ;INIT DETERMINISTIC TRAPEZOID DURATION IN SECS
  idel      =  p5/1000                            ;INIT TRAPEZOID DELAY IN SECS
  irdd      =  p6/1000                            ;INIT RANDOMIC DURATION IN SECS
  iprt      =  p7 + 0.1                           ;INIT RISE (DECAY) FACTOR ( PLUS A MAGIC.. )
  ird       =  p8                                 ;INIT RANDOM FREQUENCY DEVIATION
  ifreq     =  p9                                 ;INIT GRAIN CENTER FREQUENCY
  iph       =  p10                                ;INIT TABLE PHASE
  ifun      =  p11                                ;INIT AUDIO FUNCTION TABLE
;
;    FIRST INITIALIZATION
;       --------------------
  irise     =  (idur + irdd)/iprt                 ;    RISE TIME IS A FRACTION OF THE TRAPEZOID (FIG.1)
                                             ;     DURATION.  EXAMPLE : IDUR = 40 MSEC
                                             ;                    irdd = 5 msec
                                             ;                      iprt = 4
                                             ;                irise = (40 + 5 ) / 4 = 11.25 msec
                    
                              
  isus      =  (idur + irdd) -( 2 * irise )       ;COMPUTE SUSTAIN TRAPEZOID TIME 
     
  gigrain   =  idur + irdd + idel                 ;COMPUTE TOTAL GRAIN DURATION
     
            goto      start                       ;JUMP TO SWITCH ON TIMER ACTIVITY
;
;    REINITIALIZATION (ACTIVE WHEN TIMER REACHES ZERO)
;       -------------------------------------------------
loop:
  idur      =  i(gkdur1)                          ;THE ACTUAL IDUR VALUE IS "I-RATED" FROM THE FREE-
                                                            ;RUNNING FUNCTION GENERATOR THAT WORKS INSIDE AN
                                                            ;INDIPENDENT INSTRUMENT (INSTR 11 FOR INSTR 1) AND
  idur      =  idur/1000                          ;converted from msec into secs.
  irdd      =  i(gkrnd1)                          ;The same for irdd
  irdd      =  irdd/1000

  idel      =  i(gkdel1)                          ;THE SAME FOR IDEL
  idel      =  idel/1000

  iprt      =  i(gkprt1)+0.1                      ;THE SAME FOR IPRT
  ird       =  i(gkran1)                          ;THE SAME FOR IRD
  ifreq     =  i(gkfreq1)                         ;THE SAME FOR IFREQ
  iph       =  i(gkph1)                           ;THE SAME FOR IPH

  irise     =  (idur + irdd)/iprt       
  isus      =  idur + irdd - (2 * irise)     
  gigrain   =  idur + irdd + idel
          
               ;print    icount,gigrain,idur,irdd,idel      ;PRINT VALUES IF YOU WANT...

;---------- TIMER SECTION & INTERRUPT SIMULATION ----------
;
;THE TIMOUT STATEMENT WORKS AS AN INTERRUPT GENERATOR. THE TIMER IS LOADED
;WITH THE CURRENT GRAIN DURATION AND DECREMENTED UNTIL ZERO VALUE.
;
start:
            timout    0,gigrain,cont              ;If timer value is not zero
               ;goto     cont
            reinit    loop                        ;ELSE JUMP TO A REINIT SECTION
;
cont:
  k1        linseg    0,irise,1,isus,1,irise,0,idel,0 ;GENERATE LINEAR GRAIN 
                                                            ;envelope (scaled to 1 )
  k2        tablei    1023*k1,19                  ;SMOOTH ENVELOPE                          
  ga1       oscil     k2,ird + ifreq,ifun,iph     ;GENERATE SOUND
endin
;
;**********************************************************************
;**********************************************************************
;>>>>>>>>>>>>>>>>   CONTROL FUNCTION GENERATOR UNIT    <<<<<<<<<<<<
instr          11
;NOTE: ALL THE GLOBAL G-VARIABLES ARE TRANSMITTED TO THE INSTR 1!!
;
  gkdur1    oscil1    0,1,p3,p4                   ;CONTROL FUNCTION GENERATOR FOR IDUR
  gkdel1    oscil1    0,1,p3,p5                   ;                   idel
  gkrdd1    oscil1    0,1,p3,p6                   ;                   irdd 
  gkprt1    oscil1    0,1,p3,p7                   ;                   iprt
  gkrd1     oscil1    0,1,p3,p8                   ;                   ird
  gkfreq1   oscil1    0,1,p3,p9                   ;                   ifreq
  gkph1     oscil1    0,1,p3,p10                  ;                   iph
;
  gkamp1    oscil1    0,1,p3,p11                  ;                   iamp
;
  gkran1    rand      gkrd1/2                     ;FREQUENCY RANDOM GENERATOR   
  gkrnd1    rand      gkrdd1/2                    ;DURATION RANDOM GENERATOR
endin
;**********************************************************************
;**********************************************************************
;>>>>>>>>>>>>>>>>>     MIX / DELAY / RESCALE & OUT UNIT    <<<<<<<<<<<<

instr          21
  iscale    =  p4                                 ;READ AMPLITUDE SCALE FACTOR
  a1        =  ga1       
  a2        delay     a1, 0.003                   ;3ms delay --
  a3        delay     a1, 0.007                   ;7ms      |              
  a4        delay     a1, 0.011                   ;11ms        |
  a5        delay     a1, 0.015                   ;15ms         > ADJUST VALUES....
  a6        delay     a1, 0.017                   ;17ms        |
  a7        delay     a1, 0.023                   ;23ms        |
  a8        delay     a1, 0.025                   ;25ms      --
  as1       =  (a1+a2+a3+a4)/4                    ;PREMIX AND RESCALE FIRST FOUR PSEUDO VOICES
  as2       =  (a5+a6+a7+a8)/4                    ;PREMIX AND RESCALE LAST  FOUR PSEUDO VOICES
            out       ( as1+as2 ) * iscale * gkamp1 ;MIXDOWN, FINAL RESCALE ,OVERALL ADJUST
                                                            ;AND OUTPUT SOUND SAMPLES.
               ;out      a1 * iscale *  gkamp1                      
endin
;*************************************************************************
;*************************************************************************
;BEGIN OF SECOND INSTRUMENT TRIPLET
;
instr          2                                            ;ACTUAL SOUND GENERATOR USING VALUES FROM INSTR 12
;========
  idur      =  p4/1000                            ;INIT DETERMINISTIC TRAPEZOID DURATION IN SECS
  idel      =  p5/1000                            ;INIT TRAPEZOID DELAY IN SECS
  irdd      =  p6/1000                            ;INIT RANDOMIC DURATION IN SECS
  iprt      =  p7 + 0.1                           ;INIT RISE (DECAY) FACTOR ( PLUS A MAGIC.. )
  ird       =  p8                                 ;INIT RANDOM FREQUENCY DEVIATION
  ifreq     =  p9                                 ;INIT GRAIN CENTER FREQUENCY
  iph       =  p10                                ;INIT TABLE PHASE
  ifun      =  p11                                ;INIT AUDIO FUNCTION TABLE
  irise     =  (idur + irdd)/iprt                 ;    RISE TIME IS A FRACTION OF THE TRAPEZOID (FIG.1)
                                                            ;     DURATION.  EXAMPLE : IDUR = 40 MSEC
                                                            ;                    irdd = 5 msec
                                                            ;                      iprt = 4
                                                            ;                irise = (40 + 5 ) / 4 = 11.25 msec
  isus      =  (idur + irdd) -( 2 * irise )       ;COMPUTE SUSTAIN TRAPEZOID TIME 
  gigrain   =  idur + irdd + idel                 ;COMPUTE TOTAL GRAIN DURATION
            goto      start                       ;JUMP TO SWITCH ON TIMER ACTIVITY
loop:
  idur      =  i(gkdur1)                          ;THE ACTUAL IDUR VALUE IS "I-RATED" FROM THE FREE-
                                                            ;RUNNING FUNCTION GENERATOR THAT WORKS INSIDE AN
                                                            ;INDIPENDENT INSTRUMENT (INSTR 11 FOR INSTR 1) AND
  idur      =  idur/1000                          ;CONVERTED FROM MSEC INTO SECS.
  irdd      =  i(gkrnd1)                          ;THE SAME FOR IRDD
  irdd      =  irdd/1000
  idel      =  i(gkdel1)                          ;THE SAME FOR IDEL
  idel      =  idel/1000
  iprt      =  i(gkprt1)+0.1                      ;THE SAME FOR IPRT
  ird       =  i(gkran1)                          ;THE SAME FOR IRD
  ifreq     =  i(gkfreq1)                         ;THE SAME FOR IFREQ
  iph       =  i(gkph1)                           ;THE SAME FOR IPH
  irise     =  (idur + irdd)/iprt       
  isus      =  idur + irdd - (2 * irise)     
  gigrain   =  idur + irdd + idel
               ;print    icount,gigrain,idur,irdd,idel      ;PRINT VALUES IF YOU WANT...
;++++++++++++ TIMER SECTION
start:
            timout    0,gigrain,cont              ;IF TIMER VALUE IS NOT ZERO
               ;goto     cont
            reinit    loop                        ;ELSE JUMP TO A REINIT SECTION
cont:
  k1        linseg    0,irise,1,isus,1,irise,0,idel,0 ;GENERATE LINEAR GRAIN 
                                                            ;ENVELOPE (SCALED TO 1 )
  k2        tablei    1023*k1,19                  ;SMOOTH ENVELOPE                          
  ga1       oscil     k2,ird + ifreq,ifun,iph     ;GENERATE SOUND
endin

instr          12                                           ;CONTROL FUNCTION GENERATOR
  gkdur1    oscil1    0,1,p3,p4                   ;CONTROL FUNCTION GENERATOR FOR IDUR
  gkdel1    oscil1    0,1,p3,p5                   ;                   idel
  gkrdd1    oscil1    0,1,p3,p6                   ;                   irdd 
  gkprt1    oscil1    0,1,p3,p7                   ;                   iprt
  gkrd1     oscil1    0,1,p3,p8                   ;                   ird
  gkfreq1   oscil1    0,1,p3,p9                   ;                   ifreq
  gkph1     oscil1    0,1,p3,p10                  ;                   iph
  gkamp1    oscil1    0,1,p3,p11                  ;                   iamp
  gkran1    rand      gkrd1/2                     ;FREQUENCY RANDOM GENERATOR   
  gkrnd1    rand      gkrdd1/2                    ;DURATION RANDOM GENERATOR
endin

instr          22                                           ;MIX-DELAY-RESCALE-OUT
  iscale    =  p4                                 ;READ AMPLITUDE SCALE FACTOR
  a1        =  ga1       
  a2        delay     a1, 0.003                   ;3ms DELAY --
  a3        delay     a1, 0.007                   ;7ms      |              
  a4        delay     a1, 0.011                   ;11ms        |
  a5        delay     a1, 0.015                   ;15ms         > ADJUST VALUES....
  a6        delay     a1, 0.017                   ;17ms        |
  a7        delay     a1, 0.023                   ;23ms        |
  a8        delay     a1, 0.025                   ;25ms      --
  as1       =  (a1+a2+a3+a4)/4                    ;PREMIX AND RESCALE FIRST FOUR PSEUDO VOICES
  as2       =  (a5+a6+a7+a8)/4                    ;PREMIX AND RESCALE LAST  FOUR PSEUDO VOICES
            out       ( as1+as2 ) * iscale * gkamp1 ;MIXDOWN, FINAL RESCALE ,OVERALL ADJUST
                                                            ;AND OUTPUT SOUND SAMPLES.
               ;out      a1 * iscale *  gkamp1                      
endin

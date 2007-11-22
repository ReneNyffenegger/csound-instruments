
;INSTRUMENT 4 IS A REALIZATION OF A CHEBYSHEV 2ND ORDER BAND-REJECT FILTER. 
;THE AUDIO FILE IS A SAMPLE  TAKEN FROM "LATE LATE SHOW-MCGILL SWING BAND"
;LABEL: MCGILL RECORDS, 1990

;THE ORCHESTRA FOLLOWS:


  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 4

  idur      =  p3                                 ;DURATION OF THE SOUND FILE     
  icenter   =  p4                                 ;CENTER FREQUENCY
  ibandwth  =  p5                                 ;BANDWIDTH
  iscaling  =  p6                                 ;SCALING FOR THE OUTPUT

;CALCULATE THE INTERMEDIATE COEFFICIENT C USING TABLE 4
  ivar      =  sin(3.14159*ibandwth/sr)/cos(3.14159*ibandwth/sr)

;CALCULATE THE SCALING FACTOR D USING EQ. (14)
  iscale    =  2*cos(6.28318*icenter/sr)

;CALCULATE THE FILTER COEFFICIENTS USING THE SET OF EQUATIONS (19)
  ia0       =  1/(1+.50883*ivar)
  ia1       =  -iscale*ia0
  ia2       =  ia0
  ib1       =  -iscale*ia0
  ib2       =  (1-.50883*ivar)*ia0


;DO THE APPROPRIATE INITIALIZATIONS
  aout1     init      0
  aout2     init      0

  ainput    soundin   "late_show.aif"             ;THE INPUT SIGNAL 

;CREATE A 2ND ORDER DELAY
  adel1     delay1    ainput
  adel2     delay1    adel1

;CALCULATE THE OUTPUT SIGNAL
  aout      =  ia0*ainput+ia1*adel1+ia2*adel2-ib1*aout1-ib2*aout2

;APPLY RECURSION FORMULA : y(n-1) = y(n), y(n-2) = y(n-1), etc.
  aout2     =  aout1
  aout1     =  aout

;PROVIDE A SIMPLE EXPONENTIAL SEGMENT ENVELOPE TO THE SIGNAL BEFORE OUTPUT
  aenv      expseg    0.1,.1*idur,1,idur*.8,1,idur*.1,.1

            out       aout*aenv*iscaling          ;
endin

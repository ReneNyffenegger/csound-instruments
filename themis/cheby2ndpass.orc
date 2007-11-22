;INSTRUMENT 3 IS A REALIZATION OF A CHEBYSHEV 2ND ORDER BAND-PASS FILTER. 
;THE AUDIO FILE IS A SAMPLE  TAKEN FROM "LATE LATE SHOW-MCGILL SWING BAND"
;LABEL: MCGILL RECORDS, 1990

;THE ORCHESTRA FOLLOWS:

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 3

  idur      =  p3                                 ;DURATION OF THE SOUND FILE   
  icenter   =  p4                                 ;CENTER FREQUENCY
  ibandwth  =  p5                                 ;BANDWIDTH
  iscaling  =  p6                                 ;SCALING FOR THE OUTPUT

;CALCULATE THE INTERMEDIATE COEFFICIENT C USING TABLE 4
  ivar      =  cos(3.14159*ibandwth/sr)/sin(3.14159*ibandwth/sr)

;CALCULATE THE SCALING FACTOR D USING EQ. (14)
  iscale    =  2*cos(6.28318*icenter/sr)

;CALCULATE THE FILTER COEFFICIENTS USING THE SET OF EQUATIONS (16)
  ia0       =  1/(1+.50883*ivar)
  ia1       =  0
  ia2       =  -ia0
  ib1       =  -ivar*iscale*ia0/1.965267
  ib2       =  (ivar-1.965267)*ia0/1.965267



;DO THE APPROPRIATE INITIALIZATIONS
  aout1     init      0
  aout2     init      0

  ainput    soundin   "get_a_kick.aif"            ;THE INPUT SIGNAL 

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

            out       aout*aenv*iscaling          ;OUTPUT THE SIGNAL
endin

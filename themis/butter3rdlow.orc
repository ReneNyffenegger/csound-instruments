;INSTRUMENT 1 IS A REALIZATION OF A BUTTERWORTH 3RD ORDER LOW-PASS FILTER.
;THE AUDIO FILE IS A SAMPLE  TAKEN FROM "LATE LATE SHOW-MCGILL SWING BAND"
;LABEL: MCGILL RECORDS, 1990

;THE ORCHESTRA FOLLOWS:

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1

  idur      =  p3                                 ;DURATION OF THE SOUND FILE
  icut      =  p4                                 ;CUTOFF FREQUENCY
  iscale    =  p5                                 ;SCALING FACTOR FOR THE OUTPUT

;CALCULATE THE INTERMEDIATE COEFFICIENT C USING TABLE 4
  ivar      =  cos(3.14159*icut/sr)/sin(3.14159*icut/sr)    

;CALCULATE THE FILTER COEFFICIENTS USING THE DATA FROM TABLES 1,3
  ivarsqrd  pow       ivar,2                      ;IVAR SQUARED
  ivarcbd   pow       ivar,3                      ;IVAR CUBED

  ia0       =  1/(1+2*ivar+2*ivarsqrd+ivarcbd)
  ia1       =  3*ia0     
  ia2       =  3*ia0
  ia3       =  ia0

  ib1       =  (3+2*ivar-2*ivarsqrd-3*ivarcbd)*ia0
  ib2       =  (3-2*ivar-2*ivarsqrd+3*ivarcbd)*ia0
  ib3       =  (1-2*ivar+2*ivarsqrd-ivarcbd)*ia0


;DO THE APPROPRIATE INITIALIZATIONS
  aout1     init      0
  aout2     init      0
  aout3     init      0

  ainput    soundin   "allofme.aif"               ;the input signal

;CREATE A 3RD ORDER DELAY
  adel1     delay1    ainput
  adel2     delay1    adel1
  adel3     delay1    adel2

;CALCULATE THE OUTPUT SIGNAL
  aout      =  ia0*ainput+ia1*adel1+ia2*adel2+ia3*adel3-ib1*aout1-ib2*aout2-ib3*aout3

;APPLY RECURSION FORMULA : y(n-1) = y(n), y(n-2) = y(n-1), etc.
  aout3     =  aout2
  aout2     =  aout1
  aout1     =  aout

;PROVIDE A SIMPLE EXPONENTIAL SEGMENT ENVELOPE TO THE SIGNAL BEFORE OUTPUT
  aenv      expseg    0.1,.1*idur,1,idur*.8,1,idur*.1,.1

            out       aout*aenv*iscale            ;OUTPUT THE SIGNAL
endin





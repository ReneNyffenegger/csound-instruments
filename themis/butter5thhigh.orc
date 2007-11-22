
;INSTRUMENT 2 IS A REALIZATION OF A BUTTERWORTH 5TH ORDER HIGH-PASS FILTER.
;THE AUDIO FILE IS A SAMPLE  TAKEN FROM "LATE LATE SHOW-MCGILL SWING BAND"
;LABEL: MCGILL RECORDS, 1990

;THE ORCHESTRA FOLLOWS:

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1


instr 2

  idur      =  p3                                 ;DURATION OF THE SOUND FILE
  icut      =  p4                                 ;CUTOFF FREQUENCY
  iscale    =  p5                                 ;SCALING FOR THE OUTPUT

;CALCULATE THE INTERMEDIATE COEFFICIENT C FROM TABLE 4
  iv        =  sin(3.14159*icut/sr)/cos(3.14159*icut/sr)

;CALCULATE THE FILTER COEFFICIENTS USING THE DATA FROM TABLES 2, 3
  iv2       pow       iv,2                        ;iv squared
  iv3       pow       iv,3                        ;iv cubed
  iv4       pow       iv,4                        ;iv to the fourth
  iv5       pow       iv,5                        ;iv to the fifth

  ia0       =  1/(1+3.2360680*iv+5.2360680*iv2+5.2360680*iv3+3.2360680*iv4+ iv5)
  ia1       =  -5*ia0
  ia2       =  10*ia0
  ia3       =  -10*ia0
  ia4       =  5*ia0
  ia5       =  -ia0
  ib1       =  -(5+3*3.2360680*iv+5.2360680*iv2-5.2360680*iv3-3*3.2360680*iv4-5*iv5)*ia0
  ib2       =  (10+2*3.2360680*iv-2*5.2360680*iv2-2*5.2360680*iv3+2*3.2360680*iv4+10*iv5)*ia0
  ib3       =  -(10-2*3.2360680*iv-2*5.2360680*iv2+2*5.2360680*iv3+2*3.2360680*iv4-10*iv5)*ia0
  ib4       =  (5-3*3.2360680*iv+ 5.2360680*iv2+5.2360680*iv3- 3*3.2360680*iv4+5*iv5)*ia0
  ib5       =  -(1-3.2360680*iv+5.2360680*iv2-5.2360680*iv3+3.2360680*iv4- iv5)*ia0

;DO THE APPROPRIATE INITIALIZATIONS
  aout1     init      0
  aout2     init      0
  aout3     init      0
  aout4     init      0
  aout5     init      0

  ainput    soundin   "just_friends.aif"          ;THE INPUT SIGNAL

;CREATE A 5TH ORDER DELAY
  adel1     delay1    ainput
  adel2     delay1    adel1
  adel3     delay1    adel2
  adel4     delay1    adel3
  adel5     delay1    adel4

;CALCULATE THE OUTPUT SIGNAL
  aout      =  ia0*ainput+ia1*adel1+ia2*adel2+ia3*adel3+ia4*adel4+ia5*adel5-ib1*aout1-ib2*aout2-ib3*aout3-ib4*aout4-ib5*aout5

;APPLY RECURSION FORMULA :
  aout5     =  aout4
  aout4     =  aout3
  aout3     =  aout2
  aout2     =  aout1
  aout1     =  aout

;PROVIDE A SIMPLE EXPONENTIAL SEGMENT ENVELOPE TO THE SIGNAL BEFORE OUTPUT
  aenv      expseg    0.1,.1*idur,1,idur*.8,1,idur*.1,.1

            out       aout*aenv*iscale            ;OUTPUT THE SIGNAL
endin





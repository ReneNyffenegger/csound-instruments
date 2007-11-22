;=====================================================================
;=== DE-CORRELATION OF AUDIO SIGNALS IN A STEREOPHONIC ENVIRONMENT ===
;===                     LUCA PAVAN - 1999                         ===
;===             INPUT :  A MONO OR STEREO SOUNDFILE               ===
;===      OUTPUT:  A STEREO FILE WITH DE-CORRELATED CHANNELS       ===
;  http://www.patents.ibm.com/details?pn=US05235646__&language=en
;=====================================================================

;ORCHESTRA
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

instr     1
  idur      =  p3
  iamp      =  p4                                 ;AMPLITUDE [1 = ORIGINAL AMPLITUDE]
  ipan      =  p5                                 ;PANNING (0 = LEFT, .5 = CENTER, 1 = RIGHT)
  iatt      =  p6                                 ;ATTACK TIME
  idec      =  p7                                 ;DECAY TIME
  kdec      =  p8                                 ;DE-CORRELATION LEVEL (0-1) [1=MAXIMUM]

  kamp      linen     iamp, iatt, p3, idec
  ilev      =  .01                                ;FEEDBACK LEVEL
  id        =  0                                  ;NO DELAY
  icomp     =  1.3                                ;AMPLITUDE COMPENSATORY FACTOR

;==== CH1 ====
;asig1    soundin   "test.wav", 0       ;USE THIS LINE FOR MONO INPUT
;asig2    =         asig1               ;USE THIS LINE FOR MONO INPUT
  asig1, asig1a       soundin                     "allofmestereo.aif", 0 ;use this line for stereo input
  afil1     butterbp  asig1, 50, 60
  adel1     alpass    afil1, id, ilev
  afil2     butterbp  asig1, 200, 240
  afil3     butterbp  asig1, 800, 960
  adel3     alpass    afil3, id, ilev
  afil4     butterbp  asig1, 3200, 3840
  afil5     butterbp  asig1, 12800, 15360
  adel5     alpass    afil5, id, ilev
;==== CH2 ====
  asig2a,   asig2     soundin                     "allofmestereo.aif", 0 ;use this line for stereo input
  afil1a    butterbp  asig2, 50, 60
  afil2a    butterbp  asig2, 200, 240
  adel2a    alpass    afil2a, id, ilev
  afil3a    butterbp  asig2, 800, 960
  afil4a    butterbp  asig2, 3200, 3840
  adel4a    alpass    afil4a, id, ilev
  afil5a    butterbp  asig2, 12800, 15360
;===========================================
  aoutch1   =  adel1+afil2+adel3+afil4+adel5
  aoutch2   =  afil1a+adel2a+afil3a+adel4a+afil5a
  aoutch1m  =  (asig1 * (1 - kdec)) + (aoutch1 * kdec)
;aoutch2m =         (asig1 * (1 - kdec)) + (aoutch2 * kdec) ;USE THIS LINE FOR MONO INPUT
  aoutch2m  =  (asig2 * (1 - kdec)) + (aoutch2 * kdec) ;USE THIS LINE FOR STEREO
            outs      aoutch1m * sqrt(ipan) * kamp * icomp, aoutch2m * sqrt(1 - ipan) * kamp * icomp
endin

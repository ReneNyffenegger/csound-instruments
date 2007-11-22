            ;;  curtin
;-- leapfrog.orc --

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

  garvbsig  init      0                           ; MAKE ZERO AT ORCH INIT TIME
  gadelsig  init      0

; MAIN MIDRANGE INSTRUMENT
instr     1
  kaz       =  p6
  kel       =  0
  irvbgain  =  .5 * p4

  kenv      linseg    0, p3 / 2, p4 * .5, p3 / 2, 0 ; AMPLITUDE ENVELOPE
      
  asrc      soundin   "frogpeak.aif", p5
  aleft,aright hrtfer   asrc * kenv, kaz, kel, "hrtfcmpt.dat"
  garvbsig  =  garvbsig + asrc * irvbgain
            outs      aleft*250, aright*250
endin

; ENVELOPE FOLLOWING "BIRDS" INSTRUMENT
instr     2
  ipan      =  p4
  ipos1     =  p6
  ipos2     =  p7
  ipos3     =  3.0
  asrc      diskin    "frogpeak.aif", 0.1, ipos1
  asrc2     diskin    "frogpeak.aif", 0.1, ipos2
  aenv      follow    asrc, .008
  kenv      downsamp  aenv
  kpo       port      kenv, .01
  kpo       =  (kpo * 5.0) - 10000.0
  kpo       =  (kpo > 0 ? kpo :  0.0)
  aenv2     follow    asrc2,.001
  kenv2     downsamp  aenv2
  kpo2      port      kenv2, .05
  afreq     =  p5 + (kpo2 * 10.0)
  asig      oscili    kpo, afreq, 2               ; AUDIO OSCILLATOR
  gadelsig  =  gadelsig + asig * 0.25
            outs      asig*ipan, asig*(1.0-ipan)  ; send signal to channel 1
endin 
                                             
instr     3
  again     =  p4
  apan      =  p5
  awarp     =  p6
  aresamp   =  p7
  isampfun  =  3
  iwindfun  =  4
  ibeg      =  0
  iwindsize =  4096
  iwindrand =  10
  ioverlap  =  20
  asig,acmp sndwarp   1.0,awarp,aresamp,isampfun,ibeg,iwindsize,iwindrand,ioverlap,iwindfun,0
  abal      balance   asig, acmp                                        
            outs      abal * again * apan, abal * again * (1.0 - apan)
endin 
         
instr 98            ; GLOBAL MTAP DELAY
  afdbk     =  0
  afdbk2    =  0
  adel      delay     gadelsig + afdbk, 0.1
  adel2     delay     adel + afdbk2, 0.12
  adel3     delay     adel2, 0.14
  afdbk     =  adel3 * .75
  afdbk2    =  adel3 * .75
            outs      adel+adel2, adel+adel3
  gadelsig  =  0                                  ; THEN CLEAR IT
endin
            
instr 99            ; GLOBAL REVERB
  irvbtime  =  p4
  idel1     =  0.5
  idel2     =  0.75 
  idel3     =  0.45
  idel4     =  0.8 
  afb       =  0
  arev      reverb    garvbsig,  irvbtime         ; put global signal into reverb
; adump   delayr    1                        ; SET MAXIMUM DISTANCE 
  asig1     delay     garvbsig + afb + arev * .1, idel1 ; MULTITAPDELAY
  asig2     delay     garvbsig + afb + arev * .1, idel2 ; MULTITAPDELAY
  asig3     delay     garvbsig + afb + arev * .1, idel3 ; MULTITAPDELAY
  asig4     delay     garvbsig + afb + arev * .1, idel4 ; MULTITAPDELAY
  afb       =  ( asig1 + asig2 + asig3 + asig4 ) * .75
; delayw  garvbsig                           ; SEND TO DELAY LINE            
            outs      asig1+asig2*.25+asig3*.75, asig4+asig2*.75+asig3*.25 
; aleft1,aright1 hrtfer  asig1 + afb, 45.0, 10.0, "HRTFcmpt.dat"
; aleft2,aright2 hrtfer  asig2, 135.0, 10.0, "c:\sound\csound\HRTFcmpt.dat"
; aleft3,aright3 hrtfer  asig3, 225.0, 10.0, "c:\sound\csound\HRTFcmpt.dat"
; aleft4,aright4 hrtfer  asig4, 315.0, 10.0, "c:\sound\csound\HRTFcmpt.dat"
;         outs      aleft1 + aleft2 + aleft3 + aleft4, aright1 + aright2 + aright3 + aright4 
  garvbsig  =  0                                  ; THEN CLEAR IT
endin

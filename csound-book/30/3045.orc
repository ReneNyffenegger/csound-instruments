;---------------------------------------------------------------------------
; MIKELSON'S MULTI-FX SYSTEM
;---------------------------------------------------------------------------
; 3002. PLUCK
; 3013. TUBE AMP DISTORTION
; 3099. MIX
;---------------------------------------------------------------------------
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2
;---------------------------------------------------------------------------
            zakinit   30, 30
;---------------------------------------------------------------------------
; SOUND SOURCE
;---------------------------------------------------------------------------
; PLUCK PHYSICAL MODEL
;---------------------------------------------------------------------------
instr   3002
  iamp      =  p4                                 ; AMPLITUDE
  ifqc      =  cpspch(p5)                         ; CONVERT TO FREQUENCY
  itab1     =  p6                                 ; INITIAL TABLE
  imeth     =  p7                                 ; DECAY METHOD
  ioutch    =  p8                                 ; OUTPUT CHANNEL
  kamp      linseg    0, .002, iamp, p3-.004, iamp, .002, 0 ; DECLICK
  aplk      pluck     kamp, ifqc, ifqc, itab1, imeth ; PLUCK WAVEGUIDE MODEL
            zawm      aplk, ioutch                ; WRITE TO OUTPUT
  gifqc     =  ifqc
endin   
;---------------------------------------------------------------------------
; DISTORTION
;---------------------------------------------------------------------------
instr   3013
  igaini    =  p4                                 ; PRE GAIN
  igainf    =  p5                                 ; POST GAIN
  iduty     =  p6                                 ; DUTY CYCLE OFFSET
  islope    =  p7                                 ; SLOPE OFFSET
  izin      =  p8                                 ; INPUT CHANNEL
  izout     =  p9                                 ; OUTPUT CHANNEL
  asign     init      0                           ; DELAYED SIGNAL
  kamp      linseg    0, .002, 1, p3-.004, 1, .002, 0 ; DECLICK
  asig      zar       izin                        ; READ INPUT CHANNEL
  aold      =  asign                              ; SAVE THE LAST SIGNAL
  asign     =  igaini*asig/60000                  ; NORMALIZE THE SIGNAL
  aclip     tablei    asign,5,1,.5                ; READ THE WAVESHAPING TABLE
  aclip     =  igainf*aclip*15000                 ; RE-AMPLIFY THE SIGNAL
  atemp     delayr    .1                          ; AMPLITUDE AND SLOPE BASED DELAY
  aout      deltapi   (2-iduty*asign)/1500 + islope*(asign-aold)/300
            delayw    aclip
            zaw       aout, izout                 ; WRITE TO OUTPUT CHANNEL
endin
;---------------------------------------------------------------------------
; Delay
;---------------------------------------------------------------------------
instr   3040
  itim1     =  p4
  ifdbk1    =  p5
  ixfdbk1   =  p6
  itim2     =  p7
  ifdbk2    =  p8
  ixfdbk2   =  p9
  izinl     =  p10
  izinr     =  p11
  izoutl    =  p12
  izoutr    =  p13
  aoutl     init      0
  aoutr     init      0
  asigl     zar       izinl
  asigr     zar       izinr
  aoutl     delayr    itim1
            delayw    asigl+ifdbk1*aoutl+ixfdbk1*aoutr ; SUM DELAYED SIGNAL WITH
                                                    ; WITH ORIGINAL AND ADD 
  aoutr     delayr    itim2                       ; CROSS-FEEDBACK SIGNAL
            delayw    asigr+ifdbk2*aoutr+ixfdbk2*aoutl
            zaw       aoutl, izoutl
            zaw       aoutr, izoutr
endin
;---------------------------------------------------------------------------
; REVERB
;---------------------------------------------------------------------------
instr   3045
  irvtime   =  p4
  irvfqc    =  p5
  izin      =  p6
  izout     =  p7
  asig      zar       izin
  aout      nreverb   asig, irvtime, irvfqc
            zaw       aout/5, izout
endin
;---------------------------------------------------------------------------
; SUBMIX
;---------------------------------------------------------------------------
instr   3050
  izin1     =  p4
  igain1    =  p5
  izin2     =  p6
  igain2    =  p7
  izout     =  p8
  asig1     zar       izin1
  asig2     zar       izin2
            zaw       igain1*asig1+igain2*asig2, izout
endin
;---------------------------------------------------------------------------
; MIXER
;---------------------------------------------------------------------------
;    STA DUR  CH1  GAIN  PAN  CH2  GAIN  PAN  CH3  GAIN  PAN  CH4  GAIN  PAN
instr   3099        ; MIXER
  asig1     zar       p4
  igl1      init      p5*p6
  igr1      init      p5*(1-p6)
  asig2     zar       p7
  igl2      init      p8*p9
  igr2      init      p8*(1-p9)
  asig3     zar       p10
  igl3      init      p11*p12
  igr3      init      p11*(1-p12)
  asig4     zar       p13
  igl4      init      p14*p15
  igr4      init      p14*(1-p15)
  asigl     =  asig1*igl1 + asig2*igl2 + asig3*igl3 + asig4*igl4
  asigr     =  asig1*igr1 + asig2*igr2 + asig3*igr3 + asig4*igr4
            outs      asigl, asigr
            zacl      0, 30
endin

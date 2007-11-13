;---------------------------------------------------------------------------
; MIKELSON'S MULTI-FX SYSTEM
;---------------------------------------------------------------------------
; 3002. PLUCK
; 3013. TUBE AMP DISTORTION
; 3014. DISTORTION FEEDBACK
; 3099. MIX
;---------------------------------------------------------------------------
sr      =       44100
kr      =       4410
ksmps   =       10
nchnls  =       2
;---------------------------------------------------------------------------
        zakinit 30, 30
;---------------------------------------------------------------------------
; SOUND SOURCE
;---------------------------------------------------------------------------
; PLUCK PHYSICAL MODEL
;---------------------------------------------------------------------------
        instr   3002
iamp    =       p4                  ; AMPLITUDE
ifqc    =       cpspch(p5)          ; CONVERT TO FREQUENCY
itab1   =      p6                   ; INITIAL TABLE
imeth   =      p7                   ; DECAY METHOD
ioutch  =      p8                   ; OUTPUT CHANNEL
kamp    linseg 0, .002, iamp, p3-.004, iamp, .002, 0  ; DECLICK
aplk    pluck  kamp, ifqc, ifqc, itab1, imeth         ; PLUCK WAVEGUIDE MODEL
        zawm   aplk, ioutch                           ; WRITE TO OUTPUT
gifqc   =      ifqc
        endin
;---------------------------------------------------------------------------
; DISTORTION
;---------------------------------------------------------------------------
        instr   3013
igaini  =       p4                  ; PRE GAIN
igainf  =       p5                  ; POST GAIN
iduty   =       p6                  ; DUTY CYCLE OFFSET
islope  =       p7                  ; SLOPE OFFSET
izin    =       p8                  ; INPUT CHANNEL
izout   =       p9                  ; OUTPUT CHANNEL
asign   init    0                   ; DELAYED SIGNAL
kamp    linseg  0, .002, 1, p3-.004, 1, .002, 0   ; DECLICK
asig    zar     izin                ; READ INPUT CHANNEL
aold    =       asign               ; SAVE THE LAST SIGNAL
asign   =       igaini*asig/60000   ; NORMALIZE THE SIGNAL
aclip   tablei  asign,5,1,.5        ; READ THE WAVESHAPING TABLE
aclip   =       igainf*aclip*15000  ; RE-AMPLIFY THE SIGNAL
atemp   delayr  .1                  ; AMPLITUDE AND SLOPE BASED DELAY
aout    deltapi (2-iduty*asign)/1500 + islope*(asign-aold)/300
        delayw  aclip
        zaw     aout, izout         ; WRITE TO OUTPUT CHANNEL
        endin

;---------------------------------------------------------------------------
; DISTORTION FEEDBACK GENERATOR
;---------------------------------------------------------------------------
        instr   3014
igaini  =       p4                  ; PRE GAIN
igainf  =       p5                  ; POST GAIN
iduty   =       p6                  ; DUTY CYCLE SHIFT
itabd   =       p7                  ; DISTORTION TABLE
iresfqc =       p8                  ; RESONANCE FREQUENCY
ideltim =       p9                  ; FEEDBACK DELAY TIME
ifeedbk =       p10                 ; FEEDBACK GAIN
itabc   =       p11                 ; LIMITER TABLE
izin    =       p12                 ; INPUT CHANNEL
izout   =       p13                 ; OUTPUT CHANNEL
asign   init    0                   ; INITIALIZE LAST VALUE
kdclick linseg  0, .1, 1, p3-.3, 1, .2, 0       ; RAMP FEEDBACK IN AND OUT
kamp    linseg  0, .002, 1, p3-.004, 1, .002, 0 ; DECLICK
asig    zar     izin                ; READ INPUT CHANNEL
afdbk   =       asig/100            ; REDUCE ORIGINAL SIGNAL
adel1   delayr  ideltim             ; FEED BACK DELAY
afilt   butterbp adel1, iresfqc, iresfqc/4      ; FILTER THE DELAYED SIGNAL
kamprms rms     afilt               ; FIND RMS LEVEL
kampn   =       kamprms/30000       ; NORMALIZE RMS LEVEL 0-1.
kcomp   tablei  kampn,itabc,1,0     ; LOOK UP COMPRESSION VALUE IN TABLE
        delayw  afdbk+kcomp*ifeedbk*afilt       ; ADD LIMITED FEEDBACK
aold    =       asign               ; SAVE THE OLD VALUE
asign   =       (afilt*kdclick)/60000           ; NORMALIZE
aclip   tablei  asign,itabd,1,.5    ; WAVESHAPE WITH DISTORTION TABLE
aclip   =       igainf*aclip*15000  ; RESCALE
atemp   delayr  .1                  ; AMPLITUDE BASED DELAYS
aout    deltapi (2-iduty*asign)/1500 + iduty*(asign-aold)/300
        delayw  aclip
        zaw     aout, izout         ; WRITE TO THE OUTPUT CHANNELS
        endin
;---------------------------------------------------------------------------
; MIXER SECTION
;---------------------------------------------------------------------------
        instr   3099    
asig1   zar     p4                  ; p4 = ch1 IN
igl1    init    p5*p6               ; p5 = ch1 GAIN
igr1    init    p5*(1-p6)           ; p6 = ch1 PAN
asig2   zar     p7                  ; p7 = ch2 IN
igl2    init    p8*p9               ; p8 = ch2 GAIN
igr2    init    p8*(1-p9)           ; p9 = ch2 PAN
asig3   zar     p10                 ; p10 = ch3 IN
igl3    init    p11*p12             ; p11 = ch3 GAIN
igr3    init    p11*(1-p12)         ; p12 = ch3 PAN
asig4   zar     p13                 ; p13 = ch4 IN
igl4    init    p14*p15             ; p14 = ch4 GAIN
igr4    init    p14*(1-p15)         ; p15 = ch4 PAN
asigl   =       asig1*igl1+asig2*igl2+asig3*igl3+asig4*igl4 
asigr   =       asig1*igr1+asig2*igr2+asig3*igr3+asig4*igr4 
        outs    asigl, asigr    
        zacl    0, 30   
        endin

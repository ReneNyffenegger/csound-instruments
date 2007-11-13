;---------------------------------------------------------------------------
; MIKELSON'S MULTI-FX SYSTEM
;---------------------------------------------------------------------------
; 3002. PLUCK
; 3013. TUBE AMP DISTORTION
; 3030. FLANGER
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
iamp    =       p4                  ; Amplitude
ifqc    =       cpspch(p5)          ; Convert to frequency
itab1   =       p6                  ; Initial table
imeth   =       p7                  ; Decay method
ioutch  =       p8                  ; Output channel
kamp    linseg  0, .002, iamp, p3-.004, iamp, .002, 0  ; Declick
aplk    pluck   kamp, ifqc, ifqc, itab1, imeth         ; Pluck waveguide model
        zawm    aplk, ioutch                           ; Write to output
gifqc   =       ifqc
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
; FLANGER
;---------------------------------------------------------------------------
        instr   3030
irate   =       p4
idepth  =       p5/1000
iwave   =       p6
ifdbk   =       p7
imix    =       p8
ideloff =       p9/1000
iphase  =       p10
izin    =       p11
izout   =       p12
adel1   init    0
kamp    linseg  0, .002, 1, p3-.004, 1, .002, 0
asig    zar     izin
asig1   =       asig+ifdbk*adel1
aosc1   oscil   idepth, irate, iwave, iphase
aosc2   =       aosc1+ideloff
atemp   delayr  idepth+ideloff
adel1   deltapi aosc2
        delayw  asig1
aout    =       (imix*adel1+asig)/2
        zaw     aout, izout
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

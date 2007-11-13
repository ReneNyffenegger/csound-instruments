;---------------------------------------------------------------------------
; MIKELSON'S MULTI-FX SYSTEM
;---------------------------------------------------------------------------
; 3002. PLUCK
; 3019. RESONATOR
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
itab1   =       p6                  ; INITIAL TABLE
imeth   =       p7                  ; DECAY METHOD
ioutch  =       p8                  ; OUTPUT CHANNEL
kamp    linseg  0, .002, iamp, p3-.004, iamp, .002, 0  ; DECLICK
aplk    pluck   kamp, ifqc, ifqc, itab1, imeth         ; PLUCK WAVEGUIDE MODEL
        zawm    aplk, ioutch                           ; WRITE TO OUTPUT
gifqc   =       ifqc
        endin
;---------------------------------------------------------------------------
; RESONATOR
;---------------------------------------------------------------------------
        instr   3019
itabres =       p4                  ; RESONANCE TABLE
itabdb  =       p5                  ; AMPLITUDE TABLE
izin    =       p6                  ; INPUT CHANNEL
izout    =      p7                  ; OUTPUT CHANNEL
ires1   table   1, itabres          ; READ THE FOUR RESONANCE FREQUENCIES
ires2   table   2, itabres          ; FROM THE TABLE
ires3   table   3, itabres
ires4   table   4, itabres
idb1    table   1, itabdb           ; READ THE AMPLITUDES FROM THE TABLE
idb2    table   2, itabdb
idb3    table   3, itabdb
idb4    table   4, itabdb
iamp1   =       dbamp(idb1)/300     ; CONVERT dB TO AMPLITUDE
iamp2   =       dbamp(idb2)/300
iamp3   =       dbamp(idb3)/300
iamp4   =       dbamp(idb4)/300
asig    zar     izin                ; READ FROM INPUT CHANNEL
ares1   reson   asig, ires1, ires1/8  ; FILTER THE RESONANCES
ares2   reson   asig, ires2, ires2/8
ares3   reson   asig, ires3, ires3/8
ares4   reson   asig, ires4, ires4/8
abal1   balance ares1, asig         ; BALANCE THE RESONANCES
abal2   balance ares2, asig         ; SCALE EACH AND OUTPUT
abal3   balance ares3, asig
abal4   balance ares4, asig
        zaw     iamp1*abal1+iamp2*abal2+iamp3*abal3+iamp4*abal4, izout
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

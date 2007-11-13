sr     = 44100
kr     = 44100
ksmps  = 1
nchnls = 2
zakinit  50, 1
;----------------------------------------------------------------------------------
instr    01 ; Input Mono
ilevl    = p4 ; Output level
iout     = p5 ; Out
a1       soundin  p6
zaw      a1*ilevl, iout
endin
;----------------------------------------------------------------------------------
instr    02 ; Input Stereo
ilevl    = p4 ; Output level
iout1    = p5 ; Out 1
iout2    = p6 ; Out 2
a1, a2   soundin  p7
zaw      a1*ilevl, iout1
zaw      a2*ilevl, iout2
endin
;----------------------------------------------------------------------------------
instr    03 ; Phaser
ilevl    = p4     ; Output level
in1      = p5     ; In
iout     = p6     ; Out
ifreq    = p7     ; Initial frequency
idepth   = p8/2   ; LFO depth
irate    = p9     ; LFO rate
iphase   = p8/360 ; LFO phase in degrees
ifdbk    = p10    ; Feedback
inum     = p11    ; Number of stages
imix     = p12    ; Mix: 0=Input 1=Output
ain      zar  in1
klfo     oscili  idepth, irate, 2, iphase
klfo     = klfo + idepth
aphase   phaser1  ain, ifreq + klfo, inum, ifdbk
zawm     (ain*(1 - imix) + aphase*imix)*ilevl, iout
endin
;----------------------------------------------------------------------------------
instr    04 ; Ring Modulator with Sweep Osc
ilevl    = p4 ; Output level
in1      = p5 ; In
iout1    = p6 ; Out
ifreq1   = p7 ; Start frequency
ifreq2   = p8 ; End frequency
iwave    = p9 ; Waveform
ksweep   expseg  ifreq1, p3, ifreq2
ain      zar  in1
aosc     oscili  1, ksweep, iwave
zaw      ain*aosc*ilevl, iout1
endin
;----------------------------------------------------------------------------------
instr    05 ; S&H Driven Reson Filter
ilevl    = p4/200
in1      = p5
iout1    = p6
ifreq    = p7
idpth    = p8/2
irate    = p9
iseed    = rnd(1)
k1       randh  idpth, irate, iseed
k1       = k1 + idpth
ain      zar  in1
ares     reson  ain, ifreq + k1, (ifreq + k1)/16
zaw      ares*ilevl, iout1
endin
;----------------------------------------------------------------------------------
instr    06 ; Moog VCF with LFO
ilevl    = p4  ; Output level
in1      = p5  ; In
iout1    = p6  ; Out
ifreq    = p7  ; Freq
idepth   = p8  ; LFO depth
irate    = p9  ; LFO rate
iwave    = p10 ; LFO waveform
irez     = p11 ; Resonance
ain      zar  in1
alfo     oscili  idepth, irate, iwave
alfo     = alfo + idepth
avcf     moogvcf  ain, ifreq + alfo, irez, 32767
zaw      avcf*ilevl, iout1
endin
;----------------------------------------------------------------------------------
instr    07 ; Moog VCF with Envelope Follower.
ilevl    = p4 ; Output level
in1      = p5 ; In
iout1    = p6 ; Out
idepth   = p7 ; Sweep depth
irez     = p8 ; Resonance
ain      zar  in1
a2       follow  ain, .025
a3       butterlp  a2, 25
avcf     moogvcf  ain, (a3/8)*idepth, irez, 32767
zaw      avcf*ilevl, iout1
endin
;----------------------------------------------------------------------------------
instr    08 ; Flanger
ilevl    = p4      ; Output level
in1      = p5      ; In
iout     = p6      ; Out
idelay   = p7/1000 ; Delay in ms
idepth   = p8/2000 ; LFO depth in ms
irate    = p9      ; LFO rate
iwave    = p10     ; LFO waveform
ifdbk    = p11     ; Feedback
idry     = p12     ; Dry signal level
imax     = (idelay + idepth)*2
ain      zar  in1
alfo     oscili  idepth, irate, iwave
alfo     = alfo + idepth
aflng    flanger  ain, alfo + idelay, ifdbk, imax
aout     = (ain*idry + aflng)*ilevl
zaw      aout, iout
endin
;----------------------------------------------------------------------------------
instr    09 ; 'Reson' filter bank
ilevl    = p4/1000                        ; Output level
in1      = p5                             ; In
iout1    = p6                             ; Out
ipitch1  = (p07 < 20 ? cpspch(p07) : p07) ; Filter 1 freq
ipitch2  = (p08 < 20 ? cpspch(p08) : p08) ; Filter 2 freq
ipitch3  = (p09 < 20 ? cpspch(p09) : p09) ; Filter 3 freq
ipitch4  = (p10 < 20 ? cpspch(p10) : p10) ; Filter 4 freq
ipitch5  = (p11 < 20 ? cpspch(p11) : p11) ; Filter 5 freq
ipitch6  = (p12 < 20 ? cpspch(p12) : p12) ; Filter 6 freq
iband    = p13                            ; Filter bandwidth
ain      zar  in1
ares1    reson  ain, ipitch1, iband
ares2    reson  ain, ipitch2, iband
ares3    reson  ain, ipitch3, iband
ares4    reson  ain, ipitch4, iband
ares5    reson  ain, ipitch5, iband
ares6    reson  ain, ipitch6, iband
aout     sum  ares1, ares2, ares3, ares4, ares5, ares6
zaw      aout*ilevl, iout1    
endin
;-------------------------------------------------------------------------------
instr    10 ; Mixer
ilevl    = p4                             ; Output level
asig1    zar  p5                          ; Signal input 1
asig2    zar  p6                          ; Signal input 2
asig3    zar  p7                          ; Signal input 3
asig4    zar  p8                          ; Signal input 4
amix     sum  asig1, asig2, asig3, asig4  ; Mix input signals
zaw      amix*ilevl, p9                   ; Output
endin
;----------------------------------------------------------------------------------
instr    99 ; Stereo Output
ilevl    = p4
in1      = p5
in2      = p6
kdclick  linseg  0, .002, ilevl, p3-.004, ilevl, .002, 0
a1       zar  in1
a2       zar  in2
outs     a1*kdclick, a2*kdclick
zacl     1, 50
endin
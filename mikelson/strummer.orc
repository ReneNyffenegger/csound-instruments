; This instrument is designed for playing chords.
; Coded by Hans Mikelson 11/15/97

sr=44100
kr=22050
ksmps=2
nchnls=2

; Strummer Instrument
         instr  1

idur     =      p3
iamp     =      p4
iroot    =      p5
ichord   =      p6
iwave    =      p7
ireps    =      p8
ienv     =      p9
iphase   =      1-p10
itemper  =      p11
icarr    =      1
imodu    =      3

kamp1    oscil  1, ireps/idur, ienv
ichd1    table   0, ichord
ifqc1    cps2pch iroot+ichd1/100, 12
;                Amp    Fqc    Car    Mod    Index    Wave
asig1    foscil  kamp1, ifqc1, icarr, imodu, kamp1*4, iwave

kamp2    oscil   1, ireps/idur, ienv, iphase
ichd2    table   1, ichord
ifqc2    cps2pch iroot+ichd2/100, 12
asig2    foscil  kamp2, ifqc2, icarr, imodu, kamp2*4, iwave

kamp3    oscil   1, ireps/idur, ienv, iphase*2
ichd3    table   2, ichord
ifqc3    cps2pch iroot+ichd3/100, 12
asig3    foscil  kamp3, ifqc3, icarr, imodu, kamp3*4, iwave

kamp4    oscil   1, ireps/idur, ienv, iphase*3
ichd4    table   3, ichord
ifqc4    cps2pch iroot+ichd4/100, 12
asig4    foscil  kamp4, ifqc4, icarr, imodu, kamp4*4, iwave

aout     =       asig1+asig2+asig3+asig4
         outs    aout*iamp, aout*iamp

         endin

; Equal Temperament Test
         instr  2

idur     =      p3
iamp     =      p4
ipch     =      p5
iwave    =      p6
ienv     =      p7
itemper  =      p8
icarr    =      1
imodu    =      3

kamp1    oscil   1, 1/idur, ienv
ifqc1    cps2pch ipch, -6

;                Amp    Fqc    Car    Mod    Index    Wave
asig1    foscil  kamp1, ifqc1, icarr, imodu, kamp1*4, iwave

aout     =       asig1
         outs    aout*iamp, aout*iamp

         endin

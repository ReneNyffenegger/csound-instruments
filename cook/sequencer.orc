sr       = 44100
kr       = 4410
ksmps    = 10
nchnls   = 1

instr    1 ; Sequencer: 2*VCOs, 'Moog'VCF, VCA, Env.

ilevl    = p4*32767 ; Output level
itabl1   = p5       ; Pitch table
imult    = p6       ; Pitch multiplier
idet     = p7/2     ; VCO detune
ivcf     = p8       ; VCF cut-off frequency

k1       phasor  1/p3
k2       table  k1, itabl1, 1
kenv1    oscil  1, 8/p3, 3
kenv2    oscil  1, 8/p3, 5
kf       = kenv1*ivcf
avco1    oscil  .5, cpspch(k2)*imult - idet, 8, -1
avco2    oscil  .5, cpspch(k2)*imult + idet, 8, -1
avcos    = avco1 + avco2
avcf     moogvcf  avcos, kf, .1
out      avcf*ilevl*kenv2

endin
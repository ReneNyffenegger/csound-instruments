sr       = 44100
kr       = 4410
ksmps    = 10
nchnls   = 1

instr    1 ; Moog VCF With Envelope Follower.

ilevl    = p4 ; Output level
idepth   = p5 ; Sweep depth
irez     = p6 ; Resonance

ain      soundin  "sample1.wav"
a2       follow  ain, .025
a3       butterlp  a2, 25
avcf     moogvcf  ain, (a3/8)*idepth, irez, 32768

out      avcf*ilevl

endin
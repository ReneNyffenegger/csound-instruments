sr      = 44100
kr      = 4410
ksmps   = 10
nchnls  = 1
 
instr     1 ; S&H with 'Reson' Filter
 
ilevl     = p4/200 ; Output level
ifreq     = p5     ; Base freq
idpth     = p6/2   ; S&H depth
irate     = p7     ; S&H rate
iseed     = p8     ; Seed

k1        randh  idpth, irate, iseed
k1        = k1 + idpth
a1        soundin  "sample1.wav"
a2        reson  a1, ifreq + k1, (ifreq + k1)/16
out       a2*ilevl       

endin
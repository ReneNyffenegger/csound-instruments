sr       = 44100
kr       = 4410
ksmps    = 10
nchnls   = 1

instr    1 ; Crossfades between 2 inputs at audio or LFO rates

ilevl    = p4 ; Output level
irate    = p5 ; Rate
itabl    = p6 ; Waveshape

ain1     soundin  "sample1.wav"
ain2     soundin  "sample2.wav"

aosc     oscili  1, irate, itabl
aout     = ain1*aosc + ain2*(1 - aosc)
out      aout*ilevl

endin

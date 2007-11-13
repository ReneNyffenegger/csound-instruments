sr       = 44100
kr       = 4410
ksmps    = 10
nchnls   = 1

instr    1 ; 4-way vector mixer with LFOs

ilevl    = p4 ; Output level
irate1   = p5 ; X LFO rate
irate2   = p6 ; Y LFO rate

kdclick  linseg  0, .002, 1, p3 - .004, 1, .002, 0
alfo1    oscili  1, irate1, 1
alfo2    oscili  1, irate2, 1
ain1     diskin  "sample1.wav", 1, 0, 1
ain2     diskin  "sample2.wav", 1, 0, 1
ain3     diskin  "Sample3", 1, 0, 1
ain4     diskin  "sample4.wav", 1, 0, 1
aout1    = ain1*alfo1 + ain2*(1 - alfo1)
aout2    = ain3*alfo1 + ain4*(1 - alfo1)
aout     = aout1*alfo2 + aout2*(1 - alfo2)
out      aout*kdclick*ilevl

endin

sr     = 44100
kr     = 4410
ksmps  = 10
nchnls = 2

instr    1 ; AM / Ring Modulator

ilevl    = p4                          ; Level
ifreq1   = (p5 < 19 ? cpspch(p5) : p5) ; L start frequency in cpspch or Hz
ifreq2   = (p6 < 19 ? cpspch(p6) : p6) ; L end frequency in cpspch or Hz
ifreq3   = (p7 < 19 ? cpspch(p7) : p7) ; R start frequency in cpspch or Hz
ifreq4   = (p8 < 19 ? cpspch(p8) : p8) ; R end frequency in cpspch or Hz
idepth   = p9                          ; Depth (0=Off .5=AM 1=RingMod)
iwave    = p10                         ; Oscillator Waveform

ain      soundin  "sample1.wav"

ain      = ain*ilevl                   ; Input level
ksweep1  expon  ifreq1, p3, ifreq2     ; L frequency sweep
ksweep2  expon  ifreq3, p3, ifreq4     ; R frequency sweep
aosc1    oscili  1, ksweep1, iwave, -1 ; L oscillator
aosc2    oscili  1, ksweep2, iwave, -1 ; R oscillator
amod1    = aosc1*idepth + (1 - idepth) ; L calculate depth
amod2    = aosc2*idepth + (1 - idepth) ; R calculate depth
outs1    ain*amod1                     ; L modulate and output
outs2    ain*amod2                     ; R modulate and output

endin

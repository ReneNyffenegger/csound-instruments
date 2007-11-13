sr       = 44100
kr       = 44100
ksmps    = 1
nchnls   = 1

instr    1 ; Test Tone Generator

ilevl1   = ampdb(90 + p4) ; Level start (dB: 0dB=Peak)
ilevl2   = ampdb(90 + p5) ; Level end (dB: 0dB=Peak)
ifreq1   = p6             ; Frequency sweep start
ifreq2   = p7             ; Frequency sweep end
imode    = p8             ; Sweep mode: 0=Exp 1=Lin
iwave    = p9             ; Waveform

alevl    line  ilevl1, p3, ilevl2
aexp     expon  ifreq1, p3, ifreq2
alin     line   ifreq1, p3, ifreq2
asweep   = (imode > 0 ? alin : aexp)
aosc     oscil3  alevl, asweep, iwave
out      aosc

endin

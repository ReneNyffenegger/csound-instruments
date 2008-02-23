<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in    No messages
-odac           -iadc     -d     ;;;RT audio I/O
</CsOptions>
<CsInstruments>

sr=44100
ksmps=128
nchnls=2

;Example by Andres Cabrera 2007

FLmeter

Flrun

0dbfs = 1

instr 1
 kenv1 line 0, p3, 1
 kenv2 line 1, p3, 0
 aoutl oscils kenv1, 440, 0
 aoutr oscils kenv2, 440, 0
 outs aoutl, aoutr
endin

</CsInstruments>
<CsScore>
i 1 0 3
i 1 4 10
e

</CsScore>
</CsoundSynthesizer> 
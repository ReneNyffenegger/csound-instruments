<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in
-odac           -iadc    ;;;RT audio I/O
; For Non-realtime ouput leave only the line below:
; -o guiro.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

sr = 44100
kr = 4410
ksmps = 10
nchnls = 1

    instr 01  ;example of a guiro
a1  guiro p4, 0.01
    out a1
    endin


</CsInstruments>
<CsScore>

i1 0 1 20000
e


</CsScore>
</CsoundSynthesizer>

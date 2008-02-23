<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in    No messages
-odac           -iadc     -d     ;;;RT audio I/O
; For Non-realtime ouput leave only the line below:
; -o dripwater.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

sr = 44100
kr = 4410
ksmps = 10
nchnls = 1

instr 01  ;example of a water drip
a1  line 5, p3, 5  ;preset an amplitude boost
a2  dripwater p4, 0.01, 0, .9  ;dripwater needs a little amplitude help at these values
a3  product a1, a2 ;increase amplitude
    out a3
    endin


</CsInstruments>
<CsScore>

i1 0 1 20000
e


</CsScore>
</CsoundSynthesizer>

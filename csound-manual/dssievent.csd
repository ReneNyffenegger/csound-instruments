<CsoundSynthesizer>

<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in
-odac           -iadc     ;;;RT audio I/O
; For Non-realtime ouput leave only the line below:
; -o dssievent.wav -W ;;; for file output any platform
</CsOptions>

<CsInstruments>
ksmps = 256
nchnls = 2

;gihandle dssiinit "trivial_synth.so", 0, 1

;gihandle dssiinit "less_trivial_synth.so", 0, 1
gihandle dssiinit "hexter.so", 0, 1

instr 1
dssiactivate gihandle, 1
endin


instr 2

dssievent 1, gihandle, p4, 1, p5, p6
turnoff
endin

instr 3  ; main synth ouput
aout1 dssisynth gihandle
outs aout1 ,aout1
endin


</CsInstruments>

<CsScore>

i 1 0 1
i 3 1 30

i 2 2 1 6  60 100
i 2 3 1 7  60 100
i 2 4 1 6  62 100
i 2 5 1 7  62 100
i 2 6 1 6  63 100
i 2 7 1 7  63 100


e
</CsScore>

</CsoundSynthesizer>

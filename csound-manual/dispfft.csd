<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in
-odac           -iadc    ;;;RT audio I/O
; For Non-realtime ouput leave only the line below:
; -o dispfft.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

; Initialize the global variables.
sr = 44100
kr = 4410
ksmps = 10
nchnls = 1

; Instrument #1.
instr 1
  asig soundin "beats.wav"
  dispfft asig, 1, 512
  out asig
endin


</CsInstruments>
<CsScore>

; Play Instrument #1 for three seconds.
i 1 0 3
e


</CsScore>
</CsoundSynthesizer>

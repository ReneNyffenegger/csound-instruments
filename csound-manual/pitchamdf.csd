<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in    No messages
-odac           -iadc     -d     ;;;RT audio I/O
; For Non-realtime ouput leave only the line below:
; -o pitchamdf.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

; Initialize the global variables.
sr = 44100
kr = 4410
ksmps = 10
nchnls = 1

; synth waveform
giwave ftgen 2, 0, 1024, 10, 1, 1, 1, 1

; Instrument #1 - play an audio file with no effects.
instr 1
  ; get input signal with original freq.
  asig soundin "mary.wav"

  out asig
endin

; Instrument #2 - play the synth waveform using the
; same pitch and amplitude as the audio file.
instr 2
  ; get input signal with original freq.
  asig soundin "mary.wav"

  ; lowpass-filter
  asig tone asig, 1000
  ; extract pitch and envelope
  kcps, krms pitchamdf asig, 150, 500, 200
  ; "re-synthesize" with the synth waveform, giwave.
  asig1 oscil krms, kcps, giwave

  out asig1
endin


</CsInstruments>
<CsScore>

; Play Instrument #1, the audio file, for three seconds.
i 1 0 3
; Play Instrument #2, the "re-synthesized" waveform, for three seconds.
i 2 3 3
e


</CsScore>
</CsoundSynthesizer>

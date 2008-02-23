<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in    No messages
-odac           -iadc     -d     ;;;RT audio I/O
; For Non-realtime ouput leave only the line below:
; -o streson.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

; Initialize the global variables.
sr = 44100
kr = 4410
ksmps = 10
nchnls = 1

; Instrument #1.
instr 1
  ; Generate a normal sine wave.
  asig oscils 8000, 440, 1

  ; Vary the fundamental frequency of the string 
  ; resonator linearly from 220 to 880 Hertz. 
  kfr line 220, p3, 880
  ifdbgain = 0.95

  ; Run our sine wave through the string resonator.
  astres streson asig, kfr, ifdbgain

  ; The resonance can get quite loud.
  ; So we'll clip the signal at 30,000.
  a1 clip astres, 1, 30000
  out a1
endin


</CsInstruments>
<CsScore>

; Play Instrument #1 for five seconds.
i 1 0 5
e


</CsScore>
</CsoundSynthesizer>

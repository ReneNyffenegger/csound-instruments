<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in    No messages
-odac           -iadc     -d     ;;;RT audio I/O
; For Non-realtime ouput leave only the line below:
; -o lowresx.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

; Initialize the global variables.
sr = 44100
kr = 4410
ksmps = 10
nchnls = 1

; Instrument #1 - play the sawtooth waveform through a 
; stack of filters.
instr 1
  ; Use a nice sawtooth waveform.
  asig vco 5000, 440, 1

  ; Vary the cutoff frequency from 30 to 300 Hz.
  kcutoff line 30, p3, 300
  kresonance = 3
  inumlayer = 2

  alr lowresx asig, kcutoff, kresonance, inumlayer

  ; It gets loud, so clip the output amplitude to 30,000.
  a1 clip alr, 1, 30000
  out a1
endin


</CsInstruments>
<CsScore>

; Table #1, a sine wave for the vco opcode.
f 1 0 16384 10 1

; Play Instrument #1 for two seconds.
i 1 0 2
e


</CsScore>
</CsoundSynthesizer>

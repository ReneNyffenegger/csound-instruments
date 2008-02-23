<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in    No messages
-odac           -iadc     -d     ;;;RT audio I/O
; For Non-realtime ouput leave only the line below:
; -o bqrez.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

/* Written by Matt Gerassimof from example by Kevin Conder */
; Initialize the global variables.
sr = 44100
kr = 4410
ksmps = 10
nchnls = 1

; Instrument #1.
instr 1
  ; Use a nice sawtooth waveform.
  asig vco 16000, 220, 1

  ; Vary the filter-cutoff frequency from .2 to 2 KHz.
  kfco line 200, p3, 2000

  ; Set the resonance amount.
  kres init 0.99

  a1 bqrez asig, kfco, kres

  out a1
endin


</CsInstruments>
<CsScore>

/* Written by Matt Gerassimof from example by Kevin Conder */
; Table #1, a sine wave for the vco opcode.
f 1 0 16384 10 1

; Play Instrument #1 for three seconds.
i 1 0 3
e


</CsScore>
</CsoundSynthesizer>

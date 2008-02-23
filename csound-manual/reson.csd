<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in    No messages
-odac           -iadc     -d     ;;;RT audio I/O
; For Non-realtime ouput leave only the line below:
; -o reson.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

; Initialize the global variables.
sr = 44100
kr = 4410
ksmps = 10
nchnls = 1

; Instrument #1.
instr 1
  ; Generate a sine waveform.
  asine buzz 15000, 440, 3, 1

  ; Vary the cut-off frequency from 220 to 1280.
  kcf line 220, p3, 1320
  kbw init 20

  ; Run the sine through a resonant filter.
  ares reson asine, kcf, kbw

  ; Give the filtered signal the same amplitude 
  ; as the original signal. 
  a1 balance ares, asine
  out a1
endin


</CsInstruments>
<CsScore>

; Table #1, an ordinary sine wave.
f 1 0 16384 10 1

; Play Instrument #1 for 4 seconds.
i 1 0 4
e


</CsScore>
</CsoundSynthesizer>

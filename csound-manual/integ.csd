<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in    No messages
-odac           -iadc     -d     ;;;RT audio I/O
; For Non-realtime ouput leave only the line below:
; -o integ.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

; Initialize the global variables.
sr = 44100
kr = 4410
ksmps = 10
nchnls = 1

; Instrument #1 -- a differentiated signal.
instr 1
  ; Generate a band-limited pulse train.
  asrc buzz 20000, 440, 20,  1

  ; Differentiate the signal.
  adiff diff asrc

  out adiff
endin

; Instrument #2 -- a re-integrated signal.
instr 2
  ; Generate a band-limited pulse train.
  asrc buzz 20000, 440, 20,  1

  ; Differentiate the signal.
  adiff diff asrc

  ; Re-integrate the previously differentiated signal.
  a1 integ adiff

  out a1
endin


</CsInstruments>
<CsScore>

; Table #1, a sine wave.
f 1 0 16384 10 1

; Play Instrument #1 for one second.
i 1 0 1
; Play Instrument #2 for one second.
i 2 1 1
e


</CsScore>
</CsoundSynthesizer>

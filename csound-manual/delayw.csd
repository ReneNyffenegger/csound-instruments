<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in    No messages
-odac           -iadc     -d     ;;;RT audio I/O
; For Non-realtime ouput leave only the line below:
; -o delayw.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

; Initialize the global variables.
sr = 44100
kr = 4410
ksmps = 10
nchnls = 2

; Instrument #1 -- Delayed beeps.
instr 1
  ; Make a basic sound.
  abeep vco 20000, 440, 1

  ; Set up a delay line.
  idlt = 0.1
  adel delayr idlt

  ; Write the beep to the delay line.
  delayw abeep

  ; Send the beep to the left speaker and
  ; the delayed beep to the right speaker.
  outs abeep, adel
endin


</CsInstruments>
<CsScore>

; Table #1, a sine wave.
f 1 0 16384 10 1

; Keep the score running for 2 seconds.
f 0 2

; Play Instrument #1.
i 1 0.0 0.2
i 1 0.5 0.2
e


</CsScore>
</CsoundSynthesizer>

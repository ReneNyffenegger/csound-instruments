<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in    No messages
-odac           -iadc     -d     ;;;RT audio I/O
; For Non-realtime ouput leave only the line below:
; -o flanger.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

; Initialize the global variables.
sr = 44100
kr = 4410
ksmps = 10
nchnls = 1

; Instrument #1.
instr 1
  ; Use the "beat.wav" audio file.
  asig soundin "beats.wav"

  ; Vary the delay amount from 0 to 0.01 seconds.
  adel line 0, p3, 0.01
  kfeedback = 0.7

  ; Apply flange to the input signal.
  aflang flanger asig, adel, kfeedback

  ; It can get loud, so clip its amplitude to 30,000.
  a1 clip aflang, 1, 30000
  out a1
endin


</CsInstruments>
<CsScore>

; Play Instrument #1 for two seconds.
i 1 0 2
e


</CsScore>
</CsoundSynthesizer>

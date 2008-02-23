<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in    No messages
-odac           -iadc     -d     ;;;RT audio I/O
; For Non-realtime ouput leave only the line below:
; -o atone.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

; Initialize the global variables.
sr = 22050
kr = 2205
ksmps = 10
nchnls = 1

; Instrument #1 - an unfiltered noise waveform.
instr 1
  ; Generate a white noise signal.
  asig rand 20000

  out asig
endin


; Instrument #2 - a filtered noise waveform.
instr 2
  ; Generate a white noise signal.
  asig rand 20000

  ; Filter it using the atone opcode.
  khp init 2000
  afilt atone asig, khp

  ; Clip the filtered signal's amplitude to 85 dB.
  a1 clip afilt, 2, ampdb(85)
  out a1
endin


</CsInstruments>
<CsScore>

; Play Instrument #1 for two seconds.
i 1 0 2
; Play Instrument #2 for two seconds.
i 2 2 2
e


</CsScore>
</CsoundSynthesizer>

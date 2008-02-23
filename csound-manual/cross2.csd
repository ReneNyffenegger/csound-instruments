<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in    No messages
-odac           -iadc     -d     ;;;RT audio I/O
; For Non-realtime ouput leave only the line below:
; -o cross2.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

; Initialize the global variables.
sr = 44100
kr = 4410
ksmps = 10
nchnls = 1

; Instrument #1 - Play an audio file.
instr 1
  ; Use the "beats.wav" audio file.
  aout soundin "beats.wav"
  out aout
endin

; Instrument #2 - Cross-synthesize!
instr 2
  ; Use the "ahh" sound stored in Table #1.
  ain1 loscil 30000, 1, 1, 1
  ; Use the "beats.wav" audio file.
  ain2 soundin "beats.wav"

  isize = 4096
  ioverlap = 2
  iwin = 2
  kbias init 1

  aout cross2 ain1, ain2, isize, ioverlap, iwin, kbias

  out aout
endin


</CsInstruments>
<CsScore>

; Table #1: An audio file.
f 1 0 128 1 "ahh.aiff" 0 4 0
; Table #2: A windowing function.
f 2 0 2048 20 2

; Play Instrument #1 for 2 seconds.
i 1 0 2
; Play Instrument #2 for 2 seconds.
i 2 2 2
e


</CsScore>
</CsoundSynthesizer>

<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in    No messages
-odac           -iadc     -d     ;;;RT audio I/O
; For Non-realtime ouput leave only the line below:
; -o dam_expanded.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

; Initialize the global variables.
sr = 44100
kr = 4410
ksmps = 10
nchnls = 1

; Instrument #1, normal audio signal.
instr 1
  ; Use the "mary.wav" audio file.
  asig soundin "mary.wav"

  out asig
endin

; Instrument #2, expanded audio signal.
instr 2
  ; Use the "mary.wav" audio file.
  asig soundin "mary.wav"

  ; Expand the audio signal.
  kthreshold init 7500
  icomp1 = 2.25
  icomp2 = 2.25
  irtime = 0.1
  iftime = 0.6
  a1 dam asig, kthreshold, icomp1, icomp2, irtime, iftime

  out a1
endin


</CsInstruments>
<CsScore>

; Play Instrument #1.
i 1 0.0 3.5
; Play Instrument #2.
i 2 3.5 3.5
e


</CsScore>
</CsoundSynthesizer>

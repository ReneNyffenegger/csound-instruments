<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in    No messages
;-odac           -iadc     -d     ;;;RT audio I/O
; For Non-realtime ouput leave only the line below:
; -o dam.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

; Initialize the global variables.
sr = 44100
kr = 4410
ksmps = 10
nchnls = 1

; Instrument #1, uncompressed signal.
instr 1
  ; Use the "beats.wav" audio file.
  asig soundin "beats.wav"

  out asig
endin

; Instrument #2, compressed signal.
instr 2
  ; Use the "beats.wav" audio file.
  asig soundin "beats.wav"

  ; Compress the audio signal.
  kthreshold = 25000
  icomp1 = 0.5
  icomp2 = 0.763
  irtime = 0.1
  iftime = 0.1
  a1 dam asig, kthreshold, icomp1, icomp2, irtime, iftime

  out a1
endin

; Instrument #3, compressed signal.
instr 3
  ; Use the "beats.wav" audio file.
  asig soundin "beats.wav"

  ; Compress the audio signal.
  kthreshold line 25000, p3, 4410000
  icomp1 = 0.5
  icomp2 = 0.763
  irtime = 0.1
  iftime = 0.1
  a1 dam asig, kthreshold, icomp1, icomp2, irtime, iftime

  out a1
endin


</CsInstruments>
<CsScore>

; Play Instrument #1 for 2 seconds.
i 1 0 2
; Play Instrument #2 for 2 seconds.
i 2 2 2
; Play Instrument #3 for 2 seconds.
i 3 4 2
e


</CsScore>
</CsoundSynthesizer>

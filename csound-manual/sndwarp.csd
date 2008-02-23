<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in    No messages
-odac           -iadc     -d     ;;;RT audio I/O
; For Non-realtime ouput leave only the line below:
; -o sndwarp.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

; Initialize the global variables.
sr = 44100
kr = 4410
ksmps = 10
nchnls = 1

; Instrument #1 - play an audio file.
instr 1
  ; Use the audio file defined in Table #1.
  a1 loscil 30000, 1, 1, 1

  out a1
endin

; Instrument #2 - time-stretch an audio file.
instr 2
  kamp init 6500
  ; Start at 1 second and end at 3.5 seconds.
  ktimewarp line 1, p3, 3.5
  ; Playback at the normal speed.
  kresample init 1
  ; Use the audio file defined in Table #1.
  ifn1 = 1
  ibeg = 0
  iwsize = 4410
  irandw = 882
  ioverlap = 15
  ; Use Table #2 for the windowing function.
  ifn2 = 2
  ; Use the ktimewarp parameter as a "time" pointer.
  itimemode = 1

  a1 sndwarp kamp, ktimewarp, kresample, ifn1, ibeg, iwsize, irandw, ioverlap, ifn2, itimemode
  out a1
endin


</CsInstruments>
<CsScore>

; Table #1: an audio file.
f 1 0 262144 1 "mary.wav" 0 0 0
; Table #2: half of a sine wave.
f 2 0 16384 9 0.5 1 0

; Play Instrument #1 for 3.5 seconds.
i 1 0 3.5
; Play Instrument #2 for 7 seconds (time-stretched).
i 2 3.5 10.5
e


</CsScore>
</CsoundSynthesizer>

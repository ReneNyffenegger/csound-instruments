<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in
-odac           -iadc    ;;;RT audio I/O
; For Non-realtime ouput leave only the line below:
; -o randi.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

; Initialize the global variables.
sr = 44100
kr = 4410
ksmps = 10
nchnls = 1

; Instrument #1.
instr 1
  ; Choose a random frequency between 4,100 and 44,100.
  ; Generate new random numbers at 10 Hz.
  ; kamp = 40000
  ; kcps = 10
  ; iseed = 0.5
  ; isize = 0
  ; ioffset = 4100

  kcps randi 40000, 10, 0.5, 0, 4100

  a1 oscil 30000, kcps, 1
  out a1
endin


</CsInstruments>
<CsScore>

; Table #1, a sine wave.
f 1 0 16384 10 1

; Play Instrument #1 for one second.
i 1 0 1
e


</CsScore>
</CsoundSynthesizer>

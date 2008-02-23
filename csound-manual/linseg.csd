<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in    No messages
-odac           -iadc     -d     ;;;RT audio I/O
; For Non-realtime ouput leave only the line below:
; -o linseg.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

; Initialize the global variables.
sr = 44100
kr = 4410
ksmps = 10
nchnls = 1

; Instrument #1.
instr 1
  ; p4 = frequency in pitch-class notation.
  kcps = cpspch(p4)

  ; Create an amplitude envelope.
  kenv linseg 0, p3*0.25, 1, p3*0.75, 0
  kamp = kenv * 30000

  a1 oscil kamp, kcps, 1
  out a1
endin


instr 2
  ; p4 = frequency in pitch-class notation.
  kcps = cpspch(p4)

  ; Create an amplitude envelope.
  kenv linseg 0, 0.25, 1, 0.75, 0  ; kenv will go into negative if p3 > 1
  kamp = kenv * 30000

  a1 oscil kamp, kcps, 1
  out a1
endin

instr 3
  ; p4 = frequency in pitch-class notation.
  kcps = cpspch(p4)

  ; Create an amplitude envelope.
  kenv linseg 0, 0.25, 1, 0.75, 0, 1, 0  ; kenv will stay at 0 indefinetely at the end
  kamp = kenv * 30000

  a1 oscil kamp, kcps, 1
  out a1
endin
</CsInstruments>
<CsScore>

; Table #1, a sine wave.
f 1 0 16384 10 1

; Play Instrument #1 for a half-second, p4=8.00
i 1 0 0.5 8.00
; Play Instrument #1 for a half-second, p4=8.01
i 1 1 0.5 8.01
; Play Instrument #1 for a half-second, p4=8.02
i 1 2 0.5 8.02
; Play Instrument #1 for a half-second, p4=8.03
i 1 3 0.5 8.03

i 2 4  1.5 8.00 ; Notice the problem with linseg

i 3 6  1.5 8.00  ; this is the solution (instr 3)
e


</CsScore>
</CsoundSynthesizer>

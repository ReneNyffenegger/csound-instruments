<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in    No messages
-odac           -iadc     -d     ;;;RT audio I/O
; For Non-realtime ouput leave only the line below:
; -o adsr.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

; Initialize the global variables.
sr = 44100
kr = 4410
ksmps = 10
nchnls = 1

; Instrument #1 - a simple instrument.
instr 1
  ; Set the amplitude.
  kamp init 20000
  ; Get the frequency from the fourth p-field.
  kcps = cpspch(p4)

  a1 vco kamp, kcps, 1
  out a1
endin

; Instrument #2 - instrument with an ADSR envelope.
instr 2
  iatt = 0.05
  idec =  0.5
  islev = 0.08
  irel = 0.008

  ; Create an amplitude envelope.
  kenv adsr iatt, idec, islev, irel
  kamp = kenv * 20000

  ; Get the frequency from the fourth p-field.
  kcps = cpspch(p4)

  a1 vco kamp, kcps, 1
  out a1
endin


</CsInstruments>
<CsScore>

; Table #1, a sine wave.
f 1 0 16384 10 1

; Set the tempo to 120 beats per minute.
t 0 120

; Play a melody with Instrument #1.
; p4 = frequency in pitch-class notation.
i  1  0   1  8.04
i  1  1   1  8.04
i  1  2   1  8.05
i  1  3   1  8.07
i  1  4   1  8.07
i  1  5   1  8.05
i  1  6   1  8.04
i  1  7   1  8.02
i  1  8   1  8.00
i  1  9   1  8.00
i  1  10  1  8.02
i  1  11  1  8.04
i  1  12  2  8.04
i  1  14  2  8.02

; Repeat the melody with Instrument #2.
; p4 = frequency in pitch-class notation.
i  2  16  1  8.04
i  2  17  1  8.04
i  2  18  1  8.05
i  2  19  1  8.07
i  2  20  1  8.07
i  2  21  1  8.05
i  2  22  1  8.04
i  2  23  1  8.02
i  2  24  1  8.00
i  2  25  1  8.00
i  2  26  1  8.02
i  2  27  1  8.04
i  2  28  2  8.04
i  2  30  2  8.02
e


</CsScore>
</CsoundSynthesizer>

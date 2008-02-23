<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in    No messages
-odac           -iadc     -d     ;;;RT audio I/O
; For Non-realtime ouput leave only the line below:
; -o 0dbfs.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

; Initialize the global variables.
sr = 44100
kr = 4410
ksmps = 10
nchnls = 1

; Set the 0dbfs to the 16-bit maximum.
0dbfs = 32767

; Instrument #1.
instr 1
  ; Linearly increase the amplitude value "kamp" from 
  ; 0 to 1 over the duration defined by p3.
  kamp line 0, p3, 1

  ; Generate a basic tone using our amplitude value.
  a1 oscil kamp, 440, 1

  ; Multiply the basic tone (with its amplitude between 
  ; 0 and 1) by the full-scale 0dbfs value.
  out a1 * 0dbfs
endin


</CsInstruments>
<CsScore>

; Table #1, a sine wave.
f 1 0 16384 10 1

; Play Instrument #1 for three seconds.
i 1 0 3
e


</CsScore>
</CsoundSynthesizer>

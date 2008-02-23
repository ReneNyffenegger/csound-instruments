<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in
-odac           -iadc    ;;;RT audio I/O
; For Non-realtime ouput leave only the line below:
; -o randh.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

; Initialize the global variables.
sr = 44100
kr = 4410
ksmps = 10
nchnls = 1

; Instrument #1.
instr 1
  ; Choose a random frequency between 200 and 1000.
  ; Generate new random numbers at 4 Hz.
  ; kamp = 400
  ; kcps = 4
  ; iseed = 0.5
  ; isize = 0
  ; ioffset = 600

  kcps randh 400, 4, 0.5, 0, 600
  printk2 kcps

  a1 oscil 30000, kcps, 1
  out a1
endin


</CsInstruments>
<CsScore>

; Table #1, a sine wave.
f 1 0 16384 10 1

; Play Instrument #1 for one second.
i 1 0 5
e


</CsScore>
</CsoundSynthesizer>

<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in    No messages
-odac           -iadc     -d     ;;;RT audio I/O
; For Non-realtime ouput leave only the line below:
; -o mandol.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

; Initialize the global variables.
sr = 22050
kr = 2205
ksmps = 10
nchnls = 1

; Instrument #1.
instr 1
  ; kamp = 30000
  ; kfreq = 880
  ; kpluck = 0.4
  ; kdetune = 0.99
  ; kgain = 0.99
  ; ksize = 2
  ; ifn = 1
  ; ifreq = 220

  a1 mandol 30000, 880, 0.4, 0.99, 0.99, 2, 1, 220

  out a1
endin


</CsInstruments>
<CsScore>

; Table #1: the "mandpluk.aiff" audio file
f 1 0 8192 1 "mandpluk.aiff" 0 0 0

; Play Instrument #1 for one second.
i 1 0 1
e


</CsScore>
</CsoundSynthesizer>

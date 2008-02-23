<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in    No messages
-odac           -iadc     -d     ;;;RT audio I/O
; For Non-realtime ouput leave only the line below:
; -o tambourine.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

sr = 22050
kr = 2205
ksmps = 10
nchnls = 1

; Instrument #1: An example of a tambourine.
instr 01
  a1 tambourine 15000, 0.01

  out a1
endin


</CsInstruments>
<CsScore>

i 1 0 1
e


</CsScore>
</CsoundSynthesizer>

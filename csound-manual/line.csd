<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in    No messages
-odac           -iadc     -d     ;;;RT audio I/O
; For Non-realtime ouput leave only the line below:
; -o line.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

; Initialize the global variables.
sr = 44100
kr = 4410
ksmps = 10
nchnls = 1

; Instrument #1.
instr 1
  ; Define kcps as a frequency value that linearly declines 
  ; from 880 to 220. It declines over the period set by p3.
  kcps line 880, p3, 220

  a1 oscil 20000, kcps, 1
  out a1
endin

instr 2
  kcps line 880, 1, 660   ; kcps won't stop at 660 if p3 > 1
  a1 oscil 20000, kcps, 1
  out a1
endin

instr 3
  kcps line 880, 1, 660, 1, 660   ; kcps will stay at 660 after 1 sec.
  a1 oscil 20000, kcps, 1
  out a1
endin

</CsInstruments>
<CsScore>

; Table #1, a sine wave.
f 1 0 16384 10 1

; Play Instrument #1 for two seconds.
i 1 0 2

i 2 3 2

i 3 6 2
e


</CsScore>
</CsoundSynthesizer>

<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in    No messages
-odac           -iadc     -d     ;;;RT audio I/O
; For Non-realtime ouput leave only the line below:
; -o wgbowedbar.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

; Initialize the global variables.
sr = 44100
kr = 4410
ksmps = 10
nchnls = 1

  instr 1
; pos      =         [0, 1]
; bowpress =         [1, 10]
; gain     =         [0.8, 1]
; intr     =         [0,1]
; trackvel =         [0, 1]
; bowpos   =         [0, 1]

  kb      line 0.5, p3, 0.1
  kp      line 0.6, p3, 0.7
  kc      line 1, p3, 1

  a1      wgbowedbar p4, cpspch(p5), kb, kp, 0.995, p6, 0

          out a1
          endin


</CsInstruments>
<CsScore>

  i1      0  3 32000 7.00 0
  e


</CsScore>
</CsoundSynthesizer>

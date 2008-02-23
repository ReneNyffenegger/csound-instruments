<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in
-odac           -iadc    ;;;RT audio I/O
; For Non-realtime ouput leave only the line below:
; -o trigger.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

; Initialize the global variables.
sr = 44100
kr = 4410
ksmps = 10
nchnls = 1

; Instrument #1.
instr 1
  ; Use a square-wave low frequency oscillator as the trigger.
  klf lfo 1, 10, 3
  ktr trigger klf, 1, 2

  ; When the value of the trigger isn't equal to 0, print it out.
  if (ktr == 0) kgoto contin
    ; Print the value of the trigger and the time it occurred.
    ktm times
    printks "time = %f seconds, trigger = %f\\n", 0, ktm, ktr

contin:
  ; Continue with processing.
endin


</CsInstruments>
<CsScore>

; Play Instrument #1 for one second.
i 1 0 1
e


</CsScore>
</CsoundSynthesizer>

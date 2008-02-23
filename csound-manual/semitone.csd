<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in
-odac           -iadc    ;;;RT audio I/O
; For Non-realtime ouput leave only the line below:
; -o semitone.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

; Initialize the global variables.
sr = 44100
kr = 4410
ksmps = 10
nchnls = 1

; Instrument #1.
instr 1
  ; The root note is A above middle-C (440 Hz)
  iroot = 440

  ; Raise the root note by three semitones to C.
  isemitone = 3

  ; Calculate the new note.
  ifactor = semitone(isemitone)
  inew = iroot * ifactor

  ; Print out all of the values.
  print iroot
  print ifactor
  print inew
endin


</CsInstruments>
<CsScore>

; Play Instrument #1 for one second.
i 1 0 1
e


</CsScore>
</CsoundSynthesizer>

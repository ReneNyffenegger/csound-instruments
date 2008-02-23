<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in    No messages
-odac           -iadc     -d     ;;;RT audio I/O
; For Non-realtime ouput leave only the line below:
; -o harmon.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

; Initialize the global variables.
sr = 44100
kr = 4410
ksmps = 10
nchnls = 1

; Instrument #1.
instr 1
  ; The frequency of the base note.
  inote = 440

  ; Generate the base note.
  avco vco 20000, inote, 1

  kestfrq = inote
  kmaxvar = 0.4
  
  ; Calculate frequencies 3 semitones above and
  ; below the base note.
  kgenfreq1 = inote * semitone(3)
  kgenfreq2 = inote * semitone(-3)

  imode = 1
  iminfrq = inote - 200
  iprd = 0.1
  
  ; Generate the harmony notes.
  a1 harmon avco, kestfrq, kmaxvar, kgenfreq1, kgenfreq2, \
            imode, iminfrq, iprd

  out a1
endin


</CsInstruments>
<CsScore>

; Table #1, a sine wave.
f 1 0 16384 10 1

; Play Instrument #1 for two seconds.
i 1 0 2
e


</CsScore>
</CsoundSynthesizer>

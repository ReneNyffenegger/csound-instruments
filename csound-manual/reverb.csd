<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in    No messages
-odac           -iadc     -d     ;;;RT audio I/O
; For Non-realtime ouput leave only the line below:
; -o reverb.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

; Initialize the global variables.
sr = 44100
kr = 4410
ksmps = 10
nchnls = 1

; init an audio receiver/mixer
ga1 init 0 

; Instrument #1. (there may be many copies)
instr 1 
  ; generate a source signal
  a1 oscili 7000, cpspch(p4), 1 
  ; output the direct sound
  out a1  
  ; and add to audio receiver
  ga1 = ga1 + a1 
endin

; (highest instr number executed last)
instr 99 
  ; reverberate whatever is in ga1
  a3 reverb ga1, 1.5
  ; and output the result
  out a3 
  ; empty the receiver for the next pass
  ga1 = 0 
endin


</CsInstruments>
<CsScore>

; Table #1, a sine wave.
f 1 0 128 10 1

; p4 = frequency (in a pitch-class)
; Play Instrument #1 for a tenth of a second, p4=6.00
i 1 0 0.1 6.00
; Play Instrument #1 for a tenth of a second, p4=6.02
i 1 1 0.1 6.02
; Play Instrument #1 for a tenth of a second, p4=6.04
i 1 2 0.1 6.04
; Play Instrument #1 for a tenth of a second, p4=6.06
i 1 3 0.1 6.06

; Make sure the reverb remains active.
i 99 0 6
e


</CsScore>
</CsoundSynthesizer>

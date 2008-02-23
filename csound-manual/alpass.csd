<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in    No messages
-odac           -iadc     -d     ;;;RT audio I/O
; For Non-realtime ouput leave only the line below:
; -o alpass.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

; Initialize the global variables.
sr = 44100
kr = 4410
ksmps = 10
nchnls = 1

; Initialize the audio mixer.
gamix init 0 

; Instrument #1.
instr 1 
  ; Generate a source signal.
  a1 oscili 30000, cpspch(p4), 1
  ; Output the direct sound.
  out a1  

  ; Add the source signal to the audio mixer.
  gamix = gamix + a1 
endin

; Instrument #99 (highest instr number executed last)
instr 99 
  krvt = 1.5
  ilpt = 0.1

  ; Filter the mixed signal.
  a99 alpass gamix, krvt, ilpt
  ; Output the result.
  out a99 

  ; Empty the mixer for the next pass.
  gamix = 0 
endin


</CsInstruments>
<CsScore>

; Table #1, a sine wave.
f 1 0 128 10 1

; p4 = frequency (in a pitch-class)
; Play Instrument #1 for a tenth of a second, p4=7.00
i 1 0 0.1 7.00
; Play Instrument #1 for a tenth of a second, p4=7.02
i 1 1 0.1 7.02
; Play Instrument #1 for a tenth of a second, p4=7.04
i 1 2 0.1 7.04
; Play Instrument #1 for a tenth of a second, p4=7.06
i 1 3 0.1 7.06

; Make sure the filter remains active.
i 99 0 5
e


</CsScore>
</CsoundSynthesizer>

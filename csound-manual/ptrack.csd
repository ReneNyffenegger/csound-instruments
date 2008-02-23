<CsoundSynthesizer>

<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in    No display
-odac           -iadc     -d     ;;;RT audio I/O
</CsOptions>

<CsInstruments>
sr= 44100
ksmps = 16
nchnls= 1

;Example by Victor Lazzarini 2007

instr 1
  a1 inch 1              ; take an input signal
  kf,ka ptrack a1, 512   ; pitch track with winsize=1024
  kcps port kf, 0.01     ; smooth freq
  kamp port ka, 0.01     ; smooth amp

  ; drive an oscillator
  aout oscili ampdb(kamp)*0dbfs, kcps, 1

  out  aout
endin

</CsInstruments>

<CsScore>
i1 0 3600
e
</CsScore>

</CsoundSynthesizer>

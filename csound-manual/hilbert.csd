<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in    No messages
-odac           -iadc     -d     ;;;RT audio I/O
; For Non-realtime ouput leave only the line below:
; -o hilbert.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

sr = 44100
kr = 4410
ksmps = 10
nchnls = 1
  
instr 1
  idur = p3
  ; Initial amount of frequency shift.
  ; It can be positive or negative.
  ibegshift = p4 
  ; Final amount of frequency shift.
  ; It can be positive or negative.
  iendshift = p5 
  
  ; A simple envelope for determining the 
  ; amount of frequency shift.
  kfreq linseg ibegshift, idur, iendshift
 
  ; Use the sound of your choice.
  ain soundin "mary.wav"
 
  ; Phase quadrature output derived from input signal.
  areal, aimag hilbert ain
 
  ; Quadrature oscillator.
  asin oscili 1, kfreq, 1
  acos oscili 1, kfreq, 1, .25
 
  ; Use a trigonometric identity. 
  ; See the references for further details.
  amod1 = areal * acos
  amod2 = aimag * asin

  ; Both sum and difference frequencies can be 
  ; output at once.
  ; aupshift corresponds to the sum frequencies.
  aupshift = (amod1 + amod2) * 0.7
  ; adownshift corresponds to the difference frequencies. 
  adownshift = (amod1 - amod2) * 0.7

  ; Notice that the adding of the two together is
  ; identical to the output of ring modulation.

  out aupshift
endin


</CsInstruments>
<CsScore>

; Sine table for quadrature oscillator.
f 1 0 16384 10 1

; Starting with no shift, ending with all
; frequencies shifted up by 200 Hz.
i 1 0 2 0 200

; Starting with no shift, ending with all
; frequencies shifted down by 200 Hz.
i 1 2 2 0 -200
e


</CsScore>
</CsoundSynthesizer>

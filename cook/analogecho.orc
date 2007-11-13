sr       = 44100
kr       = 44100
ksmps    = 1
nchnls   = 1

instr    1 ; MN3011 BBD Reverb

ilevl    = p4                       ; Output level
idelay   = p5/4                     ; Delay factor
ifdbk    = p6                       ; Feedback amount
iecho    = p7                       ; Reverb amount
afdbk    init 0                     ; Initialize feedback

ain      soundin  "sample1.wav"

ain      = ain + afdbk*ifdbk        ; Sum input and feedback
atemp    delayr  1                  ; Create 1s delay
atap1    deltapi .0396*idelay       ; Tap 1
atap2    deltapi .0662*idelay       ; Tap 2
atap3    deltapi .1194*idelay       ; Tap 3
atap4    deltapi .1726*idelay       ; Tap 4
atap5    deltapi .2790*idelay       ; Tap 5
atap6    deltapi .3328*idelay       ; Tap 6
         delayw  ain                ; Input signal into delay
afdbk    butterlp  atap6, 7000      ; Lopass filter feedback
abbd     sum  atap1, atap2, atap3, atap4, atap5, atap6 ; Sum taps
abbd     butterlp  abbd, 7000       ; Lowpass filter output
out      (ain + abbd*iecho)*ilevl   ; Level, sum input and delays

endin

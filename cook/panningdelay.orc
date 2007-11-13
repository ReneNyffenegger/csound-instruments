sr       = 44100
kr       = 44100
ksmps    = 1
nchnls   = 2

instr    1 ; 4-Tap Delay with Autopans

ilevl    = p4      ; Output level
itap1    = p5/1000 ; Tap1 delay in ms
itap2    = p6/1000 ; Tap2 delay in ms
itap3    = p7/1000 ; Tap3 delay in ms
itap4    = p8/1000 ; Tap4 delay in ms
ifdbk1   = p9      ; Tap1 feedback
ifdbk2   = p10     ; Tap2 feedback
ifdbk3   = p11     ; Tap3 feedback
ifdbk4   = p12     ; Tap4 feedback
irate1   = p13     ; Tap1 pan rate
irate2   = p14     ; Tap2 pan rate
irate3   = p15     ; Tap3 pan rate
irate4   = p16     ; Tap4 pan rate
ifdbk    = p17/4   ; Master feedback
atap1    init 0
atap2    init 0
atap3    init 0
atap4    init 0

ain      soundin  "sample1.wav"

ataps    sum  atap1, atap2, atap3, atap4
afdbk    = ataps*ifdbk
afdbk1   = atap1*ifdbk1
afdbk2   = atap2*ifdbk2
afdbk3   = atap3*ifdbk3
afdbk4   = atap4*ifdbk4
apan1    oscil  .5, irate1, 1
apan2    oscil  .5, irate2, 1
apan3    oscil  .5, irate3, 1
apan4    oscil  .5, irate4, 1
apan1    = apan1 + .5
apan2    = apan2 + .5
apan3    = apan3 + .5
apan4    = apan4 + .5
atap1    delay  ain + afdbk1, itap1, itap1
atap2    delay  ain + afdbk2, itap2, itap2
atap3    delay  ain + afdbk3, itap3, itap3
atap4    delay  ain + afdbk4, itap4, itap4
al       = atap1*sqrt(apan1) + atap2*sqrt(1 - apan2)
ar       = atap1*sqrt(1 - apan1) + atap2*sqrt(apan2)
al       = al + atap3*sqrt(apan3) + atap4*sqrt(1 - apan4)
ar       = ar + atap3*sqrt(1 - apan3) + atap4*sqrt(apan4)
outs1    ain + al*ilevl
outs2    ain + ar*ilevl

endin

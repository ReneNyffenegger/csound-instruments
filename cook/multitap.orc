sr       = 44100
kr       = 4410
ksmps    = 10
nchnls   = 1

instr    1 ; 8-Tap Multitap Delay

ilevl    = p4            ; Output level
idel1    = p5/1000       ; Tap1 delay
idel2    = p6/1000       ; Tap2 delay
idel3    = p7/1000       ; Tap3 delay
idel4    = p8/1000       ; Tap4 delay
idel5    = p9/1000       ; Tap5 delay
idel6    = p10/1000      ; Tap6 delay
idel7    = p11/1000      ; Tap7 delay
idel8    = p12/1000      ; Tap8 delay
istep    = (p13 - p14)/7 ; Difference value
i1       = p13           ; Tap1 gain
i2       = p13 - istep   ; Tap8 gain
i3       = p13 - istep*2 ; Tap8 gain
i4       = p13 - istep*3 ; Tap8 gain
i5       = p13 - istep*4 ; Tap8 gain
i6       = p13 - istep*5 ; Tap8 gain
i7       = p13 - istep*6 ; Tap8 gain
i8       = p14           ; Tap8 gain
ifdbk    = p15           ; Overall feedback
imix     = p16           ; Mix: 0=Dry 1=Multitap
afdbk    init 0

ain      soundin  "sample1.wav"

ain      = ain + afdbk*ifdbk
atap1    delay  ain, idel1
atap2    delay  atap1, idel2
atap3    delay  atap2, idel3
atap4    delay  atap3, idel4
atap5    delay  atap4, idel5
atap6    delay  atap5, idel6
atap7    delay  atap6, idel7
atap8    delay  atap7, idel8
amulti1  = atap1*i1 + atap2*i2 + atap3*i3 + atap4*i4
amulti2  = atap5*i5 + atap6*i6 + atap7*i7 + atap8*i8
afdbk    = amulti1 + amulti2
out      (amulti1 + amulti2)*imix + ain*(1 - imix)

endin
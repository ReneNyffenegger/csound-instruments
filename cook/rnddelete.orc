sr       = 44100
kr       = 44100
ksmps    = 1
nchnls   = 2

instr    1 ; Random wavecycle delete - complementary outputs

ilevl    = p4       ; Output level
iline1   = p5*2 - 1 ; Fraction deleted - start
iline2   = p6*2 - 1 ; Fraction deleted - end

ain      soundin  "sample1.wav"

kin      downsamp  ain                 ; Convert input to kr
kline    line  iline1, p3, iline2      ; Generate control ramp
krand    rand  1                       ; Generate random signal
kzero    trigger  kin, 0, 0            ; Detect zero crossings
if       kzero = 0 goto output         ; Do nothing if zero
if       krand + kline < 0 goto delete ; If random <0 goto delete...
adelete  = 1                           ; ...if not don't delete...
goto     output                        ; ...then goto output
delete:
adelete  = 0                           ; Delete wavecycle
output:
outs1    ain*adelete*ilevl             ; Level, delete and output
outs2    ain*(1 - adelete)*ilevl       ; Level, -delete and output

endin
sr     = 44100
kr     = 44100
ksmps  = 1
nchnls = 1

instr    1 ; Dynamics processor

ilevl    = p4                       ; Output level
ishape   = p5                       ; Level curve
kenv     init 0                     ; Initialize output
kslope   init 0                     ; Initialize slope

ain      soundin  "sample1.wav"

kin      downsamp  ain              ; Convert to kr
kin      mirror  kin, 0, 32767      ; Full wave rectify
if       kin > kenv goto up         ; See if input exceeds output...
kslope   = kslope + .1              ; Increment slope
kenv     = kenv - kslope            ; Ramp down
goto     out
up:
kslope   = 0                        ; Reset slope
kenv     = kin                      ; Ramp up
out:
kdyn     tablei  kenv/32767, ishape, 1       ; Waveshape dynamics
aout     = ain*(32767/kenv)         ; Remove dynamics from input
out      aout*kdyn*ilevl            ; Level, process and output

endin
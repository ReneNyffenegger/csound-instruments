sr       = 44100
kr       = 44100
ksmps    = 1
nchnls   = 1

instr    1 ; Comparator (Input > 0)

ilevl    = p4
ibal     = p5

ain      soundin  "sample1.wav"

kin      downsamp  ain
acom     = (kin > 0 ? 32767 : -32767)
out      acom*ibal + ain*(1 - ibal)

endin

instr    2 ; Comparator (Input1 > Input2)

ilevl    = p4

ain1     soundin  "sample1.wav"
ain2     soundin  "sample2.wav"

kin1     downsamp  ain1
kin2     downsamp  ain2
acom     = (kin1 > kin2 ? 32768 : -32768)
out      acom*ilevl

endin

sr       = 44100
kr       = 4410
ksmps    = 10
nchnls   = 1

instr    1 ; "Valve" distortion using variable power

idrive   = p4/100

ain      soundin  "sample1.wav"

aindc    = ain/2 + 16384
kin      downsamp  ain
kdrive   = (abs(kin)/4096)*idrive + 1
kpower   pow  32767, kdrive, 32767
ascale   pow  aindc, kdrive
out      (ascale/kpower - 16384)*2

endin

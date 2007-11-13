sr       = 44100
kr       = 4410
ksmps    = 10
nchnls   = 1

instr    1 ; 2 Waveshapers in series, each a mix of 2 curves and pre gain

igain1   = p4        ; Pre gain 1
itabl1   = p5        ; Table 1
itabl2   = p6        ; Table 2
imix1    = p7        ; Mix of tables 1 and 2
igain2   = p8        ; Pre gain 2
itabl3   = p9        ; Table 3
itabl4   = p10       ; Table 4
imix2    = p11       ; Mix of tables 3 and 4
imode    = p12       ; Mode: 0=Clip 1=Wrap
igain3   = p13*32767 ; Post gain

ain      soundin  "sample1.wav"

ain      = ain*igain1
         tableimix  100, 0, 1024, itabl1, 0, (1 - imix1), itabl2, 0, imix1
         tableimix  101, 0, 1024, itabl3, 0, (1 - imix2), itabl4, 0, imix2
         tablegpw  100
         tablegpw  101
awav1    tablei  ain/65535, 100, 1, .5, imode
awav2    tablei  (awav1/2)*igain2, 101, 1, .5, imode
out      awav2*igain3

endin
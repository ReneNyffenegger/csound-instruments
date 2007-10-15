; 1302.ORC
; ORCHESTRA FILE FOR GENERATING STEREO OUTPUT USING TWO GRANULE OPCODES
sr      =       44100
kr      =       4410
ksmps   =       10
nchnls  =       2
        
        instr   1302
k1      linseg  0, 0.05*p3, 1, 0.9*p3, 1, 0.05*p3, 0
a1      granule p4*k1,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17,p18,p19,p20,p21,p22,p23,p24,p25
a2      granule p4*k1,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17,p18,p19,p20+0.17,p21,p22,p23,p24,p25
        outs    a1,a2
        endin

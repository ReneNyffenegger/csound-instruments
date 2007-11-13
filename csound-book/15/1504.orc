; 1504.ORC
; CREATED  BY PER BYRNE VILLEZ 1997  HBYRNE@PAVILION.CO.UK

sr      =       44100
kr      =       4410
ksmps   =       10
nchnls  =       2

        instr   1504 
ktwist  expseg  36, p3*.1,1.1, p3*.3, 1.3, p3*.6,36.3   ; FORMANT FREQ  SLIDE
ktwist2 expseg  36.3, p3*.1,1.3, p3*.3, 1.1, p3*.6, 36  ; FORMANT FREQ  SLIDE

a1      fof     25000, p4, ktwist, 0, 0, .003, .02, .005, 50, 1, 19, p3, 0, 1
a2      fof     25000, p4*1.02, ktwist2, 0, 0, .003, .02, .005, 50, 2, 19, p3, 0,  1

        outs    a1,a2               ; OUTPUT SIGNALS  a1 LEFT, a2 RIGHT

        endin

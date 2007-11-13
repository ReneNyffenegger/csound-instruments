sr      =       44100
kr      =       4410
ksmps   =       10
nchnls  =       2

;; PURE SINE WAVE AT 333Hz WITH DECLICKING
        instr   307
aenv    linseg  1,p3-.05,1,.05,0,.01,0
a1      oscili  p4, 333, 1
        outs    a1*aenv,a1*aenv
        endin

;; WHITE NOISE AT 333Hz WITH DECLICKING
        instr   308
kband   line    p5, p3, p6
aenv    linseg  1,p3-.05,1,.05,0,.01,0
a1      rand    p4
a2      butterbp a1, 333, kband
        outs    a2*aenv,a2*aenv
        endin

;; IMPURE SINE WAVE AT 333Hz WITH DECLICKING
        instr   309
k1      gauss   p5
k2      gauss   p6
aenv    linseg  1,p3-.05,1,.05,0,.01,0
a1      oscili  p4/2, 333, 1
a2      oscili  p4/2, 333+k1, 1
a3      oscili  p4/2, 333+k2, 1
        outs    (a1+a2)*aenv,(a1+a3)*aenv
        endin

;; PITCHED DRUM
        instr   310
idur    =       p3
iamp7   =       p4
iamp2   =       p4 * .8
iamp4   =       p4 * .3

a5      randi   p4, 1500
a5      oscili  a5, 1/idur, 52
a5      oscili  a5, 4000, 1
    
a3      oscili  iamp4, 1/idur, 52
a3      oscili  a3, 33.1, 11

a1      oscili  iamp2, 1/idur, 51
a1      oscili  a1,    333, 1

        outs    a1+a3+a5,a1+a3+a5
        endin

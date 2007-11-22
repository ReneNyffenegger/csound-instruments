

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

;; INSTRUMENT 1
;; Pure sine wave at 333Hz with declicking

instr  1
  aenv      linseg    1,p3-.05,1,.05,0,.01,0
  a1        oscili    p4, 333, 1
            outs      a1*aenv,a1*aenv
endin

;; INSTRUMENT 2
;; White noise at 333Hz with declicking

instr  2
  kband     line      p5, p3, p6
  aenv      linseg    1,p3-.05,1,.05,0,.01,0
  a1        rand      p4
  a2        butterbp  a1, 333, kband
            outs      a2*aenv,a2*aenv
endin

;; INSTRUMENT 3
;; Impure sine wave at 333Hz with declicking

instr  3
  k1        gauss     p5
  k2        gauss     p6
  aenv      linseg    1,p3-.05,1,.05,0,.01,0
  a1        oscili    p4/2, 333, 1
  a2        oscili    p4/2, 333+k1, 1
  a3        oscili    p4/2, 333+k2, 1
            outs      (a1+a2)*aenv,(a1+a3)*aenv
endin

;; INSTRUMENT 4
;; Pitched drum

instr 4
  idur      =  p3
  iamp7     =  p4
  iamp2     =  p4 * .8
  iamp4     =  p4 * .3

  a5        randi     p4, 1500
  a5        oscili    a5, 1/idur, 52
  a5        oscili    a5, 4000, 1

  a3        oscili    iamp4, 1/idur, 52
  a3        oscili    a3, 33.1, 11

  a1        oscili    iamp2, 1/idur, 51
  a1        oscili    a1,   333, 1

            outs      a1+a3+a5,a1+a3+a5
endin

;; INSTRUMENT 5
;; White noise at 333Hz with amplitude modifications

instr 5
  kband     line      p6, p3, p7
  kenv      linseg    p4,p3-.05,p5,.05,0,.01,0
  a1        rand      kenv
  a2        butterbp  a1, 333, kband
            outs      a2,a2
endin

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;jpff@maths.bath.ac.uk
;****++++
;**** Last modified: Wed Dec  2 17:20:41 1998
;****----
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

;;; I N S T R U M E N T    1
;;; WRITE DESCRIPTION HERE
;;; KEYWORDS:

instr 1, 2, 3, 4, 5, 6
;; i1   when    dur freq    amp pan
  il        =  sqrt(p6)            
  ir        =  1-sqrt(p6)
  ipch      table     p4, 2                       ; CONVERT PARAMETER TO CPS
  ishft     gauss     ipch/50                     ; SHIFT BY RELATIVE AMOUNT
                                    ; WAS GAUSS 10
  aenv      linseg    1, p3-.05, 1, .05, 0, .01, 0

  ag        wgpluck2  0.3, p5/3, (ipch), 0.3, 0.3
  agleft    repluck   0.35, p5/4, (ipch+ishft), 0.25, 0.25, ag
  agg       butterhp  agleft, 100
  agh       balance   agg, agleft
  all       =  2.95*agh*aenv
            outs      all*il, all*ir
endin 

instr 7
;; INSTRUMENT 5 from beast
;; WHITE NOISE AT PITCH WITH AMPLITUDE MODIFICATIONS
  ipch      table     p4, 2                       ; CONVERT PARAMETER TO CPS
  kband     line      195.094106, p3, 5
  kenv      linseg    7000, p3-.05, 7000, .05, 0, .01, 0
  a1        rand      kenv
  a2        butterbp  a1, ipch, kband
            outs      a2, a2
endin

instr   8
  a0        =  0
  a1        shaker    p4, 292.987041, 8, 0.99, 100, 0
            outs      a1, a0
endin

instr   9
  idur      =  p3
  iamp2     =  p4*.4
  iamp4     =  p4*.15

  a5        randi     p4, 1500
  a5        oscili    a5, 1/idur, 5
  a5        oscili    a5, 4000, 1

  a3        oscili    iamp4, 1/idur, 5
  a3        oscili    a3, 33.1, 3

  a1        oscili    iamp2, 1/idur, 4
  a1        oscili    a1, 324.339228, 1

  all       =  a1+a3+a5
            outs      all, all
endin

instr   10
  a0        =  0
  a1        shaker    p4, 292.987041, 8, 0.99, 100, 0
            outs      a0, a1
endin

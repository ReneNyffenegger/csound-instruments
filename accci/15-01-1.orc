; ************************************************************************
; ACCCI:        15-01-1.ORC
; timbre:       plucked string
; synthesis:    Karplus-Strong algorithm(15)
;               PLUCK with imeth = 1 (01)
;               pluck-made series(f0) versus
;               self-made random numbers(f77) (1)
; coded:        jpg 8/92

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *****************************************************************
  iamp      =  p4
  ifq       =  p5                                 ; frequency
  ibuf      =  128                                ; buffer size
  if1       =  0                                  ; f0: PLUCK produces its own random numbers
  imeth     =  1                                  ; simple averaging

  a1        pluck     iamp, ifq, ibuf, if1, imeth
            out       a1
endin

instr 2; *****************************************************************
  iamp      =  p4
  ifq       =  p5                                 ; frequency
  ibuf      =  128                                ; buffer size
  if1       =  77                                 ; f77 contains random numbers from a soundfile
  imeth     =  1                                  ; simple averaging

  a1        pluck     iamp, ifq, ibuf, if1, imeth
            out       a1
endin

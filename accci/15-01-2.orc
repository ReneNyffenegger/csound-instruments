; ************************************************************************
; ACCCI:        15-01-2.ORC
; timbre:       plucked string
; synthesis:    Karplus-Strong algorithm(15)
;               PLUCK with imeth=1 (01)
;               EXPSEG envelope (3)
; coded:        jpg 8/92

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *****************************************************************
  idur      =  p3
  iamp      =  p4
  ifq       =  p5                                 ; frequency
  ibuf      =  p6                                 ; buffer size
  if1       =  p7                                 ; various random number sources are called
  imeth     =  1                                  ; simple averaging

  kamp      expseg    iamp,8/10*idur,iamp, 2/10*idur,.0001
  a1        pluck     kamp, ifq, ibuf, if1, imeth
            out       a1
endin


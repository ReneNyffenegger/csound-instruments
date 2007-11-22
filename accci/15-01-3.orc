; ************************************************************************
; ACCCI:        15-01-3.ORC
; timbre:       plucked string
; synthesis:    Karplus-Strong algorithm(15)
;               PLUCK (01)
;               LINSEG envelope,
;               varying parameter if1: 10 different sources of random
;               numbers, two different buffer sizes (3)
; coded:        jpg 9/92

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

  kamp      linseg    iamp,8/10*idur,iamp,2/10*idur,0
  a1        pluck     kamp, ifq, ibuf, if1, imeth
            out       a1
endin

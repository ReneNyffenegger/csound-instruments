; ************************************************************************
; ACCCI:        15-01-4.ORC
; timbre:       plucked string with bottle neck
; synthesis:    Karplus-Strong algorithm(15)
;               PLUCK with imeth=1 (01)
;               Pitchbend mechanism, stereo (4)
; coded:        jpg 8/92

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  2

instr 1; *****************************************************************
  idur      =  p3
  iamp      =  p4
  ifq       =  cpspch(p5)                         ; convert pitch to frequency, init pass
  ibuf      =  p6                                 ; buffer size

  if1       =  p7                                 ; various random number sources are called
  if2       =  p8                                 ; left and right channel use different sources !
  imeth     =  1                                  ; simple averaging
  igliss    =  p9/24                              ; deviation width of pitch

  kamp      linseg    iamp,8/10*idur,iamp,2/10*idur,0

                      ; pitch bend control signal
  kfq       expseg    1, 5/10*idur, 1-igliss, 5/10*idur, 1-igliss

  a1        pluck     kamp, kfq*ifq, ibuf, if1, imeth
  a2        pluck     kamp, kfq*ifq, ibuf, if2, imeth

            outs      a1,a2                       ; stereo
endin


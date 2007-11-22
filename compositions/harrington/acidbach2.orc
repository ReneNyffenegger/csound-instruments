  sr        =  44100
  kr        =  882
  ksmps     =  50

  ga1       init      0

instr          1                                       ;;; HARPICHORD
  a1        pluck     p5*.1,p4,512,0,1,1
  a2        pluck     p5*.25,p4,256,0,1,1
  a3        =  a1 +a2 * .5
  ga1       =  ga1 +   a3
            out       a3
endin




instr     99
  a3        reverb    ga1, .15
  a4        reverb    ga1, .31
;a5            delay     ga1, .735, 0
;a6            delay     ga1, .375, 0
  a7        reverb    a3 + a3, .4
            out       (a3 + a4 + .125 * a7) * .1
  ga1       =  0
endin
;;;
;;; HARPSICHORD 2
;;;











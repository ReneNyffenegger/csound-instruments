; ************************************************************************
; ACCCI:     50-09-1.ORC
; timbre:    noise
; synthesis: subtractive synthesis(50)
;            continuous control of bw(09)
;            variable cfq(1)
; source:    Dodge (1985)
; coded:     jpg 11/93


  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  2 


instr 1; *****************************************************************
  idur      =  p3
  iamp      =  p4
  icfq      =  p5
  ipeakbw   =  p6
  iratebw   =  p7*(1/idur)

  kbw       oscil     1, iratebw, 1, 0.75         ; sinus at 270 degrees
  kbw       =  (kbw + 1)/2                        ; shift envelope to pos. dom.
  kbw       =  kbw * ipeakbw                      ; scale it to peak deviation

  anoise    rand      iamp                        ; white noise
  a1        reson     anoise,  icfq, kbw, 1       ; filter
            outs      a1, a1

endin




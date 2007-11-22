  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

  ; p4 = center frequency  ; p5 = bandwidth
instr 1
  kamp      expseg    1, p6, 8000, p3-(p6+p7), 5000, p7, 1
  anoise    rand      kamp                        ; white noise source audio signal
  aout      reson     anoise,  p4,  p5, 1         ; (note iscl scalar argument  = 1)
            out       aout
endin



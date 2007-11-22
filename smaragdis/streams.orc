  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1

  p2        =  p2   +    p9
  amp       oscil     1, 1 / p3, p4
  adens     oscil     1, 1 / p3, p5
  alofr     oscil     1, 1 / p3, p6
  ahifr     oscil     1, 1 / p3, p7
  awind     oscil     amp, adens, p8
  afr       randi     ahifr, adens
  astream   oscil     awind, alofr + afr, 1

  gasig     =  astream / p10
            out       gasig
endin

instr 2

  awet      reverb    gasig, p4
            out       awet / p5
endin

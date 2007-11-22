  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  amp       line      2, p3, 0
  ktri      oscil     10000, 1/p3, 3
  a1        grain     ktri, 1000,  1000, 0, 100, .05, 1, 2, 1
  a2        grain     ktri, 1000,  600 , 0,  80, .05, 1, 2, 1
  a3        grain     ktri, 1000,  200 , 0, 130, .05, 1, 2, 1
  a4        expon     1, p3, .1
;a5             vdelay  (a1+a2+a3), a4, 1
  a5        =  (a1+a2+a3)
  a6        reverb    a5, 1.5
            out       (a5 * (a4 - .1) + a6 * (.9 - a4 -.1) / 4)
                ;out            (a5 + a6/2)/4
endin

instr 2
                        
  a1        grain     5000, 0, 1000, 0, 100, .05, 1, 2, 1
  a2        grain     5000, 0,  600, 0,  80, .05, 1, 2, 1
  a3        grain     5000, 0,  200, 0, 130, .05, 1, 2, 1
            out       a1+a2+a3
endin

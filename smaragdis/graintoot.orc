  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1


instr 1
  kamp      line      0, p3, 32000
  agr       grain     kamp, 1000, 10, 0, 0, .05, 1, 2, .05
            out       agr
endin

instr 2
  agr       grain     0, 1000, 10, 32000, 0, .05, 1, 2, .05
            out       agr
endin

instr 3
  kfreq     line      0, p3, 6000
  agr       grain     20000, kfreq, 10, 0, 0, .05, 1, 2, .05
            out       agr
endin

instr 4
  kfreqoff  line      0, p3, 6000
  agr       grain     10000, 100, 10, 0, kfreqoff, .05, 1, 2, .05
            out       agr
endin

instr 5
  kdens     line      1, p3, 200
  agr       grain     5000, 1000, kdens, 0, 0, .005, 1, 2, .005
            out       agr
endin

instr 6
  klen      line      .001, p3, .2
  agrl      grain     20000, 1000, 10, 0, 0, klen, 1, 2, .2
            out       agrl
endin

instr 7
  agr       grain     32000, 1000, 10, 0, 0, .05, 1, 3, .05
            out       agr
endin

instr 8
  agr       grain     2000, 1/.55 , 40, 30000, 2/.55, .1, 4, 2, .1
            out       agr
endin

instr 9
  ktri      oscil     3000, 1/p3, 3
  a1        grain     ktri, 1000, 100, 100, 1000, .1, 1, 2, .1
  a2        grain     ktri, 600 , 80,  50, 1000, .1, 1, 2, .1
  a3        grain     ktri, 200 , 130, 10, 1000, .1, 1, 2, .1
  a4        line      0, p3, 1
  a5        pow       a4, 2, 1
  a6        vdelay    (a1+a2+a3), a5, 1.1
  a7        reverb2   a6, 1.5, .2
            out       (a6*(a5-.1) + a7*(.9-a5-.1)/4)
endin




  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1                  ; CELESTA (ADD)
  kfreq     cpsmidib  
  iveloc    veloc     
  kgate     linenr    iveloc/(128*3), 0, 1, .1

  k1        line      32000, 2, 0
  k2        oscil     1000, 3, 1
  k1        =  k1 + k2
  a1        oscil     k1, kfreq + k2*.005, 1
  a2        oscil     k1, 4.1*kfreq + k2*.005, 1
          ;out      (a1 + a2/2) * kgate
  ga1       =  (a1 + a2/2) * kgate
endin

instr 2
  ikfreq    cpsmidib  
  kfreq     cpsmidib  
  iveloc    veloc     
  kgate     linenr    iveloc/128, 0, .1, .1

  a1        pluck     35000, kfreq/2, ikfreq/2, 0, 1
  a1        butterlp  a1, 100
          ;out      a1 * kgate * 7
  ga1       =  ga1 + a1 * kgate * 7
endin

instr 3                  ; SLOW STRINGS (SUB)
  kfreq     cpsmidib  
  iveloc    veloc     
  kgate     linenr    iveloc/128, 0, .5, .1

  k1        linseg    0, .5, 32000, .5, 25000
  k2        oscil     kfreq*.005, 3, 1
  a1        oscil     k1, kfreq + k2, 2
  a2        oscil     k1, kfreq + k2 + 1, 2
  a3        oscil     k1, 2*(kfreq + k2), 2
  a1        butterlp  a1 + a2 + a3, 1200
          ;out      a1/4 * kgate
  ga1       =  ga1 + a1/4 * kgate
endin

instr 129
  ga1       butterhp  ga1, 20
  ab        =  ga1
  a1        reverb2   ga1, 1.7, .5
            out       (ab + a1/10)
          ;out      ga1
  ga1       =  0
endin

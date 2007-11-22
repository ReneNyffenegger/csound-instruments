
; LUX HOMINUM ARTHUR B. HUNKINS 1995
; PROGRAMMED IN CSOUND
; VERSION WITHOUT SCORE11 PREPROCESSING 
; USE WITH lux.sco

; In him was life
; and that life was the light of men. 
; John 1:4


; 


  sr        =  44100 
                              ; quality/clarity deteriorates below about 30000 
  kr        =  4410 
                              ; set to sr / 10
  ksmps     =  10
  nchnls    =  2

  gitrans   =  0                                  ; transpose range (1.0=octave): -.25 to +.58 
  giwave    =  1                                  ; wave choices: 1=sine, 2=pseudo-triangle 
  givers    =  1                                  ; version choices: 1, 2, 3 (diff mod indexes) 
  givers    =  (giwave == 1? givers: givers + 3) 

instr     1, 16

  kamp      linen     1, 12, p3, 12
  kamp2     table     kamp * 511, 5
  ifreq     =  cpsoct(8.00 + gitrans)
  ifreq     =  (p1 == 1? ifreq: ifreq * 2)
  iamult    =  (p1 == 1? 6000: 4500)
  kamp3     =  kamp2 * iamult
  kamp4     randi     kamp3 * .075, 22
  a1        oscil     kamp3 + kamp4, ifreq, 1
  kpan      linseg    0, 12, .5, p3 - 24, .5, 12, .42 
  a2,a3,a4,a5  pan    a1, (p1 == 1? 1 - kpan: kpan), 1, 13, 1 
            outs      a2, a3
endin

instr     2, 15

  kamp      linen     1, 12, p3, 12
  kamp2     table     kamp * 511, 5
  ifreq     =  cpsoct(8.00 + gitrans)
  iamult    =  (p1 == 2? 8500: 9000)
  kamp3     =  kamp2 * iamult
  kamp4     randi     kamp3 * .09, 22
  a1        oscil     kamp3 + kamp4, ifreq, (p1 == 2? 3: 4)
  kpan      linseg    0, 12, .5, p3 - 24, .5, 12, .42 
  a2,a3,a4,a5  pan    a1, (p1 == 2? kpan: 1 - kpan), 1, 13, 1 
            outs      a2, a3
endin

instr     3, 4

  kamp      linen     1, 12, p3, 12
  kamp2     table     kamp * 511, 5
  icar      table     p4 * 2 - 2, givers + 6
  iamult    table     p4 * 2 - 1, givers + 6
  kamp3     =  kamp2 * iamult
  kamp4     randi     kamp3 * .04, 22
  imod      table     p4 - 1, 6
  ifreq     =  cpsoct(8.00 + gitrans)
  ifreqc    =  ifreq * icar
  ifreqm    =  ifreq * imod
  kindex    randi     .15, 20
  a1        oscil     ifreqm * kamp * (4.85 + kindex), ifreqm, giwave
  a2        oscil     10000 * (kamp3 + kamp4), ifreqc + a1, 1
  kpan      linseg    .5, 12, 1, p3 - 24, 1, 12, .85 
  a3,a4,a5,a6  pan    a2, (p1 == 3? 1 - kpan: kpan), 1, 13, 1 
            outs      a3, a4
endin

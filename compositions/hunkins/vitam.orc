
; ET VITAM VENTURI III ARTHUR B. HUNKINS 1995 
; PROGRAMMED IN CSOUND, WITH SCORE11 PREPROCESSING OF SCOREFILE 

; And I look for the resurrection of the dead. 
; And the life of the world to come.
;    Apostles' Creed

; And Jesus said to him, "Verily I say to you, 
; today you will be with me in paradise." 
; Luke 23:43


  sr        =  44100                              ; may be any number from about 6000 on up 
  kr        =  4410                               ; must be sr / 10
  ksmps     =  10
  nchnls    =  2

  gifreq    =  400                                ; select between 350-500

; if      0, random selection 

  gicar     =  1
 
; 1       =         little mod
; 2       =         var, little
; 3       =         a lot
; 4       =         var, a lot 

  gicar1    =  (gicar == 1? .38: 1.1)
  gifreq1   =  (gifreq > 0? gifreq: p4)


instr 1

            tigoto    skip
  ifreq     =  gifreq1
if        p4        == 2 igoto over
  iamp      =  8500
  ipan      =  1
  icamp     =  (gicar > 2? .3: 0)
            igoto     skip
over:
  iamp      =  13500
  ipan      =  2
  icamp     =  (gicar > 2? .7: .2)
skip:
  kamp      linen     1, p6, p3, p7
  kamp      table     kamp * 511, 2
  kamp2     linseg    0, p6, 1, p3 - p6 - p7, 1, p7, icamp * .5
  kamp2     table     kamp2 * 511, 2
  krand     randi     kamp * ifreq * .0086, 500, -.5
  a1        foscil    iamp*kamp, ifreq+krand, 1, 1, kamp2*icamp, 1, -1
  kpan      =  (ipan = 1? kamp2 * .5: 1 - (kamp2 * .5)) 
  a2,a3,a4,a5  pan    a1, kpan, 1, 4, 1
            outs      a2, a3
if        p3 < 99   goto fin
            ihold     
fin:
endin


instr 2, 3

            tigoto    skip
  ifreq     =  gifreq1
  ipan      =  (p4 < 20? 1: 2)
  icamp     =  (int(gicar * .5) == (gicar * .5)? p8: gicar1) 
  icamp     =  (gicar == 2? icamp * .4: icamp)
  idiv      =  int(p4/8)
  ifac      =  p4 - (idiv * 8)
  icfreq    table     ifac, 3
  icfreq2   =  (p4 > 23? -icfreq: icfreq)
  ifreq2    =  gifreq1 * icfreq2
  ifreq3    =  gifreq1 + ifreq2
  ifreq3    =  (ifreq3 > 1050? gifreq1 - ifreq2: ifreq3) 
  gifreq1   =  (ifreq3 < 260? gifreq1 - ifreq2: ifreq3) 
skip:
  kamp      linen     1, p6, p3, p7
  kamp      table     kamp * 511, 2
  kamp2     linseg    0, p6, 1, p3 - p6 - p7, 1, p7, .5
  kamp2     table     kamp2 * 511, 2
  krand     randi     kamp * ifreq * .0028, 500, -.5
  a1        foscil    15000*kamp,ifreq+krand,1,icfreq,kamp2*icamp,1,-1
  kpan      =  (ipan = 1? .5 - (kamp2 * .5): (kamp2 * .5) + .5) 
  a2,a3,a4,a5  pan    a1, kpan, 1, 4, 1
            outs      a2, a3
if        p3 < 99   goto fin
            ihold     
fin: 
endin

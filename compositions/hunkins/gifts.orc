
; GIFTS ARTHUR B. HUNKINS 1991
; PROGRAMMED IN CSOUND

; "In the beginning God created the heavens and the earth. 
; God said, "Let there be light," and there was light." 
; Genesis 1: 1,3

; "In the beginning was the Word, and the Word was God. 
; All things were made through him.
; In him was life, and the life was the light of men." 
; John 1: 1,3,4

; "By the word of the Lord his works came into being. 
; As the shining sun looks on all things, 
; so the work of the Lord is full of his glory." 
; Sirach 42: 15,16


; ORCHESTRA

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

  gifreq    =  p6
  gifreq1   =  0
  gifreq2   =  0
  gifreq3   =  0
  gifreq4   =  0
  gifreq5   =  0
  gifreq6   =  0
  giamp     =  0
  gicloud   =  0
  gicloud2  =  0
  gicloud3  =  0


instr 1

  k1        linen     1, p6, p3, p7
  k1        tablei    k1*512, 2
  k2        randi     k1*.06, 50
  gifreq1   =  (p4=-1? gifreq1: gifreq*p4)
  gifreq1   =  (p4>40? p4: gifreq1)
  a1        oscili    k1+k2, gifreq1, 1, -1
if        p3<99     goto fin
            ihold     
fin:
            out       a1*2500*p5
endin


instr 2

  k1        linen     1, p6, p3, p7
  k1        tablei    k1*512, 2
  k2        randi     k1*.06, 50
  ifreq     =  (p4=-1? gifreq2: gifreq*p4)
  ifreq     =  (p4>40? p4: ifreq)
  ifreq2    =  gifreq*p4
if        p8=0      goto 1
  kfreq     line      gifreq2, p3, ifreq2
1:
  gifreq2   =  (p8=1? ifreq2: ifreq)
  a1        oscili    k1+k2, (p8=1? kfreq: ifreq), 1, -1
if        p3<99     goto fin
            ihold     
fin:
            out       a1*2500*p5
endin



instr 3

  k1        linen     1, p6, p3, p7
  k1        tablei    k1*512, 2
  k2        randi     k1*.06, 50
  ifreq     =  (p4=-1? gifreq3: gifreq*p4)
  ifreq     =  (p4>40? p4: ifreq)
  ifreq2    =  gifreq*p4
if        p8=0      goto 1
  kfreq     line      gifreq3, p3, ifreq2
1:
  gifreq3   =  (p8=1? ifreq2: ifreq)
  a1        oscili    k1+k2, (p8=1? kfreq: ifreq), 1, -1
if        p3<99     goto fin
            ihold     
fin:
            out       a1*2500*p5
endin


instr 4

  k1        linen     1, p6, p3, p7
  k1        tablei    k1*512, 2
  k2        randi     k1*.06, 50
  ifreq     =  (p4=-1? gifreq4: gifreq*p4)
  ifreq     =  (p4>40? p4: ifreq)
  ifreq2    =  gifreq*p4
if        p8=0      goto 1
  kfreq     line      gifreq4, p3, ifreq2
1:
  gifreq4   =  (p8=1? ifreq2: ifreq)
  a1        oscili    k1+k2, (p8=1? kfreq: ifreq), 1, -1
if        p3<99     goto fin
            ihold     
fin:
            out       a1*2500*p5
endin


instr 5

  k1        linen     1, p6, p3, p7
  k1        tablei    k1*512, 2
  k2        randi     k1*.06, 50
  ifreq     =  (p4=-1? gifreq5: gifreq*p4)
  ifreq     =  (p4>40? p4: ifreq)
  ifreq2    =  gifreq*p4
if        p8=0      goto 1
  kfreq     line      gifreq5, p3, ifreq2
1:
  gifreq5   =  (p8=1? ifreq2: ifreq)
  a1        oscili    k1+k2, (p8=1? kfreq: ifreq), 1, -1
if        p3<99     goto fin
            ihold     
fin:
            out       a1*2500*p5
endin


instr 6

  k1        linen     1, p6, p3, p7
  k1        tablei    k1*512, 2
  k2        randi     k1*.06, 50
  ifreq     =  (p4=-1? gifreq6: gifreq*p4)
  ifreq     =  (p4>40? p4: ifreq)
  ifreq2    =  gifreq*p4
if        p8=0      goto 1
  kfreq     line      gifreq6, p3, ifreq2
1:
  gifreq6   =  (p8=1? ifreq2: ifreq)
  a1        oscili    k1+k2, (p8=1? kfreq: ifreq), 1, -1
if p3<99  goto      fin
            ihold     
fin:
            out       a1*2500*p5
endin


instr 7

  giamp     =  (p5>0? p5: giamp)
  gicloud   =  (p4>3? p4: gicloud)
  gicloud2  =  (p4=2? p6*gicloud: gicloud2)
  gicloud3  =  (p4=3? p6*gicloud: gicloud3)

  ifreq     =  gicloud
  ifreq     =  (abs(p4)=2? gicloud2: ifreq)
  ifreq     =  (abs(p4)=3? gicloud3: ifreq)

  k1        linen     1, .016, .16, .144
  k1        tablei    k1*512, 2
  a1        oscili    k1, ifreq, 3
  iampfac   =  24000*(p4<0? giamp*.22: giamp) 
if        p4<0      goto 1
  gaout     =  a1*iampfac
            goto      2
1:
  gaout1    =  a1*iampfac
2:
endin


instr 8

  a1        reverb    gaout, 5
  a2        reverb    gaout1, 5
            out       gaout+a1*.025+gaout1+a2*.06
endin


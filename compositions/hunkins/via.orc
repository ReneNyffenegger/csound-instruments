
; VIA CREATIVA/VIA TRANSFORMATIVA ARTHUR B. HUNKINS 1990 
; PROGRAMMED IN CSOUND
; "From the beginning till now the entire creation has been groaning 
; in one great act of giving birth."
;    Romans 8:22
; "What is born of the Spirit is spirit. The wind blows wherever it pleases; 
; you hear its sound, but you cannot tell where it comes from or where 
; it is going. That is how it is with all who are born of the Spirit." 
; John 3:6, 8
; "We are fellow workers with God."
; I Corinthians 3:1

; DEDICATED TO CREATION-CENTERED SPIRITUALITY 
; AND MATTHEW FOX, AUTHOR OF ORIGINAL BLESSING 


; ORCHESTRA

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  ifreq     table     p4 - 1, 2
  iampfac   table     p4 - 1, 3
  iflag     =  p5
if        iflag     >= 0 goto skip
  arand     =  0
            goto      skip1
skip: 
  kmod      linseg    p5, p6, p7, p8, p9, p10, p11 
  kmod      =  kmod * 800
  arand     rand      kmod
skip1: 
  kamp      linseg    p12,p13,p14,p15,p16,p17,p18,p19,p20,p21,p22,p23,p24,p25,p26 
  ksclamp   tablei    kamp * 51.1, 4
  a1        oscil     18000 * ksclamp * iampfac, ifreq + arand, 1, -1
if        iflag     >= 0 goto skip2
            out       a1
            goto      last
skip2: 
  aband     reson     a1, ifreq, ifreq * .14, 0, 1 
  aband1    reson     aband, ifreq, ifreq * .14, 0, 1 
  a2        balance   aband1, a1
            out       a2
last: 
endin

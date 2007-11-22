  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

  ga1       init      0

; ========================================== ;
; ============ Flute-like #100 ============= ;
; ========================================== ;

instr 1
if        p12 = 12 igoto dc1
  i1        =  .6
            goto      start

dc1:
  i1        =  .74
            goto      start

start:
  k1        randi     (p4*.01),p9
  k1        =  k1 + p4
  k2        oscil     k1,1/p11,p12
  k2        =  k2 + i1
  k3        oscil     k2,1/p6,p9
  a1        oscili    k3,p5,p10
  a2        =  a1*10
  ga1       =  ga1+(p13*a2)                       ; p13 = RVB SEND LEVEL
            out       a2
endin
          

instr 2
  k1        oscil     p4,1/p6,p7
  k2        oscil     p5,1/p6,p8
  a1        oscili    k1,k2,1
  a2        =  a1*10
  ga1       =  ga1+(p9*a2)                        ; p9 = RVB SEND LEVEL
            out       a2
endin

; ========================================== ;
; =======  Global Reverb Instrument  ======= ;
; ========================================== ;

instr 6
  ga1       init      0                        
  a1        reverb    ga1,p4                      ; p4 = REVERB TIME IN SECONDS
  a2        =  a1*p5                              ; p5 = REVERB RETURN LEVEL
            out       a2
  ga1       =  0
endin

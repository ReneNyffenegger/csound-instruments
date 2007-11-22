;BUZZTALK - TEST OF TERM ANALGOUE MODEL OF SPEECH
;USES SLAWSON'S FORMANTS

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr          1

  a1        buzz      p4,p5,p6,1                  ;P4=AMP,P5=CPS,P6=KNH
  a2        reson     a1,p7,p8,1,0
  a3        reson     a1,p9,p10,1,0
  a4        reson     a1,p11,p12,1,0
  a5        reson     a1,p13,p14,1,0

  a6        balance   (a2+a3+a4+a5),a1
            out       a6
endin

instr          2
       
  a1        buzz      p5,cpspch(p4),p6,1          ;P4=AMP,P5=CPS,P6=KNH WORKS WITH RANDOM.SCO

  a2        reson     a1,p7,p8,1,0
  a3        reson     a2,p9,p10,1,0
  a4        reson     a3,p11,p12,1,0
  a5        reson     a4,p13,p14,1,0

  a6        balance   (a5),a1
            out       a6
endin



instr          3                                  ;MOVES FROM TABLE #4 - A - TO #5 - O OVER P3
  k3        linseg    p5,p3,p5
  a1        buzz      p4,k3,p6,1                  ;p4=amp,p5=cps,p6=knh
  k1        linseg    p7,p3*.35,p7*.63,p3*.65,p7*.44 ;FROM 800 TO 500 (63% OF P7)
  a2        reson     a1,k1,p8,1,0
  k2        linseg    p9,p3*.65,p9*.65,93*.35,p9*.54 ;FROM 1300 TO 850
  a3        reson     a2,k2,p10,1,0
  a4        reson     a3,p11,p12,1,0
  a5        reson     a4,p13,p14,1,0

  a6        balance   (a5),a1
            out       a6
endin



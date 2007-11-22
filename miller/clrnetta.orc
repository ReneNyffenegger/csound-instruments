;TEST OF SOUNDIN

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr          1                             ;CLAR
  k1        line      p5,p3,p6
  a1        oscil     p4,k1*(1/p3),1              ;1/P3 WILL READ THRU FUNCTION AT A RATE DETERMINED BY DURATION OF NOTE
;a1            oscil     p4,k1,1
            out       a1                          ;K1 SAYS HOW MANY TIMES TO LOOP THRU
endin                                        ;TRY 1/P3 WITH LINSEG (K1/P3)


instr          2                             ;snaretta
  k1        line      p5,p3,p6
  a1        oscil     p4,k1*(1/p3),2              ;1/P3 WILL READ THRU FUNCTION AT A RATE DETERMINED BY DURATION OF NOTE
;a1            oscil     p4,k1,1
            out       a1                          ;K1 SAYS HOW MANY TIMES TO LOOP THRU
endin                                        ;TRY 1/P3 WITH LINSEG (K1/P3)


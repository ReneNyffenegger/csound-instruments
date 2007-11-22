  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2
instr 1

;ENVELOPE                                                        ;p6:ATT,p7:DEC,
  k1        envlpx    p5,p6,p3,p7,1,.8,.001       ;p5: AMPLITUDE
;SEGMENT CONTROLLING INDEX MOVE
; k2           expseg    p8, p6, p9, p3 - (p6 + p7), p9, p7, p8
;p8: 1ST INDEX, p9: 2ND INDEX
  k2        envlpx    p9, p6, p3, p7, 1, .8, .01
;SOUND
  a1        foscil    k1,cpsoct(p4),p10,1,k2,p11  ;AUDIO FUNC :p11
  a2        foscil    k1,cpsoct(1.001 * p4),p10,1,k2,p11 ;C:M RATIO: p10
  a3        foscil    k1,cpsoct(1.003 * p4),p10,1,k2,p11
  a4        foscil    k1,cpsoct(.999 * p4),p10,1,k2,p11
  a5        foscil    k1,cpsoct(.997 * p4),p10,1,k2,p11

  a1        =  (.2 * a1) + (.2 * a2) + (.2 * a3) + (.2 * a4) + (.2 * a5)

  a2        delay     a1,.01
  a3        delay     (a1 + (.4 * a2)),.023
  a1        =  a1 + a2 + a3
; a4           comb      a1, .1, .02
; a1           =         (a1 * .6) + (a4 * .4)
; a1           =         a1 + a2

            outs      a1 * .5, a1 * .5
endin

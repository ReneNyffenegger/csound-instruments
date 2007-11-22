  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

  ga1       init      0

instr          1                        ;PANER WHICH AFFECTS EVERY NOTE
  k2        linseg    0,p3*.001,p4,p3*.2,p4*.2,p3*.799,0
  a1        oscili    k2,p5,1                     ;SOUNDING OSC
  k1        oscil     1,1/p3,2
            outs1     a1*k1
            outs2     a1*(1-k1)
endin

instr          2                        ;GLOBAL PANER
  k1        oscil     1,1/p3,2                    ;PAN INSTR SHOULD BE ONE LONG NOTE FOR DUR
            outs1     ga1*k1
            outs2     ga1*(1-k1)
endin

;instr         3                        ;GLOBAL SOURCE
;k2            linseg    0,p3*.001,p4,p3*.2,p4*.2,p3*.799,0
;ga1           oscili    k2,p5,1        ;SOUNDING OSC
;endin

instr          3
  k1        expseg    p4*1.5,.1,p4,p3*.9,p4,.05,p4*.001
  ga1       foscil    k1,1,p5,p5*.57,p6,1,0
endin


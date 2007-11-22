;7/25/89
;FLARE.ORC  LOW FM CLAR WITH DYNAMIC INDEX AND FILTER

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

  ga1       init      0




instr          1                             ; A;TERNATE SOURCE WITH NEW AMPSEG,REVERB, AND PANNING

  k1        expseg    p4*.001,p3*.05,p4,p3*.7,p4,p3*.2,p4*.05 ;AMPSEG
                                                                      ;P9=SCALING OF CRESC
  k2        expseg    p7,p3*.1,p8,p3*.9,p8        ;INDX SEG
  k3        expseg    p5*1.03,p3*.05,p5,p3*.95,p5 ;CARRIER SEG
  k4        expseg    p6*1.02,p3*.05,p6,p3*.95,p6 ;MOD SEG
  k5        expseg    p5*1.05,p3*.05,p5*.95,p3*.85,p5,p3*.1,p5*5
  k6        linseg    p9,p3,p9*.1                 ;P9=KCF
  k7        linseg    p10*.5,p3,p10*2             ;P10=KBW
  ga1       foscili   k1,1,p5,p6,k2,1,0
  ga2       reson     ga1,k6,k7,0,0
endin

instr          2                             ;ALTERNATE GLOBAL REVERB  MUST BE TURNED ON FOR DURATION
  ga3       reverb    ga2,.75                     ;PAN INSTR SHOULD BE ONE LONG NOTE FOR DUR
endin

       
instr          3                             ;GLOBAL PAN  MUST BE TURNED ON FOR DURATION OF ALL PAN
  k1        oscil     1,1/p3,2                    ;PAN INSTR SHOULD BE ONE LONG NOTE FOR DUR
            outs1     ga3*k1
            outs2     ga3*(1-k1)
endin






  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr   1
;                               AMP,        FREQ, STIFF,ATT,DTK,NGAIN,VFRQ, VAMT,TAB,LFRQ
  a1        wgclar    31129.60, 440, -0.3, 0.1, 0.1, 0.2, 5.735, 0.1, 1, 50
            out       a1
endin       

instr   2
;                               AMP,        FREQ,JET, ATT, DTK, NGAIN,VFRQ, VAMT,TAB,LFRQ
  a1        wgflute   31129.60, 440, 0.32, 0.1, 0.1, 0.15, 5.925, 0.05, 1, 50
            out       a1
endin                            

instr   3
  kv        linseg    0, 0.5, 0, 1, 1, p3-0.5, 1
;                               AMP,            FREQ,PRES,RAT,    VFRQ,  VGN, TAB, LFREQ
  a1        wgbow     31129.60, 440, 3.0, 0.127236, 6.12723, kv*0.01, 1, 50
            out       a1
endin       

instr   4
;                               AMP,    FRQ, HRD, POS,  IT, VFRQ,VG,  VT, DEATTACK
  a1        marimba   31129.60, 440, 0.5, 0.561, 2, 6.0, 0.05, 1, 0.1
            out       a1
endin 
         
instr   5
;                               AMP,    FREQ,LIP, DET, VFRQ, VAMT,TAB,LFRQ
  k1        line      0.2, p3, 1
  a1        wgbrass   31129.60, 440, 0.4, 0.1, 6.137, 0.05, 1, 50
            out       a1
endin       

instr   6
;                               AMP,            FRQ, HRD, POS,  IT, VFRQ,VG,  VT, DEATTACK
  a1        vibes     31129.60, 440, 0.5, 0.561, 2, 4.0, 0.2, 1, 0.1
            out       a1
endin 

instr   7
;                               AMP,        FRQ, HRD, POS,      IT, VFRQ,VG,  VT
  a1        agogobel  31129.60, 440, p4, 0.561, 3, 6.0, 0.3, 1
            out       a1
endin 

instr   8
;ar             shaker  KAMP,     KFREQ, KBEANS, KDAMP, KTIMES[, IDECAY]; KAMP, KFREQ, KBEANS, KDAMP, KNUM, KTIMES[, IDECAY]
  a1        shaker    31129.60,          440,  8,        0.999,        0, 100
            out       a1
endin       

instr   9
;                               AMP,      FREQ, C1,C2,VDEP,VRATE, TABLES... 
  a1        fmbell    31129.60, 440, 1, 1.2, 0.2, 6, 1,1,1,1,1
            out       a1
endin       

instr   10
;                               AMP,      FREQ, C1,C2,VDEP,VRATE, TABLES... 
  a1        fmrhode   31129.60, 440, 1, 1.2, 0.2, 12, 1,1,1,4,1
            out       a1
endin       

instr   11
;                               AMP,      FREQ, C1,C2,VDEP,VRATE, TABLES... 
  a1        fmwurlie  31129.60, 440, 1, 1.2, 0.2, 8, 1,1,1,4,1
            out       a1
endin 
         
instr   12
;                               AMP,      FREQ, C1,C2,VDEP,VRATE, TABLES... 
  a1        fmmetal   31129.60, 110, 1, 1.2, 0.2, 5.5, 1,5,5,1,1
            out       a1
endin       
         
instr   13
;                   AMP,   FREQ, C1,C2,VDEP,VRATE, TABLES... 
  a1        fmb3      31129.60, 440, 1, 1.2, 0.2, 8, 1,1,1,1,1
            out       a1
endin       

instr   14
  k1        line      0, p3, 64
  a1        fmvoice   31129.60, 110, k1, 0, 0.005, 6, 1,1,1,1,1
            out       a1
endin                            

instr   15
  a1        fmpercfl  31129.60, 440, 0.1, 0.1, 0.5, 12, 1,1,1,1,1
            out       a1
endin                            

instr   16
  a1        moog      31129.60, 440, 0.85, 0.0001, 0.6, 8, 6,7,1
            out       a1
endin

instr   18
  a1        mandol    31129.60, 440, 0.4, 0.995, p4, 1, 6
            out       a1
endin

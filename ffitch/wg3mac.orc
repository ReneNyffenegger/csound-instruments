  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  1

instr       1
            ;;          amp,      freq, stiff,att,dtk,nGain,vFrq, vAmt,tab,lFrq
  a1        wgclar    31129.60, 440, -0.3, 0.1, 0.1, 0.2, 5.735, 0.1, 1, 50
            out       a1
endin       

instr       2
            ;;          amp,      freq,jet, att, dtk, nGain,vFrq, vAmt,tab,lFrq
  a1        wgflute   31129.60, 440, 0.32, 0.1, 0.1, 0.15, 5.925, 0.05, 1, 50
            out       a1
endin                   

instr       3
  kv        linseg    0, 0.5, 0, 1, 1, p3-0.5, 1
            ;;          amp,      freq,pres,rat,    vFrq,    vGn, tab, lFreq
  a1        wgbow     31129.60, 440, 3.0, 0.127236, 6.12723, kv*0.01, 1, 50
            out       a1
endin       

instr       4
            ;;          amp,      frq, hrd, pos,  it, vFrq,vG,  vt, deattack
  a1        marimba   31129.60, 440, 0.5, 0.561, 2, 6.0, 0.05, 1, 0.1
            out       a1
endin 
      
instr       5
            ;;          amp,      freq,lip, det, vFrq, vAmt,tab,lFrq
  k1        line      0.2, p3, 1
  a1        wgbrass   31129.60, 440, 0.4, 0.1, 6.137, 0.05, 1, 50
            out       a1
endin       

instr       6
            ;;          amp,      frq, hrd, pos,  it, vFrq,vG,  vt, deattack
  a1        vibes     31129.60, 440, 0.5, 0.561, 2, 4.0, 0.2, 1, 0.1
            out       a1
endin 

instr       7
            ;;          amp,      frq, hrd, pos,  it, vFrq,vG,  vt
  a1        agogobel  31129.60, 440, p4, 0.561, 3, 6.0, 0.3, 1
            out       a1
endin 

instr       8
;;                      kamp, kfreq, kbeans, kdamp, ktimes[, idecay]
  a1        shaker    31129.60, 440, 8, 0.999, 100, 0
            out       a1
endin       

instr       9
            ;;          amp,    freq, c1,c2,vDep,vRate, tables... 
  a1        fmbell    31129.60, 440, 1, 1.2, 0.2, 6, 1,1,1,1,1
            out       a1
endin       

instr       10
            ;;          amp,    freq, c1,c2,vDep,vRate, tables... 
  a1        fmrhode   31129.60, 440, 1, 1.2, 0.2, 12, 1,1,1,4,1
            out       a1
endin       

instr       11
            ;;          amp,    freq, c1,c2,vDep,vRate, tables... 
  a1        fmwurlie  31129.60, 440, 1, 1.2, 0.2, 8, 1,1,1,4,1
            out       a1
endin 
      
instr       12
            ;;          amp,    freq, c1,c2,vDep,vRate, tables... 
  a1        fmmetal   31129.60, 110, 1, 1.2, 0.2, 5.5, 1,5,5,1,1
            out       a1
endin       
      
instr       13
            ;;          amp,    freq, c1,c2,vDep,vRate, tables... 
  a1        fmb3      31129.60, 440, 1, 1.2, 0.2, 8, 1,1,1,1,1
            out       a1
endin       

instr       14
  k1        line      0, p3, 64
  a1        fmvoice   31129.60, 110, k1, 0, 0.005, 6, 1,1,1,1,1
            out       a1
endin                   

instr       15
  a1        fmpercfl  31129.60, 440, 0.1, 0.1, 0.5, 12, 1,1,1,1,1
            out       a1
endin                   

instr       16
  a1        moog      31129.60, 440, 0.85, 0.0001, 0.6, 8, 6,7,1
            out       a1
endin

instr       18
  a1        mandol    31129.60, 440, 0.4, 0.995, p4, 1, 6
            out       a1
endin

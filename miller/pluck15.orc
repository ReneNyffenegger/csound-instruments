;PLUCK15.ORC
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

 
instr          1                                       ;RING
  k1        expseg    p4,p3*.8,p4,p3*.2,p4*.01
  k2        randi     1.05,2
;a1            pluck     p5*10000,cpspch(p4+k2),cpspch(p4),3,1,0,0    ;JUST FOR MIDI PURPOSES
  a1        pluck     p5*10000,cpspch(p4),cpspch(p4),3,1,0,0
            out       a1
endin

instr          3                                       ;RING
  k1        expseg    p4,p3*.8,p4,p3*.2,p4*.001
  k2        linseg    cpspch(p5)*p6,p3*.7,cpspch(p5)*p6,p3*.3,cpspch(p5)*(p6*1.1)
  a1        pluck     k1,k2,cpspch(p5),p7,1,0,0   ;P7 = F# WAS 3 FOR THE BEST ONE
            out       a1
endin


instr          4                                       ; PAN RING
  k1        expseg    p4,p3*.8,p4,p3*.2,p4*.001
  k2        linseg    cpspch(p5),p3,cpspch(p5)*1.12
  a1        pluck     k1,k2,cpspch(p5),3,1,0,0
            out       a1
endin





instr          2                                       ;TRY LONG PERF
  k2        expseg    cpspch(p5),p3,cpspch(p5)*p6
  a1        pluck     p4,k2,1,3,1,0,0             ;
            out       a1
endin




instr          5                                       ;TRY LONG PERF
  i1        =  cpspch(p5)
  k1        expseg    i1*p7,p3*.3,i1*p6,p3*.3,i1*(p6*1.1),p3*.3,i1*(p6*.98),p3*.1,i1*p6
  k2        expseg    p4*.01,p3*.2,p4,p3*.6,p4,p3*.2,p4*.01
  a1        pluck     p4,k1,cpspch(p5),3,1,0,0    ;
            out       a1
endin


instr          6                                       ;TRY LONG PERF
  k1        expseg    1,p3,10
  a1        pluck     p4,k1,cpspch(p5),3,1,0,0    ;
            out       a1
endin


;instr         1                                       ;BEST ?
;a1            pluck     p4,p5,p6,3,1,0,0              ;TRY   P4,1,1,FOR GOOD 1CYCLE THRU
;out           a1
;endin


;instr         2
;a1            pluck     p4,p5,p6,2,1,0,0
;              out       a1
;endin

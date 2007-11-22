;timbre1.orc
      
  sr        =  44100
  kr        =  2100
  ksmps     =  21
  nchnls    =  2

instr       1
  ga1       init      0

;RELATIVE FORMANT STRENGTHS
  k14       linseg    2.78 ,p3*.4 ,2.78 ,p3*.1 ,1 ,p3*.1 ,2.78 ,p3*.4 ,2.78 
  k15       linseg    1.37 ,p3*.4 ,1.37 ,p3*.1 ,1 ,p3*.1 ,1.37 ,p3*.4 ,1.37
  k16       linseg    .7 ,p3*.4 ,.7 ,p3*.1 ,1 ,p3*.1 ,.7 ,p3*.4 ,.7
  k17       linseg    .78 ,p3*.4 ,.78 ,p3*.1 ,1 ,p3*.1 ,.78 ,p3*.4 ,.78
  k18       linseg    .18 ,p3*.4 ,.18 ,p3*.1 ,1 ,p3*.1 ,.18 ,p3*.4 ,.18
  k19       linseg    .1 ,p3*.4 ,.1 ,p3*.1 ,1 ,p3*.1 ,.1 ,p3*.4 ,.1

;DISSOLVE/REFORM: FUNDAMENTALFREQs
  a20       expseg    1 ,p3*.1 ,1.05 ,p3*.3 ,3.04 ,p3*.1 ,.04 ,p3*.3 ,2.96 ,p3*.2 ,3
  a21       expseg    1 ,p3*.1 ,.95 ,p3*.3 ,.0613 ,p3*.1 ,.041 ,p3*.3 ,2.93 ,p3*.2 ,3
  a22       linseg    1 ,p3*.1 ,.93 ,p3*.3 ,.0707 ,p3*.1 ,.0377 ,p3*.3 ,2.93 ,p3*.2 ,3
  a23       expseg    1 ,p3*.1 ,1.07 ,p3*.3 ,4.13 ,p3*.1 ,.0403 ,p3*.3 ,2.98 ,p3*.2 ,3
  a24       expseg    1 ,p3*.1 ,.93 ,p3*.3 ,.0117 ,p3*.1 ,.0399 ,p3*.3 ,2.95 ,p3*.2 ,3
  a25       linseg    1 ,p3*.1 ,.96 ,p3*.3 ,.07 ,p3*.1 ,.0402 ,p3*.3 ,1.91 ,p3*.2 ,2

  a30       expseg    1 ,p3*.01 ,1 ,p3*.6 ,.4 ,p3*.3 ,1 ,p3*.09 ,1 ;FORMANT FREQS
  a31       expseg    1 ,p3*.01 ,1 ,p3*.68 ,1.6 ,p3*.3 ,1 ,p3*.09 ,1
  a32       expseg    1 ,p3*.05 ,1 ,p3*.6 ,.7 ,p3*.2 ,2 ,p3*.04 ,1 ,p3*.11 ,1
  a33       expseg    1 ,p3*.05 ,1 ,p3*.6 ,1.3 ,p3*.2 ,2 ,p3*.04 ,1 ,p3*.11 ,1
  a34       expseg    1 ,p3*.05 ,1 ,p3*.6 ,.1 ,p3*.2 ,2 ,p3*.04 ,1 ,p3*.11 ,1
  a35       expseg    1,p3*.05 ,1 ,p3*.6 ,2.4 ,p3*.2 ,2 ,p3*.04 ,1 ,p3*.11 ,1

  k40       linseg    0 ,p3*.7 ,0 ,p3*.2 ,1 ,p3*.1 ,1 ;OCTAVIATION
;FORMANT FUNCTIONS
  k1        =  0.5/(k14+k15+k16+k17+k18+k19)                           

  a1        linseg    0 , p3*.01 ,p4 ,p3*.29 ,p4 ,p3*.1 ,p4*2.5 ,p3*.3 ,p4*2.5 ,p3*.1 ,p4 ,p3*.15 ,p4 ,p3*.05 ,0 ;ENV
;RANDOM VARIATIONS OF FUNDAMENTAL
  a2        randi     .01*.5   ,1/.05             ;FUNDAMENTAL FREQUENCY JITTER
  a3        randi     .01*.5   ,1/.1111   
  a4        randi     .01*.5   ,1/1.2186 
  a5        =  cpspch(p5) * (1+a2+a3+a4)          ;ADJUSTED FUND. FREQUENCY
;FOF UNIT-GENERATORS
;               amp  fund    fma          oct  band tex   debat atten olps fa..b dur
  a9        fof       k14 ,a5*a20 ,609*a30     ,k40  ,77  ,.003 ,.01 ,.007 ,20 ,1  ,2 ,p3
  a10       fof       k15 ,a5*a21 ,1000*a31    ,k40  ,88  ,.003 ,.01 ,.007 ,20 ,1  ,2 ,p3 
  a11       fof       k16 ,a5*a22 ,2450*a32    ,k40  ,122 ,.003 ,.01 ,.007 ,20 ,1  ,2 ,p3 
  a12       fof       k17 ,a5*a23 ,2700*a33    ,k40  ,127 ,.003 ,.01 ,.007 ,20 ,1  ,2 ,p3
  a13       fof       k18 ,a5*a24 ,3240*a34    ,k40  ,137 ,.003 ,.01 ,.007 ,20 ,1  ,2 ,p3
  a14       fof       k19 ,a5*a25 ,80*a35  ,k40  ,137 ,.003 ,.01 ,.007 ,20 ,1  ,2 ,p3
;PANNING
  k41       linseg    1,p3*.75 ,1 ,p3*.2 ,0 ,p3*.05 ,0 ;panning (all L, split, all R)
  k42       linseg    1 ,p3*.05 ,1 ,p3*.2 ,0 ,p3*.75 ,0
;SUMMATION OF FORMANTS AND OUTPUT
  a8        =  (a9+a11+a13)*k1*a1*.75
  a7        =  (a10+a12+a14)*k1*a1*.75
  ga1       =  a7*k41+a8*k42
  ga2       =  a7*(1-k41)+a8*(1-k42)
endin

instr   2
  a1        =  ga1 
  a2        =  ga2
  a3        reverb    a1, 1
  a4        reverb    a2, 1
            outs      a1+a3*.5 ,a2+a4*.5
endin

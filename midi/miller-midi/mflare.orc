;7/25/89
;flare.orc  LOW FM CLAR WITH DYNAMIC INDEX AND FILTER

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

            massign   1,1

instr          1

  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc,0,.5,.01

  k1        expseg    500*.001,5*.05,500,5*.7,500,5*.2,500*.05 ;AMPSEG
                                                                      ;p9=SCALING OF CRESC
  k2        expseg    .5,5*.1,20,5*.9,20          ;INDX SEG
  k3        expseg    100*1.03,5*.05,100,5*.95,100 ;CARRIER SEG
  k4        expseg    200*1.02,5*.05,200,5*.95,200 ;MOD SEG
  k5        expseg    200*1.05,5*.05,200*.95,5*.85,200,5*.1,200*5
  k6        linseg    500,5,500*.1                ;p9=KCF
  k7        linseg    1000*.5,5,1000*2            ;p10=KBW
  a1        foscili   k1,1,knote,200,k2,1,0
  a2        reson     a1,k6,k7,0,0
            outs      (a2*kgate)*.2,(a2*kgate)*.2
endin





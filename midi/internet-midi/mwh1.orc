  nchnls    =  2
  gie0      =  0.00001

            massign   1,1

;***********************************
; SOME WHISTLE INSTRUMENTS
;***********************************


instr     1
    
  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc, 0, .2, .01


; A DESCENDING WHEW...

;kamp          expseg    gie0, p3/10, p4, p3 - p3/10, gie0
  kamp      expseg    gie0, 1/10, 25000, 1 - 1/10, gie0
;kpch          expseg    p5, p3/10, p5+100, p3 - p3/10, p5/4
  kpch      expseg    1500, 1/10, 1500+100, 1 - 1/10, 1500/4 
  anse      rand      kamp
  awhis     reson     anse, kpch, 2, 2
  awhis     reson     anse, kpch+knote, 2, 2

  arevb     reverb    awhis, 1
  arev      =  arevb / 2.3
               ;display  arevb, p3
            display   arevb, 1

  asig      =  (awhis + arev) / 2
;klpan         linseg    1, p3, .5
  klpan     linseg    1, 1, .5
               ;outs     asig * klpan, asig * (1- klpan)
            outs      (asig * klpan)*kgate, (asig * (1 - klpan))*kgate
endin


;*********************************************

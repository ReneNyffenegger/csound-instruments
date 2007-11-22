  nchnls    =  2
  gie0      =  0.00001

            massign   1,1

;***********************************
; SOME WHISTLE INSTRUMENTS
;***********************************

instr     1
    
  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc*12, 0, .2, .01

 
; AN ASCENDING WHIT

;kamp          expseg    gie0, p3/10, p4, p3 - p3/10, gie0
  kamp      expseg    gie0, 3/10, 25000, 3 - 3/10, gie0
;kpch          expseg    p5, p3/10, p5-100,p3 - p3/10, p5*4
  kpch      expseg    3000, 3/10, 3000-100, 3 - 3/10, 3000*4
  anse      rand      kamp
;awhis         reson     anse, kpch, 2, 2
  awhis     reson     anse, kpch+knote, 2, 2

  arevb     reverb    awhis, 1
  arev      =  arevb / 2.3
               ;display  arevb, p3
            display   arevb, .5

  asig      =  (awhis + arev) / 2
;klpan         linseg    0, p3, .5
  klpan     linseg    0, .5, .5
               ;outs     asig * klpan, asig * (1- klpan)
            outs      (asig * klpan)*kgate, (asig * (1- klpan))*kgate
endin


;************************************

  nchnls    =  2
  gimaxamp  =  32000

               ;massign  1,1

;************************************************************************

instr     1
;
; THE WIND -- FROM FAR, DISTANT LANDS ACROSS THE SEA
;         DOWN MOUNTAINS, THROUGH TREES...
;


  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc*12, 0, .2, .01

;p3            =         duration
;p4            =         amplitude (1 = full-volume)
;p5            =         basic wind frequency register (cps)
;


;kdist         expon     1000, p3, 1
  kdist     expon     1000, 5, 1
;kfswp         expon     20000, p3, p5
  kfswp     expon     20000, 5, 10000
;aran          randi     p4, p5
  aran      randi     1, knote
  awind     tone      aran, kfswp

  arevb     reverb    awind, 1
               ;display  arevb, p3
            display   arevb, 5
  arev      =  arevb / 9

; DISTANCE CUE
  kdryamt   =  1 / kdist
  krevamt   =  1/ sqrt(kdist)

  asig      =  (awind * kdryamt) + (arev * krevamt) * gimaxamp

; PANNING
;kpwrl         linseg    .4, p3, 0
  kpwrl     linseg    .4, 5, 0
  alsig     =  asig * iveloc
  arsig     =  asig * (1 - iveloc)
            outs      alsig*kgate ,arsig*kgate
endin


instr          1                        ; SOPRANO
  itab      =  2                                  ; SAPRANO TABLE VALUES
  iattack   =  .4
  irelease  =  .2 
  iatdec    =  .01
  ifund     cpsmidi   
  iamp      ampmidi   4000, 27
  inumh     =  sr/2/ifund                         ; CREATES A BANDLIMITED PULSE
  ifun      =  1
  icutoff   =  ifund 
;********************
;****BORROWED VIBRATO*****
; COMPUTE VIBRATO PARAMETERS:
  ilog2pch  =  log(ifund)/log(2)     
  ivibwth   =  .002*ilog2pch                      ;RELATE WIDTH TO FUND PCH
  ivibhz    =  5                                  ;FROM 5 TO 6.5 HZ AVERAGE
  irandhz   =  125                                ;FROM MORRILL TRUMPET DESIGN
  iportdev  =  .05                                ; "   "       "      "
  iportfn   =  2
;************************* PERFORMANCE...
; VIBRATO
  krand     randi     ivibwth,irandhz
  kvibwth   linenr    ivibwth,.6,.1 , .01         ;GATE VIBRATO WIDTH
  kport     oscil1    0,iportdev,.2,iportfn       ;INITIAL PORTAMENTO
  kv        oscili    kvibwth,ivibhz,1            ;FN1 = SINE
  kvib      =  1+kv+kport+krand                   ;VIBRATO FACTOR ALWAYS CA 1
;********************
;********************
      ;VIBRATO-    **I KNOW THIS STILL NEEDS WORK!*****
; idur         =         2
;kvibrate      randh        1,1                   ;RANDOMIZE RATE FROM 4 TO 6 HZ 
;iv1           =         ifund*.03
;iv2           =         ifund*.04
;iv3           =         ifund*.05
;iv4           =         ifund*.06
; kvibf        linseg    0,idur/4,iv1,idur/4,iv2,idur/4,iv3,idur/4,iv4
; kvib        oscil      kvibf,    (kvibrate + 5), 1 
;********************

;********************
;TABLE ACCESS 
;********************
  icfreqf1  table     0,itab
  icfreqf2  table     1,itab
  icfreqf3  table     2,itab
  icfreqf4  table     3,itab
  icfreqf5  table     4,itab
 
  ibwf1     table     5,itab
  ibwf2     table     6,itab
  ibwf3     table     7,itab
  ibwf4     table     8,itab
  ibwf5     table     9,itab

  iampf1    table     10,itab 
  iampf2    table     11,itab 
  iampf3    table     12,itab 
  iampf4    table     13,itab 
  iampf5    table     14,itab 

               ;print    iampf1, iampf2,iampf3, iampf4, iampf5

  iampf1    =  iampf1 + dbamp(iamp)
  iampf2    =  iampf2 + dbamp(iamp)
  iampf3    =  iampf3 + dbamp(iamp)
  iampf4    =  iampf4 + dbamp(iamp)
  iampf5    =  iampf5 + dbamp(iamp)

               ;print    iampf1, iampf2, iampf3, iampf4, iampf5

  iampf1    =  ampdb(iampf1) + iamp
  iampf2    =  ampdb(iampf2) + iamp
  iampf3    =  ampdb(iampf3) + iamp
  iampf4    =  ampdb(iampf4) + iamp
  iampf5    =  ampdb(iampf5) + iamp

            print     iampf1, iampf2, iampf3, iampf4, iampf5

               ;print    icfreqf1,icfreqf2, icfreqf3, icfreqf4, icfreqf5
 
               ; print   ibwf1, ibwf2, ibwf3, ibwf4, ibwf5
 
  
;**********************                  
  kamp      linenr    iampf1, iattack,    irelease, iatdec
  asig      buzz      1, ifund+kvib, inumh, ifun 
  asig2     reson     asig, icfreqf1, ibwf1
  afltsigout   tone   asig2, icutoff
  asigf1    =  kamp * afltsigout
;**********************
  kamp      linenr    iampf1, iattack,    irelease, iatdec
  asig      buzz      1, ifund+kvib, inumh, ifun 
  asig2     reson     asig, icfreqf2, ibwf2
  afltsigout   tone   asig2, icutoff
  asigf2    =  kamp * afltsigout
;**********************
  kamp      linenr    iampf1, iattack,    irelease, iatdec
  asig      buzz      1, ifund+kvib, inumh, ifun 
  asig2     reson     asig, icfreqf3, ibwf3
  afltsigout   tone   asig2, icutoff
  asigf3    =  kamp * afltsigout
;**********************
  kamp      linenr    iampf1, iattack,    irelease, iatdec
  asig      buzz      1, ifund+kvib, inumh, ifun 
  asig2     reson     asig, icfreqf4, ibwf4
  afltsigout   tone   asig2, icutoff
  asigf4    =  kamp * afltsigout
;**********************
  kamp      linenr    iampf1, iattack,    irelease, iatdec
  asig      buzz      1, ifund+kvib, inumh, ifun 
  asig2     reson     asig, icfreqf5, ibwf5
  afltsigout   tone   asig2, icutoff
  asigf5    =  kamp * afltsigout
;**********************

  asigt     =  asigf1 + asigf2 + asigf3 + asigf4 + asigf5

;**********************

            out       asigt

     
endin   

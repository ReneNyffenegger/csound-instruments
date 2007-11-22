  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1
;=======================================================================;
; CRICKETS        Repeating Note Orchestra                              ;
;                 Designed by Garth Molyneux                            ;
;                 University of Texas at Austin Computer Music Studio   ;
;=======================================================================;
; p6     =        bandwidth for fixed resons                            ;
;=======================================================================; 
instr        1            
  iamp      =  p4                       
  icps      =  cpspch(p5)
  icps1     =  icps*1.1649432                     ; CENTER FREQUENCIES FOR...
  icps2     =  icps1*1.1649432                    ; ...BANK OF FILTERS
  icps3     =  icps2*1.1649432

  arnd      rand      iamp,-1                     ; WHITE NOISE
  aflt1     reson     arnd,icps1,p6,1             ; BANK OF FILTERS
  aflt2     reson     aflt1,icps2,p6,0
  aflt3     reson     aflt2,icps3,p6,0
  afltbk    balance   aflt3,arnd                  ; RESCALE THE OUTPUT

  kcf1      oscil1    0,icps,p3,5                 ; VARY THE CENTER FREQ...
  kcfval    =  icps+kcf1
  kbw1      oscil1    0,p6,p3,5                   ; ...AND THE BANDWIDTH
  kbwval    =  icps+kbw1
  aflt4     reson     afltbk,kcfval,kbwval,0      ; ON THIS LAST FILTER...
  abal      balance   aflt4,arnd                  ; ...RESCALE IT AGAIN

  idur      =  .01                                ; INIT FOR RAPID REPETITION
  incr      =  16 
  incval    =  100/p3
reset:        
            timout    0,idur,contin               ; TOP OF THE LOOP
  incr      =  incr+incval                        ; INCREMENT COUNTER
  idur      table     incr,2,0,1                  ; ACCESS THE TABLE
            reinit    reset                       ; REINITIALIZE TO ALLOW...
contin:
                                      ; ...TIMOUT TO PLAY AGAIN
  idr       =  idur                         
if        idr <= .005 igoto env                   ; HOW LONG IS idur?
  idr       =  .005                               ; PASS THE SIGNAL OUT...                                        
env:
                                         ; ...ELSE SET DUR TO .005 
  asig      linen     abal,idr*.8,idr,idr*.2      ; DYNAMIC ENV FOR EACH iter  
            rireturn                              ; RETURN TO TOP OF LOOP
            out       asig                        
endin

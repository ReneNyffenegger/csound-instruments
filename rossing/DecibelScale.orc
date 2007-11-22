
;**************************************   THE DECIBEL SCALE   *************************************

; IN THIS DEMONSTRATION, WE HEAR BROADBAND NOISE REDUCED IN STEPS OF 6, 3, AND 1DB IN ORDER TO OB-
; TAIN A FEELING FOR THE DECIBEL SCALE.
; BROADBAND NOISE IS REDUCED IN 10 STEPS OF 6 DECIBELS. THEN BROADBAND NOISE IS REDUCED IN 15 STEPS
; OF 3 DECIBELS. AND FINALLY, BROADBAND NOISE IS REDUCED IN STEPS OF 1 DECIBEL.
;***************************************   HEADER   **************************************************



  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

instr         1

  iamp      =  ampdb(p4)                          ;P4 = AMPLITUDE IN DB


  k1        linen     iamp,.01,p3,.01
  anoise    randi     k1, .998 * 10010            ;BROADBAND NOISE 20 - 20KHZ
  asig      oscil     anoise,anoise,1       
            outs      asig,asig
endin
 

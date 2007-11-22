  nchnls    =  2

instr          1                        ;WAVEGUIDE CLARINET 


;       INIT SECTION

  ipitch    cpsmidi   
  idamp     =  1000                               ;DETERMINES BRIGHTNESS OF CLARINET
  ipmax     =  10                                 ;MAX MOUTH PRESSURE
  ivol      =  1000                               ;BRING TO AUDIBLE LEVEL FACTOR
  apbp      init      0                           ;INIT THE RETURNING PRESSURE WAVE

;       CONTROL SECTION

  apm       linseg    0, p3/2, ipmax, p3/2, 0 
    
  am        =  .01                                ;EMBROCHURE/REED STIFFNESS FACTOR

  krand     rand      1                           ;RANDOM ELEMENT
  krand     port      krand, 1/kr
  apm       =  apm - (krand * ipmax)/10

  kvs       line      0, p3, 1                    ;SIMPLE TIME VARYING VIBRATO
  kpitch    oscil     kvs*50, kvs*5, 3
  kpitch    =  ipitch - kpitch + krand * 50
  agrowl    oscil     apm, 100, 4                 ;GROWLING
  apm       =  apm + agrowl

;       WAVEGUIDE STARTS HERE

; THE UGLY VARIABLE NAMES MEAN:

; apdp:         CLOSED REED PRESSURE DROP
; apbp, apbm:   TRAVELING PRESSURE WAVES
; atr:          REED RESPONCE TO PRESSURE
; abell:        PRESSURE WAVE AT BELL
; arefl:        REFLECTED PRESSURE WAVE AT BELL
; aout:         OUTPUT FROM BELL

  apdp      =  2*apbp - apm
  atr       =  1 - am*(apdp - ipmax)
;atr           reed      apdp, ipmax, am     ;My reed opcode (not used now)
  apbm      =  apm/2 + atr * apdp/2               ;Start from reed

;       MIT CSOUND IMPLEMENTATION (NO VIBRATO AND PITCH BENDS)

  abell     delay     apbm, .5/ipitch             ;GO TO BELL
  arefl     tone      -abell, idamp               ;DAMP/REFLECT ON BELL
  aout      atone     abell, idamp                ;GET OUT OF BELL
  apbp      delay     arefl, .5/ipitch            ;GO BACK TO REED
     
  imax      ampmidi   1, 100
  kgate     linenr    imax, .02, .5, .001


            outs      aout*ivol*kgate, aout*ivol*kgate
endin

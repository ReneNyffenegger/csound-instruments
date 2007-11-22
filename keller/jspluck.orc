;****************************** ORCHESTRA **********************************
; EXAMPLE 2: JAFFE-SMITH ALGORITHM.
; DAMIAN KELLER. MAY 1997.
; KARPLUS-STRONG IMPLEMENTED WITH A TABLE LOOKUP PROCEDURE.
; A TABLE IS READ AND WRITTEN UNTIL THE INSTRUMENT STOPS.
; PITCH AND DECAY CONTROLLED INDEPENDENTLY. ALLPASS FILTER.

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1

; INITIALIZATION.
  ilength   =  40                                 ; LENGTH OF DELAY LINE: PITCH.
  adecay    =  .3                                 ; COEFICIENT OF ALLPASS FILTER: DECAY. (.9 TO .01)
                                   ; SMALL VALUES FOR LONGER DECAY.   

; INDEXING.
  aindex0   phasor    ilength
  aindex    =  aindex0 * ftlen(1)                 ; INDEX TO READ TABLE.
  a1        tablei    (aindex), 1                 ; PREVIOUS SAMPLE.
          
  aindex1   =  aindex + 1     
  a2        tablei    (aindex1), 1                ; PRESENT SAMPLE.
          
; ALLPASS FILTER.        
  a3        =  (adecay * a1 + a2)                 ; ALLPASS FILTER, ADECAY CONTROLS DECAY.
  a4        =  a3 - (adecay * a3)
          
; WRITING TABLE: FT1 WRITTEN TO FT1, GUARD POINT MODE.
            tablew    a4, aindex, 1, 0, 0, 2
               
            out       a4 
endin

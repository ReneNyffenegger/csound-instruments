
;******************   ASYMMETRY OF MASKING BY PULSED TONES   ********************
; A PURE TONE MASKS TONES OF HIGHER FREQUENCY MORE EFFECTIVELY THAN TONES OF LOW-
; FREQUENCY. THIS MAYBE EXPLAINED BY REFERENCE TO THE SIMPLIFIED RESPONSE OF THE
; BASILAR MEMBTRANE FOR TWO PURE TONES A AND B.
; THIS DEMONSTRATION USES TONES OF 1200HZ AND 2000HZ, PRESENTED AS 200MS TONE
; BURSTS SEPARATED BY 100MS. THE TEST TONE, WHICH APPEARS EVERY OTHER PULSE, DE-
; CREASES IN 10 STEPS OF 5DB, EXCEPT THE FIRST STEP WHICH IS 15DB.

                  
                  
;                      MASKER
;    *******  *******  *******  *******
;    *     *  *     *  *     *  *     *   
;*****     ****     ****     ****     *******
;              200MS        100MS



;                   TEST TONE                  
;             *******           *******  
;             *     *           *     *
; *************     *************     *******
;              200MS
              
              
              
;*********************************   HEADER   *********************************           

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

instr         1

  iamp      =  ampdb(p4)               
  k1        linen     iamp,.01,p3,.01
  a1        oscili    k1,p5,1             
            outs      a1,a1
endin  


              


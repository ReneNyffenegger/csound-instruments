
;***************************************    PITCH STREAMING   ****************************************

; IT IS CLEAR THAT WITH REGARD TO HUMAN PERCEPTION WE HAVE THE CAPACITY TO PERCEIVE VISUALLY OR 
; AUDITORILY IN A HOLOSTIC OR ISOLATIVE WAY. IN RESPECT TO ONES AUDITORY SYSTEM WE MAY EITHER LIS-
; TO MELODIES IN WHICH THE SEQUENCES OF TONES FORM COHERENT PATTERNS. THIS AUDITORY RESPONSE IS 
; CALLED TEMPORAL COHERENCE. WHEN TONES DO NOT FORM PATTERNS, BUT SEEM ISOLATED, THAT IS CALLED 
; FISSION.
; SINE WAVES WILL BE PRESENTED TO THE LISTENER(S) IN A SEQUENCE ABA ABA. TONE (A) WILL HAVE A FIXED
; FREQUENCY IN EACH PATTERN, WHILE TONE (B) WILL VARY ITS FREQUENCY FROM 1000HZ TO 4000HZ AND BACK
; AGAIN TO 1000HZ. NEAR THE CROSSOVER POINTS, THE TONES APPEAR TO FORM A COHERENCE PATTERN, CHARATER-
; IZED BY A GALLOPING RHYRHM, BUT AT LARGE INTERVALS THE TONES SEEM ISOLATED, ILLUSTRATING FISSION.


;******************************************   HEADER   *********************************************
 
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr         1

  iamp      =  ampdb(p4)               
  k1        linen     iamp,.01,p3,.01
  a1        oscili    k1,p5,1             
            out       a1
endin  

instr         2
 
  iamp      =  ampdb(p4)
  k1        linen     iamp,.01,p3,.01
  a1        oscil     k1,2000,1
            out       a1
endin 

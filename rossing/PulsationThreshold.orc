
;*************************************   PULSATION THRESHOLD   **************************************

; PERCEPTION IS AN INTERPRETIVE PROCESS. OCACASIONALLY, SUCH INTERPRETIVE PROCESSES CAN BE FOOLED.
; THIS CAN BE DEMONSTRATED AUDITORILY BY ALTERNATING A SINUSOIDAL SIGNAL WITH BURSTS OF NOISE. WHE-
; THER THE SIGNAL IS PERCEIVED AS PULSATING OR CONTINUOS DEPENDS UPON THE RELATIVE INTENSITIES OF
; THE SIGNAL AND NOISE.
; IN THIS DEMONSTRATION, 125MS BURSTS OF A 2000HZ TONE ALTERNATE WITH 125MS BURSTS OF NOISE. THE 
; NOISE LEVEL REMAINS CONSTANT, WHILE THE TONE LEVEL DECREASES IN 15 STEPS OF -1DB AFTER EACH 4
; TONES.

;******************************************      HEADER **********************************************

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1
instr          1

  iamp      =  ampdb(p4)                           
 
  k1        linen     iamp,.02,p3,.02    
  a1        oscili    k1,2000,1                 
            out       a1
endin  



instr          2
 
  iamp      =  ampdb(p4)
  ifc       =  p5
 
  k1        linen     iamp,.02,p3,.02
  anoise    randi     k1, .25 * ifc               ; NOISE WITH A BANDWIDTH FROM 1500HZ - 2500HZ
  a1        oscil     anoise, ifc, 1
            out       a1
endin


;******************   INFLUENCE OF MASKING NOISE ON PITCH   *******************
; THE PITCH OF A TONE IS INFLUENCED  BY THE PRESENCE OF MASKING NOISE OR ANOTH-
; ER TONE NEAR TO IT IN FREQUENCY. IF THE INTERFERING TONE HAS A LOWER FREQUENCY
; AN UPWARD SHIFT IN THE TEST TONE IS ALWAYS OBSERVED. IF THE INYTERFERING TONE
; HAS A HIGHER FREQUENCY, A DOWNWARD SHIFT IS OBSERVED, AT LEAST AT LOW FRE-
; QUENCY (< 300HZ). SIMILARLY, A BAND OF INTERFERING NOISE PRODUCES AN UPWARD
; SHIFT IN A TEST TONE IF THE FREQUENCY OF THE NOISE IS LOWER.
; IN THIS DEMONSTRATION, A 1000HZ TONE, 500MS IN DURATION AND PARTIALLY MASKED
; BY NOISE LOW-PASS FILTERED AT 900HZ, ALTERNATES WITH AN IDENTICAL TONE, PRE-
; SENTED WITHOUT MASKING NOISE. THE TONE PARTIALLY MASKED BY NOISE OF LOWER FRE-
; QUENCY APPEARS SLIGHTLY HIGHER IN PITCH (DO YOU AGREE?). WHEN THE NOISE IS
; TURNED OFF, IT IS CLEAR THAT THE TWO TONES WERE IDENTICAL.

;*****************************   HEADER   *************************************


  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

 
instr         1

  iamp      =  ampdb(p4)                          ;P4 = AMPLITUDE IN DB 
  ifreq     =  p5                                 ;P5 = FREQUENCY
 
  k1        linen     iamp,.01,p3,.01         
  a1        oscili    k1,ifreq,1             
            outs      a1,a1
endin  

 
 
instr         2
 
  iamp      =  ampdb(p4)                          ;P4 = AMPLITUDE IN DB
  ifc       =  p5                                 ;P5 = FREQUENCY


  k1        linen     iamp,.01,p3,.01
  anoise    randi     k1, .5 * ifc                ; NOISE WITH A BANDWIDTH FROM 400HZ - 1200HZ
  a1        oscil     anoise, ifc, 1
            outs      a1,a1
endin
 

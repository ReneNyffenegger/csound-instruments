
;*******************************    BACKWARD AND FORWARD MASKING   *********************************

; MASKING CAN OCCUR EVEN WHEN THE TONE AND THE MASKER ARE NOT SIMULTANEOUS. FORWARD MASKING REFERS
; TO THE MASKING OF A TONE BY A SOUND THAT ENDS A SHORT TIME (UP TO ABOUT 10 OR 30 MS) BEFORE THE
; TONE BEGINS. FORWARD MASKING SUGGESTS THAT RECENTY STIMULATED SENSORS ARE NOT AS SENSITIVE AS FULLY
; RESTED SENSORS. BACKWARD MASKING REFERS TO THE MASKING OF A TONE BY A SOUND THAT BEGINS A FEW MIL-
; LISECONDS AFTER THE TONE HAS ENDED. A TONE CAN BE MASKED BY NOISE THAT BEGINS UP TO 10MS LATER, AL-
; THOUGH THE AMOUNT OF MASKING DECREASES AS THE TIME INTERVAL INCREASES. BACKWARD MASKING APPARENTLY
; OCCURS AT HIGHER CENTERS OF PROCESSING IN THE NERVOUS SYSTEM WHERE THE NEURAL CORRELATES OF THE
; LATER-OCCURING STIMULUS OF GREATER INTENSITY OVERTAKE AND INTERFERE WITH THOSE OF THE WEAKER STI-
; MULUS.
; A 10 MS SINUSOIDAL TONE OF 2000HZ WILL BE PRESENTED TO THE LISTENER(S) IN 10 DECREASING STEPS OF 
; -4DB WITHOUT A MASKER. NEXT THE 2000HZ SIGNAL IS FOLLOWED AFTER A TIME GAP (T) BY 250MS BURSTS OF
; NOISE (1900 - 2100). THE TIME GAP (T) IS SUCCESSIVELY 100MS, 20MS, AND 0. 

;****************************************   HEADER   ************************************************




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


  k1        linen     iamp,.02,p3,.02
  anoise    randi     k1, .2 * ifc                ; NOISE WITH A BANDWIDTH FROM 1600HZ - 2400HZ
  a1        oscil     anoise, ifc, 1
            outs      a1,a1
endin
 
 
 
 
 
 
 

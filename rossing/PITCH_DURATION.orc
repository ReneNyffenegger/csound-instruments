
;*************************************    PITCH AND DURATION     ***********************************

; SINE WAVES WILL BE PRESENTED AT 3 DIFFERENT FREQUENCIES TO THE LISTENER(S) IN ORDER TO ILLUSTRATE
; THE RELATIONSHIP BETWEEN PITCH SALIENCE AND DURATION. THE FREQUENCIES ARE AS FOLLOWS: 300HZ,
; 1000HZ, AND 3000HZ. EACH TONE WILL BE PRESENTED IN BURSTS OF 1, 2, 4, 8, 16, 32, 64, AND 128 PER-
; IODS. YOU SHOULD PERCEIVE A CHANGE FROM A CLICK TO A TONE.


;******************************************   HEADER   *********************************************

 
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1 
 
 
instr         1
 
  idel      =  p6                                 ;P4 = AMPLITUDE IN DB                                   
  irel      =  p7                                 ;P5 = FREQUENCY
  isus      =  p3 - (idel + irel)                 ;P6 = ATTACK OF ENVELOPE
  iamp      =  ampdb(p4)                          ;P7 = RELEASE OF ENVELOPE
 
  k1        linen     iamp,p6,p3,p7    
  a1        oscili    k1,p5,1             
            out       a1
endin  
 

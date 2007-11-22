
;*****************************   MASKING SPECTRAL AND VIRTUAL PITCH   **************************

; THIS DEMONSTRATION USES MASKING NOISE OF HIGH AND LOW FREQUENCY TO MASK OUT, ALTERNATELY, A 
; MELODY CARRIED BY SINGLE PURE TONES OF LOW FREQUENCY AND THE SAME MELODY RESULTING FROM THE 
; VIRTUAL PITCH FROM GROUPS OF THREE TONES OF HIGH FREQUENCY (4TH, 5TH AND 6TH HARMONICS). THE 
; INABILITY OF THE LOW-FREQUENCY NOISE TO MASK THE VIRTUAL PITCH IN THE SAME RANGE POINTS OUT THE
; INADEQUENCY OF THE PLACE THEORY OF PITCH.
; YOU WILL HEAR THE FAMILIAR WESTMINISTER CHIME MELODY PLAYED WITH PAIRS OF TONES. THE FIRST TONE
; OF EACH PAIR IS A SINUSOID, THE SECOND A COMPLEX TONE OF THE SAME PITCH. THEN YOU WILL HEAR THE 
; PURE TONE NOTES MASKED WITH A LOW-PASS NOISE. YOU WILL WILL STILL HEAR THE PITCHES OF THE COMPLEX 
; TONES. LASTLY THE COMPLEX TONES IS MASKED BY HIGH-PASS NOISE. THE PURE TONE MELODY IS STILL HEARD.


;*****************************************   HEADER   **********************************************



  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1
instr         1

  iamp      =  ampdb(p4)               
  ifunc     =  p6
 
  k1        linen     iamp,.02,p3,.02         
  a1        oscili    k1,p5,ifunc             
            out       a1
endin  
 
 
 
instr         2 
 
  iamp      =  ampdb(p4)
  ifc       =  p5                                 ; CENTER FREQUENCY


  k1        linen     iamp,.02,p3,.02
  anoise    randi     k1, .38 * ifc               ; NOISE WITH A BANDWIDTH FROM 182.9HZ - 407.1HZ
  a1        oscil     anoise, ifc, 1
            out       a1
endin
 
 
 
instr         3
 
  iamp      =  ampdb(p4)
  ifc       =  p5                                 ; CENTER FREQUENC   

  k1        linen     iamp,.02,p3,.02
  anoise    randi     k1, .47 * ifc               ; NOISE WITH A BANDWIDTH FROM 731.87HZ - 2029.91HZ
  a1        oscil     anoise, ifc,1
            out       a1 
endin

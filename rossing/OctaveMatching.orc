
;****************************************   OCTAVE MATCHING   ****************************************
; EXPERIMENTS ON OCTAVE MATCHING USUALLY INDICATE A PREFERENCE FOR RATIOS THAT ARE GREATER THAN 2.0. 
; THIS PREFERENCE FOR STRETCHED OCTAVES IS NOT WELL UNDERSTOOD. IT IS ONLY PARTLY RELATED TO OUR EXPER-
; IENCE WITH HEARING STRETCH-TUNED PIANOS. MORE LIKELY, IT IS RELATED TO THE PHENOMENON WE ENCOUNTERED
; IN "INFLUENCE OF MASKING NOISE ON PITCH"., ALTHOUGH IN THAT DEMONSTRATION THE TONES ARE PRESENTED AL-
; TERNATELY RATHER THAN SIMULTANEOUSLY.
; IN THIS DEMONSTRATION, A 500HZ TONE OF ONE SECOND DURATION ALTERNATES WITH ANOTHER TONE THAT VARIES
; FROM 985 TO 1035HZ IN STEPS OF 5HZ. WHICH ONE SOUNDS LIKE A CORRECT OCTAVE? MOST LISTENERS WILL PRO-
; BABLY SELECT A TONE SOMEWHERE AROUND 1010HZ.

;*******************************************   HEADER   **********************************************


  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2 
 
 
instr         1

  iamp      =  ampdb(p4)                          ;P4 = AMPLITUDE IN DB 
  ifreq     =  p5                                 ;P5 = FREQUENCY
 
  k1        linen     iamp,.03,p3,.03         
  a1        oscili    k1,ifreq,1             
            outs      a1,a1
endin  


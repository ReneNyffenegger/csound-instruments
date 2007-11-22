
;*************************************   MASKING LEVEL DIFFERENCES   ***********************************
; BINAURAL HEARING HELPS US TO RECEIVE AUDITORY SIGNALS IN NOISY ENVIRONMENTS. LICKLIDER (1948)
; DISCOVERED THE PHENOMENON CALLED "MASKING LEVEL DIFFERENCE" FOR SPEECH; HIRSH (1948) DEMONSTRATED
; IT FOR SINUSOIDAL SIGNALS, AS IN THE DEMONSTRATION.
; THE FIRST EXAMPLE IN THE DEMONSTRATION BEGINS BY PLAYING A 500HZ SIGNAL OF 100MS DURATION IN THE 
; LEFT EAR. THEN THIS SIGNAL IS MASKED BY NOISE. THE STAIRCASE PROCEDURE IS USED, SO THAT YOU CAN 
; COUNT THE LEVEL AT WHICH THE SIGNAL BECOMES INAUDIBLE. THE STAIRCASE CONTAINS 10 STEPS; THE FIRST
; STEP IS -10DB, AND THE REMAINING 9 STEPS ARE -3DB EACH.
; IN THE THIRD EXAMPLE, NOISE IS ADDED TO THE OTHER EAR. THE NOISE NOW APPEARS TO HAVE A DIFFERENT
; SPATIAL LOCATION (ALBEIT INSIDE THE HEAD) FROM THE SIGNAL, AND THE SIGNAL IS MUCH EASIER TO HEAR. 
; IN THE FOURTH EXAMPLE, THE SIGNAL IS AGAIN MADE DIFFICULT TO HEAR BY ADDING A SIGNAL TO THE NOISE
; IN THE RIGHT EAR, SO THAT THE AUDITORY IMAGES OF THE SIGNAL AND NOISE AGAIN COINCIDE.
; THE FIFTH EXAMPLE DEMONSTRATES THEAT INVERTING THE SIGNAL AT ONE OF THE EARS PLACES THE NOISE AND 
; SIGNAL IN DIFFERENT AUDITORY LOCATIONS. IN THIS CONFIGURATION, THE SIGNAL IS EASY TO HEAR.
; THE SIGNAL, WHICH IS SIMILAR TO NO. 11 IN THE "HARVARD TAPES" CAN BE SUMMARIZED,AS FOLLOWS: 1) S(L)
; 2) S(L)N(L); 3) S(L)N(L,R); 4) S(L,R)N(L,R); 5) S(L)$(R)N(L,R), WHERE S = SIGNAL, $ = SIGNAL OF
; REVERSED PHASE, N = NOISE, L = LEFT, R = RIGHT. THE SIGNAL IS MORE EASILY HEARD IN EXAMPLES 1, 3, 
; AND 5. IN THE ORIGINAL HARVARD TAPES, THE DEMONSTRATION IS REPEATED AT 2000HZ, WHERE THE EFFECT HAS 
; FADED, THUS DEMONSTRATING THE STRONG FREQUENCY DEPENDENCE OF MASKING LEVEL DIFFERENCE (HIRSH, 1948).  
;*****************************************   HEADER   *************************************************


  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2 
 
 
instr         1

  iamp      =  ampdb(p4)                          ;P4 = AMPLITUDE IN DB 
  ifunc     =  p5                                 ;P5 = FUNCTION
                                                            ;P6 = PANNING FUNCTION FOR SIGNAL

  k1        linen     iamp,.02,p3,.02         
  a1        oscili    k1,500,p5        
  k2        oscili    1,p3,p6
  kleft     =  sqrt (k2)
  kright    =  sqrt (1-k2)
  aleft     =  a1 * kleft
  aright    =  a1 * kright
            outs      aleft,aright 
endin  

instr         2     
 
  iamp      =  ampdb(p4)                          ;P4 = AMPLITUDE IN DB 
                                                            ;P5 = PANNING FUNCTION FOR SIGNAL

  k1        linen     iamp,.01,p3,.01
  anoise    randi     k1, .998 * 10010            ;NOISE WITH A BANDWIDTH FROM 20 - 20KHZ
  a1        oscil     anoise,anoise,1
  k2        oscili    1,p3,p5
  kleft     =  sqrt (k2)
  kright    =  sqrt (1-k2)
  aleft     =  a1 * kleft
  aright    =  a1 * kright
            outs      aleft,aright 
endin
 
 
 
 
   

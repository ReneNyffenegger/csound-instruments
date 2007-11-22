; DIFFTONE.ORC (COMPUTER ORCHESTRA FOR GENERATING "DIFFERENCE" TONES)
; BY MARK DAL PORTO

;=========================================================================;
; DIFFERENCE TONES ARE AURAL COMBINATION TONES THAT RESULT WHEN TWO       ; 
; COMBINED FREQUENCIES PRODUCE A LOWER SOUNDING PITCH OR PITCHES.  THIS   ;
; ACOUSTIC PHENOMENA WAS REPORTEDLY DISCOVERED BY THE ITALIAN COMPOSER    ;
; AND VIOLINIST TARTINI AROUND 1714.  THE TWO MOST PROMINENT DIFFERENCE   ;
; TONES ARE THE QUADRATIC DIFFERENCE TONE (UPPER FREQUENCY MINUS LOWER    ;
; FREQUENCY) AND THE CUBIC DIFFERENCE TONE (LOWER FREQUENCY*2 MINUS UPPER ;
; FREQUENCY).  THESE LOWER PITCHES, ALTHOUGH HEARD, ARE NOT ACTUALLY      ;
; PHYSICALLY PRESENT IN THE MUSICAL SPECTRUM.  THEY RESULT BY MEANS OF A  ;
; NON-LINEAR PROCESS THAT TAKES PLACE IN OUR INNER EAR.                   ;
;=========================================================================;

  sr        =  44100                              ; SAMPLE RATE
  kr        =  4410                
  ksmps     =  10
  nchnls    =  1                                  ; NUMBER OF CHANNELS

instr          1 
;-------------------------------------------------------------------------;
; THE FOLLOWING "EXPSEG" CREATES A GLISSANDO FROM C6 TO C7 AND BACK TO C6 ;
;-------------------------------------------------------------------------;
  kgliss    expseg    1046.5, p3*.5, 2093, p3*.5, 1046.5 ;P3=DURATION   

;-------------------------------------------------------------------------;
; THE FOLLOWING "LINEN" IS THE ENVELOPE SHAPE FOR THE NOTES PLAYED        ;
;-------------------------------------------------------------------------; 
  kamp      linen     p4, p3*.025, p3, p3*.05     ;P4=AMP

;-------------------------------------------------------------------------;
; THE FOLLOWING "OSCILI" IS THE DIGITAL OSCILLATOR THAT PLAYS THE         ;
; GLISSANDO                                                               ;
;-------------------------------------------------------------------------;    
  agliss    oscili    kamp, kgliss, 1 
        
;-------------------------------------------------------------------------;
; THE FOLLOWING "OSCILI" IS THE DIGITAL OSCILLATOR THAT PLAYS THE LOWER   ;
; SUSTAINED NOTE OR "PEDAL" TONE (C6)                                     ;
;-------------------------------------------------------------------------;    
  apedal    oscili    kamp, 1046.5, 1
            out       agliss+apedal
endin                         ; END OF INSTRUMENT AND ORCHESTRA

;*************************************************************************;
; DID YOU HEAR THE LOWER SLIDING QUADRATIC AND CUBIC DIFFERENCE TONES     ;
; CREATED BY THESE TWO OSCILLATORS?                                       ;
;*************************************************************************;

; NOTE:  FOR FURTHER INFORMATION ON DIFFERENCE TONES, SEE ROSSING'S
; "THE SCIENCE OF SOUND AND MUSIC" (2ND ED.), PP. 151-152

; TSCST3.ORC  OSCILLATOR WITH 7 COMPONENTS         
;                   (c) Rajmil Fischman, 1997
;----------------------------------------- 
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 3
;--------------------------------------------;PARAMETER LIST
;p4 : OVERALL AMPLITUDE
;p5 : REFERENCE FREQUENCY (FUNDAMENTAL IF SPECTRUM IS HARMONIC)
;p6,p8,p10,p12,p14,p16,p18 : RELATIVE AMPLITUDES OF COMPONENTS
;p7,p9,p11,p13,p15,p17,p19 : RELATIVE FREQUENCIES OF COMPONENTS
;--------------------------------------------------------------     
  kenv      linen     p4,.1,p3,.1                 ; OVERALL ENVELOPE
;--------------------------------------------; COMPONENTS
  a1        oscil     p6,p5*p7,1                  ; 1st COMPONENT
  a2        oscil     p8,p5*p9,1                  ; 2nd COMPONENT
  a3        oscil     p10,p5*p11,1                ; 3rd COMPONENT
  a4        oscil     p12,p5*p13,1                ; 4th COMPONENT
  a5        oscil     p14,p5*p15,1                ; 5th COMPONENT
  a6        oscil     p16,p5*p17,1                ; 6th COMPONENT
  a7        oscil     p18,p5*p19,1                ; 7th COMPONENT
            out       kenv*(a1+a2+a3+a4+a5+a6+a7)/7 ; MIX AND OUTPUT 
endin
                                                                        

; TSCST10.ORC     RING MODULATOR
;                         (c) Rajmil Fischman, 1997
;----------------------------------------- 
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 11                     ; VARIABLE PARAMETER AMPLITUDE MODULATION INSTRUMENT.
                                                ; THE FOLLOWING CAN BE MADE TO CHANGE IN TIME :
                                                ; OVERALL AMPLITUDE, CARRIER FREQUENCY,
                                                ; C/M RATIO, FRACTION OF THE CARRIER TO 
                                                ; BE MODULATED. 
;-------------------------------------------------------; PARAMETER LIST
;p4     : MAX AMPLITUDE
;p5     : HIGHEST CARRIER PITCH
;p6     : MAX CARRIER TO MODULATOR RATIO (C/M)
;p7     : FUNCTION TABLE CONTROLLING AMPLITUDE
;p8     : FUNCTION TABLE CONTROLLING CARRIER PITCH
;p9     : FUNCTION TABLE CONTROLLING C/M RATIO
;p10 : FUNCTION TABLE CONTROLLING MODULATION FRACTION
;---------------------------------------------------------------------- 
  ifr       =  cpspch(p5)                         ; PITCH TO FREQUENCY CONVERSION
;---------------------------------------        ; ENVELOPES
  kamp      oscil1    0,p4,p3,p7                  ; AMPLITUDE
  kcar      oscil1    0,ifr,p3,p8                 ; CARRIER FREQ
  kcmr      oscil1    0,p6,p3,p9                  ; C/M
  kmp       oscil1    0,1,p3,p10                  ; MODULATION FRACTION
;---------------------------------------        ; MODULATION
  acarr     oscili    1, kcar, 10                 ; CARRIER
  amod      oscili    1, kcar/kcmr,11             ; MODULATOR
  aoutm     =  acarr*amod*kmp                     ; MODULATED SIGNAL
  aoutnm    =  acarr*(1-kmp)                      ; UNMODULATED SIGNAL
;---------------------------------------        ; MIX AND OUTPUT
            out       kamp*(aoutm+aoutnm)
endin

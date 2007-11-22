; TUNING.ORC (TUNING ORCHESTRA) BY MARK DAL PORTO

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

;=====================================================================;
; INSTRUMENT 1 CONVERTS EQUAL TEMPERAMENT OCTAVE.PITCH NUMBERS IN THE ;
; (TUNING) SCORE INTO FREQUENCIES (CPS) AND THEN "PLAYS" THEM         ;
;=====================================================================;

instr          1
  kenv      linen     7000, .05, p3, .1           ; SIMPLE ENVELOPE FOR EACH NOTE
  asig      oscili    kenv, cpspch(p4), 5         ; P4=OCTAVE.PITCH CONVERSION TO CPS
            out       asig
endin                                             ; END OF INSTRUMENT

;=====================================================================;
; INSTRUMENT 2 CONVERTS OCTAVE.% NUMBERS IN THE (TUNING) SCORE INTO   ;
; (QUARTER-COMMA) MEANTONE, JUST, & PYTHAGORAN FREQUENCIES AND THEN   ;
; "PLAYS" THEM                                                        ;
;=====================================================================;

instr 2
  kenv      linen     7000, .05, p3, .1           ; SIMPLE ENVELOPE FOR EACH NOTE
  asig      oscili    kenv, cpsoct(p4), 5         ; P4=OCTAVE.% CONVERSION TO CPS
            out       asig
endin                                             ; END OF INSTRUMENT AND ORCHESTRA

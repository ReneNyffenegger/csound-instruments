  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 209       
  idur      =  p3  
  iamp      =  p4          
  irow      =  12/idur                            ; 12 NOTES PER NOTE DURATION
  irowrep   =  p5*irow                            ; NUMBER OF TIMES TO REPEAT THE ROW
  iseed     =  p6                                 ; SEED 0-1, SAME SEED = SAME RANDOM SEQ
  kenv      oscil     iamp, irowrep, 10           ; f10 = ENVELOPE FUNCTION
  kcnt1     phasor    1/idur                      ; COUNTS 0-1 OVER NOTE DURATION
  kcnt2     =  kcnt1*12                           ; COUNTS 0-12 OVER NOTE DURATION
  kpc       table     kcnt2, 38                   ; f38 = ROW
  krn       randh     6, irowrep, iseed           ; DETERMINES RANDOM VALUE
  koct      =  (abs(int(krn)))+5                  ; CONVERTS TO RANDOM OCTAVE
  kpch      =  koct+(kpc*.01)                     ; FORMATS PC + RANDOM OCT TO PCH
  kcps      =  cpspch(kpch)                       ; CONVERTS PCH TO CPS
  asig      oscil     kenv, kcps, 4               ; f4 = SQUARE WAVE
            out       asig    
endin       

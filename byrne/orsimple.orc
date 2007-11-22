; ORSIMPLE.ORC  
; CREATED  BY PER BYRNE VILLEZ  1997  hbyrne@pavilion.co.uk

  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  2

instr 1

; THICKeNER  SECONDARY FUNDAMENTALS FOR a1    
  kfund1    linseg    p4, p3*.5, p4, p3*.5, p4
  kfund2    linseg    p4, p3*.5,  p4, p3*.5, p4   ; DITTO FOr a2

; GRAIN AMPLITUDE ENVELOPES
  kdur      linseg    1, p3*.02, 1, p3*.02, .5, p3*.96, 1
  kdec      linseg    1, p3*.02, 1, p3*.02, .5, p3*.96, 1

; OVERALL AMPLITUDE  ENVELOPE
  kenv      linseg    3500, p3*.02, 3500, p3*.02, 3500, p3*.96, 3500

; CHANGE FORMANT    FREQUENCY OF a1
  ktwist    linseg    1, p3*.4, 1.1,  p3*.6, 1

; CHANGE  FORMANT   FREQUENCY OF a2
  ktwist2   linseg    1.05, p3*.4, 1.14,  p3*.6, 1.05

  koct      linseg    0, p3*.9, 0, p3*.01, 2, p3*.09, 3 ; OCTIVIATION ENVELOPE

  a1        fof       kenv, kfund1,  ktwist, koct, 0, .003, kdur, kdec, 170, 1, 19, p3,0, 1
  a2        fof       kenv, kfund2,  ktwist2, koct, 0, .003, kdur, kdec, 170, 2, 19, p3,0, 1

            outs      a1, a2
 
endin

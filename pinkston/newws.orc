  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

;=========================================================================;
;                                                                         ;
;               General Purpose Waveshaping Instrument                    ;
;                                                                         ;
;=========================================================================;


instr   1
  iamp      =  p4
  ihertz    =  cpspch(p5)
  iwsfn     =  p6                                 ;waveshaping function
  inormfn   =  p7                                 ;normalization function
  kgate     linen     iamp,.01,p3,.1              ;overall amp envelope
  actrl     linseg    0,p3/2,.99,p3/2,0           ;index control function
  aindex    oscili    actrl/2,ihertz,1            ;indexing oscil
  asignal   tablei    aindex,iwsfn,1,.5           ;waveshaping table with offset
if      (p7 == 0) goto skip                       ;skip over if not normalizing
  anormal   tablei    actrl,inormfn,1             ;amplitude normalization function
  asignal   =  asignal*anormal
skip:
            out       asignal*kgate
endin
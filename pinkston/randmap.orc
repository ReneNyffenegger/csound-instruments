;========================================;
; Constrained Random Pitch Instrument    ;
;                                        ;
; This instrument uses randh to choose   ;
; a random index into a table containing ;
; a set of pitches in PCH format.        ;
; RP                                     ;
;========================================;

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr   1

;init section
  isine     =  1                                  ;sine function in fn1
  iamp      =  p4                                 ;p4 has peak amplitude
  ibase     =  octpch(p5)                         ;base pitch in octave.pch
  irise     =  p6
  idecay    =  p7
  irange    =  .5                                 ;randh range +/- .5
  irandhz   =  p8
  iseed     =  p9                                 ;seed for rand
  ipitfn    =  p10                                ;number of pitch table
;performance section
  krval     randh     irange,irandhz,iseed
            timout    0,p11,skip                  ;optionally, wait before performing
  kindex    =  .5+krval                           ;offset to range of 0-1
  kvaryp    table     kindex,ipitfn,1             ;map rand index onto pitches in table
  koct      =  octpch(kvaryp)                     ;convert table pch value to oct
  kgate     linen     iamp,irise,p3,idecay
  asig      oscili    kgate,cpsoct(ibase+koct),isine
skip:
            out       asig
endin


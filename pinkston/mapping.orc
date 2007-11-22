;========================================================;
; Parameter Mapping Demonstration Instrument             ;
;                                                        ; 
; This instrument maps amplitudes to input MIDI velocity ;
; and pan position to start time using stored functions. ;
; RP                                                     ;
;========================================================;

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

instr   1
;init section
  isine     =  1                                  ;sine function in fn1
  iampfn    =  p9                                 ;select amp mapping fn
  ipanfn    =  3
  iend      =  p8                                 ;end time for pan func
  itime     =  p2/iend
  ivel      =  p4                                 ;p4 has values from 0-127
  iamp      table     ivel,iampfn                 ;map amp to velocity
  ipan      table     itime,ipanfn,1              ;pan position from table
  ipch      =  p5                                 ;octave.pch
  irise     =  p6
  idecay    =  p7
;performance section
  kgate     linen     iamp,irise,p3,idecay
  asig      oscili    kgate,cpspch(ipch),isine
  kleft     =  sqrt(ipan)
  kright    =  sqrt(1-ipan)
            outs      asig*kleft,asig*kright
endin

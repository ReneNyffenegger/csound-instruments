  sr        =  44100
  kr        =  4410
  ksmps     =  10

instr 1
; by Marc Resibois
 ; ------------------------- I-TIME ---------------------

  igain     =  4000
 ; Init constant

  ipi       =  3.141503

 ; Compute the acid factor ( 0..1 )

  iacid     =  (exp(p5)-1)/exp(1) 

 ; Compute the basic pitch

  ipch      =  cpspch(p4)

 ; Compute freqency travelling of fast sine

  ifstart   =  4+100*iacid                        ; starting mult factor
  ifspeed   =  100*iacid                          ; sweep speed (Hz/sec)

 ; ------------------------- K-TIME ---------------------

 ; Global instrument envelope

  kenv      linseg    0,0.02,igain,p3-0.06,igain,0.04,0

 ; Pitch envelope of fast sine ( acid factor dependent)

  kline     line      ifstart,1,ifstart-ifspeed
 
 ; ------------------------- A-TIME ---------------------

 ; Produce a index going from 0->1 at the right pitch

  andx      phasor    ipch

 ; Produce a triagular wave 1->0 at basic pitch

  atri      =  1-andx

 ; Produce a sinwave at basic pitch

  asin1     =  sin(ipi/2*(3*andx+1))

 ; Produce the travelling fast sine

  asin2     =  sin(2*ipi*kline*andx+ipi/2) 

; Produce Output Sound

  aout      =  kenv*(2*asin2*atri-atri-asin1)

 ; Output resulting wave

            out       aout

endin

  sr        =  44100
  kr        =  4410
  ksmps     =  10

instr 10
  gkacid    oscil     .5, .777, 1
endin
instr 1
;      start  Duration  cps   Acidity

 ; ------------------------- I-TIME ---------------------

 ; Init constant

  ipi       =  3.141503
        ; iacid =       (exp(gkacid)-1)/exp(1) 
  ipch      =  cpspch(p4)
        ;ifstart        =       4+100*iacid     ; starting mult factor
        ;ifspeed        =       100*iacid       ; sweep speed (Hz/sec)

  kenv      linseg    0,0.02,8000,p3-0.06,8000,0.04,0
 ; Pitch envelope of fast sine ( acid factor dependent)
            igoto     scumhed
            goto      contin
scumhed:
  iacid     =  (exp(gkacid)-1)/exp(1)
  ifstart   =  4+100*iacid
  ifspeed   =  100*iacid                          ; sweep speed (Hz/sec)
contin: 
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

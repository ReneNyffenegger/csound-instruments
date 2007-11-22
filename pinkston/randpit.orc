;==========================================;
; Random Pitch Instrument                  ;
;                                          ;
; This instrument chooses random pitches   ;
; using the Csound i() function to access  ;
; the most recent output from a rand unit  ;
; and make it available at i-time.  Note   ;
; that on the very first note of the score ;
; that value will always be zero, so it is ;
; necessary to generate a value using the  ;
; seed, itself. Also note that after the   ;
; first note, the rand seed must be set to ;
; -1 to ensure that the random sequence    ;
; continues for succeeding notes. RP       ;
;==========================================;

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr   1
  iamp      =  p4
  iseed     =  p5
  irndrng   =  36
if      (iseed < 0) igoto continue
  krndval   init      iseed*irndrng
continue:
  krndval   rand      irndrng,iseed
  irndval   =  i(krndval)
  imidinn   =  int(irndval)+irndrng+24            ;midi notes from 24 - 96
  icps      =  cpsoct(3.00+imidinn/12)
  asig      oscili    iamp,icps,1                 ;sine
  asig      linen     asig,.1*p3,p3,.2*p3
            out       asig
endin

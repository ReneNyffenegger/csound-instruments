;Josep Mª Comajuncosas
;Csound Activist
;gelida@lix.intercom.es

;ORC:

  sr        =  44100
  kr        =  44100
  ksmps     =  1
  garev     init      0

;***************************************************************************

instr 1; SPECTRALIZER, a psychoacustic exciter.
; 2nd and 3rd harm equally weighted (stolen from a Wavelab plug-in ;-) )

;***************************************************************************

  imaxamp   =  3000                               ; 32768 max. Imaxamp gives full effect
  ihpfreq   =  p6
  idens     =  p5
  imix      =  .3                                 ;retain 30% of the original signal
  ifreq     =  cpspch(p4)
  aenv      linen     1, .4, p3, .4*p3
  asig      oscili    aenv, ifreq, 3              ; put here your signal normalized

  alpfilt   tone      asig, sr/6                  ; kind of anti-alias ...; <- improve this
  atreble   butterhp  alpfilt , ihpfreq           ; don´t affect freqs below ihpfreq;
;   <-would be better a atone?
  anorm     balance   atreble, asig               ; restitute original power; <-is this the
;  best way to do it?

  awsh      =  anorm*ftlen(2)/2*idens             ;idens further scales the effect
  ahm       tablei    awsh , 2 , 0 , ftlen(2)/2   ; waveshape (split into 2 & 3rd
; harm.)

  aout      balance   (imix*asig + (1-imix)*ahm), asig * imaxamp ; <- what happens
 ; with final amplitude...?
            out       .2*aout
  garev     =  0
  garev     =  garev + aout
endin


;***************************************************************************

instr 2 ;PHASE-MODULATOR, from CLM docs
; very similar to instr 1. I´m not sure where the Phase Modulation is...

;***************************************************************************

  imaxamp   =  3000                               ; 32768 max. Imaxamp gives full effect
  ifreq     =  cpspch(p4)
  imaxmod   =  p5                                 ; keep this value small

  aenv      linen     1, .4, p3, .4*p3
  afmindx   =  imaxmod * aenv
  asig      oscili    aenv, ifreq, 3              ;put here your signal normalized

  asin1     tablei    asig*ftlen(1)/2 , 1 , 0 , ftlen(1)/2
  amod      =  afmindx * asin1
  asin2     tablei    (.25*asig + amod)*ftlen(1)/2 , 1 , 0 , ftlen(1)/2 ; as long
; as fn1=sin the signal will be aliased...

  aout      balance   asin2 , asig * imaxamp
            out       .2*aout
  garev     =  0
  garev     =  garev + aout
endin

instr 3 ; some reverb
  asig      reverb2   garev , 5, .8
            out       .5 * asig

endin


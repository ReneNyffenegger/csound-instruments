;The following csound orchestra does this using sinusoidal
;variation of pulse width. It would be easy to modify for
;a different control trajectory. It also allows stretching or
;shrinking of harmonics, which is fun.

;Eric Lyon
;eric@cmlab.sfc.keio.ac.jp

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1
          
; implements pulse wave with varying duty cycle
; use raised cosine for this purpose
; USE HIGHER K RATES FOR FASTER TRANSITION SPEEDS
; function 1 is sine
; function 2 is raised cosine
; freq amp speed minpulse harmonic-stretchfactor

; NOTE USE OF LOW K-RATE FOR GRUNGE

instr 1
  ipi       =  3.141593
  istretch  =  p8
  if1       =  p4
  if2       =  if1*2.*istretch
  if3       =  if1*3.*istretch
  if4       =  if1*4.*istretch
  if5       =  if1*5.*istretch
  if6       =  if1*6.*istretch
  if7       =  if1*7.*istretch
  if8       =  if1*8.*istretch
  inumharms =  8
  igain     =  p5 * (32767./inumharms)
  ia1       =  igain
  ia2       =  ia1/2.
  ia3       =  ia1/3.
  ia4       =  ia1/4.
  ia5       =  ia1/5.
  ia6       =  ia1/6.
  ia7       =  ia1/7.
  ia8       =  ia1/8.

  idutyspeed   =      p6
  iminduty  =  p7
  imaxduty  =  .9999
  idutyamp  =  imaxduty-iminduty
; PARAMETERIZE ENVELOPE HERE IF DESIRED
  iatk      =  .1
  idk       =  .2
  isust     =  p3-(iatk+idk)
  kenv      linseg    0,iatk,igain,isust,igain,idk,0
  kduty     oscil     idutyamp, idutyspeed, 2
  kduty     =  (kduty + iminduty)*idutyspeed
  kamp1     =  sin(kduty*ipi)

  kamp2     =  sin(2*kduty*ipi)

  kamp3     =  sin(3*kduty*ipi)

  kamp4     =  sin(4*kduty*ipi)

  kamp5     =  sin(5*kduty*ipi)

  kamp6     =  sin(6*kduty*ipi)

  kamp7     =  sin(7*kduty*ipi)

  kamp8     =  sin(8*kduty*ipi)


  asig1     oscil     kamp1,if1,1
  asig2     oscil     kamp2,if2,1
  asig3     oscil     kamp3,if3,1
  asig4     oscil     kamp4,if4,1
  asig5     oscil     kamp5,if5,1
  asig6     oscil     kamp6,if6,1
  asig7     oscil     kamp7,if7,1
  asig8     oscil     kamp8,if8,1
  asum      =  asig1+asig2+asig3+asig4+asig5+asig6+asig7+asig8
            out       asum * kenv

endin

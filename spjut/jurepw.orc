;-----------------------------------------
;       PWM.ORC
;       luis jure
;       01/1998
;-----------------------------------------
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1
;-----------------------------------------
instr   1               ; PW MODULATED BY ENVELOPE

  ifreq     =  p5
  idur      =  1/ifreq
  isamp     =  1/sr
  krel      line      .9, p3, .5                  ; MOD ENVELOPE (CHANGE THIS TO YOUR TASTE)
  kenv      linseg    0,p3*.1,p4,p3*.7,p4,p3*.2,0 ; AMP ENVELOPE (id.)
cicle:
  ir        =  i(krel)
  ipos      =  idur*ir
  ineg      =  idur-ipos
  a1        linseg    1,ipos,1,isamp,-1,ineg,-1
            timout    0,idur,label
            reinit    cicle
label:
            out       a1*kenv
endin

;-----------------------------------------
instr   2                                               ; PW MODULATED BY LFO

  ifreq     =  p5                                 ; FUNDAMENTAL PITCH
  idur      =  1/ifreq
  isamp     =  1/sr
  idpth     =  p6                                 ; MODULATION DEPTH - VARY BETWEEN 0 (NO MOD) AND .5
  ifr       =  p7                                 ; MODULATION FREQUENCY

  klfo      oscil     idpth,ifr,1     
  krel      =  .5 + klfo
  kenv      linseg    0,p3*.1,p4,p3*.7,p4,p3*.2,0

cycle:
  ir        =  i(krel)
  ipos      =  idur*ir
  ineg      =  idur-ipos
  a1        linseg    1,ipos,1,isamp,-1,ineg,-1
            timout    0,idur,label
            reinit    cycle

label:
            out       a1*kenv
endin

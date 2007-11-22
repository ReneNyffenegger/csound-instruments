  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

  gamixl    init      0                           ;declare and init the global send variables
  gamixr    init      0

;N.B. All the effects instruments must be used in conjunction with instr 100, which
;zeros the global variables after each sample.

instr   1
  igain     =  p4                                 ;initial gain factor
  ifileno   =  p5                                 ;soundin file number
  iwet      =  p6                                 ;proportion of signal to effects
  idry      =  p7                                 ;proportion of signal output dry
  iskip     =  p8                                 ;optional skip time in file

  al,ar     soundin   ifileno,iskip
  al        =  al * igain                         ;adjust initial gains   
  ar        =  ar * igain
  gamixl    =  gamixl + al * iwet                 ;proportions to effects
  gamixr    =  gamixr + ar * iwet
            outs      al * idry, ar * idry        ;proportions straight out
endin

instr   90      ;straight comb
  igain     =  p4                                 ;overall gain factor
  irvt      =  p5                                 ;reverb time
  ilpt      =  p6                                 ;loop time (delay)
  aleft     comb      gamixl,irvt,ilpt
  aright    comb      gamixr,irvt,ilpt
            outs      aleft*igain,aright*igain
endin

instr   91      ;straight alpass
  igain     =  p4                                 ;overall gain factor
  irvt      =  p5                                 ;reverb time
  ilpt      =  p6                                 ;loop time (delay)
  aleft     alpass    gamixl,irvt,ilpt
  aright    alpass    gamixr,irvt,ilpt
            outs      aleft*igain,aright*igain
endin

instr   92      ;straight csound reverb
  igain     =  p4                                 ;overall gain factor
  irvt      =  p5                                 ;reverb time
  aleft     reverb    gamixl,irvt
  aright    reverb    gamixr,irvt
            outs      aleft*igain,aright*igain
endin

instr   93      ;straight csound reverb2
  igain     =  p4                                 ;overall gain factor
  irvt      =  p5                                 ;reverb time
  ihdiff    =  p6                                 ;high freq diffusion factor (0-1)
  aleft     reverb2   gamixl,irvt,ihdiff
  aright    reverb2   gamixr,irvt,ihdiff
            outs      aleft*igain,aright*igain
endin
        
instr   94      ;homemade comb/resonator
  igain     =  p4                                 ;overall gain factor
  ifeed     =  p5
  idelay    =  p6                                 ;must be > 1/krate
  aleft     init      0
  aright    init      0
  ainl      =  gamixl+aleft*ifeed
  ainr      =  gamixr+aright*ifeed
  aleft     delay     ainl,idelay
  aright    delay     ainr,idelay
            outs      aleft*igain,aright*igain
endin

instr   99      ;comb variant for tuned resonance
  igain     =  p4                                 ;overall gain factor
  irvt      =  p5                                 ;reverb time
  ilpt      =  1/cpspch(p6)                       ;compute ilpt from desired pitch
  aleft     comb      gamixl,irvt,ilpt
  aright    comb      gamixr,irvt,ilpt
            outs      aleft*igain,aright*igain
endin

instr   100     ;zero the globals
  gamixl    =  0                                  ;zero the global variables
  gamixr    =  0
endin
;===================================================
;Schedule instrument that reads control tables from
;the score and implements some random processing. 
;Made in class on 12/06/2001
;Edited 11/8/2006 RP
;===================================================
  sr        =  44100
  kr        =  44100   
  ksmps     =  1                                  ;Sounds cleaner this way.
  nchnls    =  2

instr   1       ;master control instrument
  imaxamp   =  p4
  ipchvar   =  p5
  imaxden   =  p6
  imaxdur   =  p7
  insno     =  p8      
  irndoff   =  p9/100                             ;random offset percentage for density
  iroctmx   =  p10                                ;maximum random pitch deviation in oct
  itptfn    =  p11
  ibegpt    =  p12
  iendpt    =  p13
  iampfn    =  p14
  idensfn   =  p15
  idurfn    =  p16
  ipchfn    =  p17
  iroctfn   =  p18
  ipanfn    =  p19

  kptvar    oscil1i   0,iendpt-ibegpt,p3,itptfn   ;master pointer into score tables
  kpoint    =  ibegpt+kptvar
  krndens   rand      irndoff                     ;randomized offset from current density
  krndoct   rand      iroctmx                     ;randomization for pitch
  krndens   =  1+krndens                          ;the density control factor
  krndens   init      1                           ;for the first grain, to avoid divide by zero
start:
  ipoint    =  i(kpoint)
  idur      tablei    ipoint,idurfn,1             ;get the current duration
  iamp      tablei    ipoint,iampfn,1             ;get the current amplitude
  icpch     tablei    ipoint,ipchfn,1             ;get current center pitch
  ipan      tablei    ipoint,ipanfn,1             ;current pan center position
  idens     tablei    ipoint,idensfn,1            ;current density
  iroct     tablei    ipoint,iroctfn,1            ;current amount of random deviation in pitch
  ipkamp    =  iamp*imaxamp
  ipitch    =  7.00+icpch*ipchvar + iroct*i(krndoct) 
  idens     =  idens*imaxden*i(krndens)
  intvl     =  (1/idens)                          ;time interval between events
            timout    0,intvl,continue
            reinit    start
continue:
            schedule  insno,.001,idur*imaxdur,ipkamp,ipitch,ipan,ipoint
endin

instr   2       ;oscil slave
  ipoint    =  p7                                 ;avoid the warning message
  agate     linen     p4,p3*.1,p3,p3*.25
  asig      oscili    agate,cpsoct(p5),1
  ileft     =  sqrt(p6)
  iright    =  sqrt(1-p6)
            outs      asig*ileft,asig*iright
endin

instr   3       ;diskin slave
  iscale    =  p4/32767                           ;soundin not normalized
  isfdur    =  1.508                              ;1.508 second duration of soundin
  istart    =  p7                                 ;starting point for soundin file
  ipitch    =  cpsoct(p5)/cpspch(9.00)            ;relative pitch shift
  asound    diskin    "thewind.wav",ipitch,istart*isfdur,0
  asound    =  asound*iscale
  asig      linen     asound,p3*.1,p3,p3*.25
  ileft     =  sqrt(p6)
  iright    =  sqrt(1-p6)
            outs      asig*ileft,asig*iright
endin

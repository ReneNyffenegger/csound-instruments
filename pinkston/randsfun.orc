;===================================================
;Schedule instrument that reads control tables from
;the score and implements some random processing. 
;Made in class on 12/06/2001. I've cleaned it up a
;bit, added an insno p-field to the master instrument
;and split the two versions of the slave into separate
;instruments. RP
;===================================================
  sr        =  44100
  kr        =  44100 
  ksmps     =  1                                  ;Sounds cleaner this way.
  nchnls    =  2

instr 1 ;master control instrument
  idurfn    =  2
  iampfn    =  3
  ipchfn    =  4
  ipanfn    =  5
  idensfn   =  6
  iroctfn   =  7
  insno     =  p7  
  irndoff   =  p8/100                             ;random offset percentage for density
  iroctmx   =  p9                                 ;maximum random pitch deviation in oct
  kpoint    line      0,p3,1                      ;master pointer into score tables
  krndens   rand      irndoff                     ;randomized offset from current density
  krndoct   rand      iroctmx                     ;randomization for pitch
  krndens   =  1+krndens                          ;the density control factor
  kdur      tablei    kpoint,idurfn,1             ;get the current duration
  kamp      tablei    kpoint,iampfn,1             ;get the current amplitude
  kcpch     tablei    kpoint,ipchfn,1             ;get current center pitch
  kpan      tablei    kpoint,ipanfn,1             ;current pan center position
  kdens     tablei    kpoint,idensfn,1            ;current density
  kroct     tablei    kpoint,iroctfn,1            ;current amount of random deviation in pitch
start:
  idur      =  i(kdur)
  ipkamp    =  i(kamp)*p4                         ;p4 is peak amp
  ipitch    =  7.00+i(kcpch)*p5 + kroct*i(krndoct) ;p5 is pitch variation in oct
  ipan      =  i(kpan)
  idens     =  i(kdens)*p6*krndens                ;p6 is max density
  intvl     =  (1/idens)                          ;time interval between events
            timout    0,intvl,continue
            reinit    start
continue:
            schedule  insno,.001,idur,ipkamp,ipitch,ipan,i(kpoint)
endin

instr 2 ;oscil slave
  agate     linen     p4,p3*.1,p3,p3*.25
  asig      oscili    agate,cpsoct(p5),1
  ileft     =  sqrt(p6)
  iright    =  sqrt(1-p6)
            outs      asig*ileft,asig*iright
endin

instr 3 ;diskin slave
            print     p3,p4,p5,p6
  iscale    =  p4/32767
  istart    =  p7                                 ;starting point for soundin file
  ipitch    =  cpsoct(p5)/cpspch(9.00)
  asound    diskin    "thewind.aif",ipitch,istart*1.3 ;skipin to istart*1.3 seconds
  asound    =  asound*iscale
  asig      linen     asound,p3*.1,p3,p3*.25
  ileft     =  sqrt(p6)
  iright    =  sqrt(1-p6)
            outs      asig*ileft,asig*iright
endin

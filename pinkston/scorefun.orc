;===================================================
;Schedule instrument that reads control tables from
;the score. Made in class on 12/04/2001. I made a 
;few minor changes, including going with tablei. RP
;===================================================
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

instr   1       ;master control instrument
  idurfn    =  2
  iampfn    =  3
  ipchfn    =  4
  ipanfn    =  5
  idensfn   =  6
  insno     =  2
  kpoint    line      0,p3,1                      ;master pointer into score tables
  kdur      tablei    kpoint,idurfn,1             ;get the current duration
  kamp      tablei    kpoint,iampfn,1             ;get the current amplitude
  kcpch     tablei    kpoint,ipchfn,1             ;get current center pitch
  kpan      tablei    kpoint,ipanfn,1             ;current pan center position
  kdens     tablei    kpoint,idensfn,1            ;current density
start:
  idur      =  i(kdur)
  ipkamp    =  i(kamp)*p4                         ;p4 is peak amp
  ipitch    =  6.00+i(kcpch)*p5                   ;p5 is pitch variation in oct
  ipan      =  i(kpan)
  idens     =  i(kdens)*p6                        ;p6 is max density
  intvl     =  1/idens                            ;time interval between events
            print     idur,ipkamp,ipitch,ipan,intvl
            timout    0,intvl,continue
            reinit    start
continue:
            schedule  insno,.001,idur,ipkamp,ipitch,ipan
endin


instr   2       ;slave
  agate     linen     p4,.001,p3,.02
  asig      oscili    agate,cpsoct(p5),1
  ileft     =  sqrt(p6)
  iright    =  sqrt(1-p6)
            outs      asig*ileft,asig*iright
endin

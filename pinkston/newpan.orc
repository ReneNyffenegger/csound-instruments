;=================================================
;Dynamic panning and Timbral Crossfade Instruments 
;Made in class on 9/14/06
;RP
;=================================================
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

instr   1       ;dynamic panning instrument
;       initialization section
  iamp      =  p4
  icps      =  cpspch(p5)
  irise     =  p6
  idecay    =  p7
  ipanfn    =  p8
  ipandel   =  p9
;       performance section
  kamp      linen     iamp,irise,p3,idecay
  asig      oscili    kamp,icps,1                 ;wave table is in fn1
  kpan      oscil1i   ipandel,1,p3-ipandel,ipanfn
  kleft     =  sqrt(kpan)
  kright    =  sqrt(1-kpan)
            outs      asig*kleft,asig*kright
endin

instr   2       ;dynamic timbre exchange instrument
;       initialization section
  iamp      =  p4
  icps      =  cpspch(p5)
  irise     =  p6
  idecay    =  p7
  ixfadfn   =  p8
  ixfadel   =  p9
  iwave1    =  p10
  iwave2    =  p11
;       performance section
  kamp      linen     iamp,irise,p3,idecay
  asig1     oscili    kamp,icps,iwave1            ;wave table1 is in p10
  asig2     oscili    kamp,icps,iwave2            ;wave table2 is in p11
  kfade     oscil1i   ixfadel,1,p3-ixfadel,ixfadfn
  kfad1     =  kfade                              ;crossfade function
  kfad2     =  1-kfade                            ;inverse of crossfade func
  asig      =  asig1*kfad1 + asig2*kfad2
            outs      asig,asig
endin
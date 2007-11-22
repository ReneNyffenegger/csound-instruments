  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2


instr 1
            massign   1,1
  knote     cpsmidib  
  inote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc,0,.2,.01
  ifreq1    =  inote
  ifreq2    =  ifreq1 * 1.01
  ifreq3    =  ifreq1 * .99
  imod      =  2.
  itremsp1  =  1
  itremsp2  =  .227383
  itremsp3  =  .173560
  itremdepth   =      .5
  isinefunc =  1
  iatk      =  .2
  idk       =  .2
  isust     =  2.4-(iatk+idk)
  index     =  1.
  idev      =  .3
  iamp      =  4 * 32767 * .3
  idexspeed =  2
  itdev     =  .5/2.
  itbase    =  1.-itdev
;i1 0 dur p4 trem1 trem2 trem3 atk dk amp indexspeed
  aenv      linseg    0,iatk, iamp, isust, iamp, idk, 0
  kindex    oscil     idev, idexspeed, isinefunc
  kindex    =  kindex + index
  amod      oscil     kindex, imod, isinefunc
  afr1      =  ifreq1+amod
  afr2      =  ifreq2+amod
  afr3      =  ifreq3+amod
  ktrem1    oscil     itdev, itremsp1, isinefunc
  ktrem2    oscil     itdev, itremsp2, isinefunc
  ktrem3    oscil     itdev, itremsp3, isinefunc
  ktrem1    =  ktrem1 + itbase
  ktrem2    =  ktrem2 + itbase
  ktrem3    =  ktrem3 + itbase
  asine1    oscil     aenv*ktrem1, afr1, isinefunc
  asine2    oscil     aenv*ktrem2, afr2, isinefunc
  asine3    oscil     aenv*ktrem3, afr3, isinefunc
  asine1    =  asine1 * .707
  aout1     =  asine1+asine2
  aout2     =  asine1+asine3
            outs      aout1*kgate, aout2*kgate
endin

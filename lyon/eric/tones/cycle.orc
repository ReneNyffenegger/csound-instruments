
  sr        =  44100
  kr        =  4410
  ksmps     =  10

;i1 0 dur freqfunc speed wavefunc transp_fac
instr 1
  ifreqfunc =  p4
  iwavefunc =  p6
  itrans    =  p7
  isinefunc =  2
  ispeed    =  p5
  iatk      =  .01
  idk       =  .05
  isust     =  p3-(iatk+idk)
  igain     =  32000.0 * p8
  invals    =  ftlen( iwavefunc)
  idexamp   =  invals/2
  aenv      linseg    0,iatk,igain,isust,igain,idk,0
  kndex     oscil     idexamp, ispeed, isinefunc
  kndex     =  kndex + idexamp
  kfreq     table     kndex, ifreqfunc
  kfreq     port      kfreq, .02
  asig      oscili    aenv, kfreq * itrans, iwavefunc
            out       asig
endin

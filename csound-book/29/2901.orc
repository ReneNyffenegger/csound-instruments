  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1


instr     2901
  iatk      =  .2
  idec      =  .1
  isus      =  .8
  irel      =  .2
  isteady   =  1-(iatk+idec+irel)                 ; LENGTH OF SUSTAIN LEVEL
  alfo      oscili    0.2, p6, 3
  apw       =  alfo+0.25
  asaw      oscili    1, p5, 2
  apulse    table     asaw-apw, 1, 1, 0.5
  kenv      linseg    0,p3*iatk,1,p3*idec,isus,isteady*p3,isus,p3*irel,0
            out       p4*apulse*kenv
endin

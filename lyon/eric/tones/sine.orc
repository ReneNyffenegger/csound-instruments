  sr        =  44100
  kr        =  4410
  ksmps     =  10

;i1 0 dur freq ampDb
instr 1
  ifreq     =  p4
  igain     =  ampdb( p5 ) * 5000.
  iatk      =  .1
  idk       =  .1
  isust     =  p3-(iatk+idk)
  kenv      linseg    0,iatk,igain,isust,igain,idk,0
  asig      oscil     kenv,ifreq,1
            out       asig
endin

instr 2
  ifreq     =  p4
  igain     =  p5 * 10000.
  iatk      =  p6
  idk       =  iatk
  isust     =  p3-(iatk+idk)
  kenv      linseg    0,iatk,igain,isust,igain,idk,0
  asig      oscil     kenv,ifreq,1
            out       asig
endin
instr 3
  ifreq     =  p4
  igain     =  p5 * 10000
  irise     =  .3
  isust     =  p3-(irise*2)
  kenv      linseg    0,irise,igain,isust,igain,irise,0
  asig      oscil     kenv,ifreq,1
            out       asig
endin


instr 4
  igain     =  p4 * 30000
  irise     =  .3
  isust     =  p3-(irise*2)
  kenv      linseg    0,irise,igain,isust,igain,irise,0
  kfreq     oscili    1.0, 1/p3, 2
  asig      oscil     kenv,kfreq,1
            out       asig
endin

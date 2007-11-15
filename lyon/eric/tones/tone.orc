  sr        =  22050
  kr        =  22050
  ksmps     =  1

;i1 0 dur freq ampDb
instr 1
  ifreq     =  p4
  igain     =  20000.
  idgain    =  igain * .3
  ia        =  .3
  id        =  .3
  ir        =  .4
  is        =  p3-(ia+id+ir)
  kenv      linseg    0,ia,igain,id,idgain,is,idgain,ir,0
        ;kenv randi igain, 11
        ;asig oscil kenv,ifreq,1
  asig      randi     kenv, 10000
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
  igain     =  p5 * 5000.
  irise     =  p3/2
  kenv      linseg    0,irise,igain,irise,0
  asig      oscil     kenv,ifreq,1
            out       asig
endin

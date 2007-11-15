  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  igain     =  ampdb(p4) * 32767.
  igain     =  10000
  iatk      =  .01
  idk       =  .1
  isust     =  p3-(iatk+idk)
  itop      =  8000
        ;kenv linseg 0,iatk,igain,isust,igain,idk,0
  kenv      linseg    0,iatk,igain,p3-iatk,0
  asig      randi     kenv,itop,1
         ;asig randi 10000,itop,1
        ;apink tone asig, 11025
        ;apink tone apink, 5000
        ;out apink
            out       asig
endin


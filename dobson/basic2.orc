;basic2.orc: USE OSCILI, AND KEEP PHASE

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  idur      =  abs(p3)
  ir        tival     
  i1        =  -1                                 ; ASSUME THIS IS TIED NOTE, KEEP OLD PHASE
            tigoto    slur                        ; SKIP REINIT OF katt ON TIED NOTES
  i1        =  0                                  ; FIRST NOTE, SO RESET PHASE
  katt      line      p4,idur,0                   ; PRIMARY ENVELOPE

slur:
if        ir==0 kgoto tone                        ; NO EXPRESSION IF FIRST NOTE
  kslur     linseg    0,idur/2,p4,idur/2,0        ; ENV FOR A SLURRED NOTE katt = katt + kslur
tone:
  asig      oscili    katt,p5,1,i1
            out       asig
endin

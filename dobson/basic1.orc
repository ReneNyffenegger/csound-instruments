; basic1.orc
; USED TO MAKE A SIMPLE SLURRING INSTRUMENT, FOR EXAMPLE 
; HENCE THE abs(p3) USAGE

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  idur      =  abs(p3)                            ; p3 IS NEGATIVE FOR A HELD NOTE
  ir        tival                                 ; IS THIS A TIED NOTE?
  katt      line      p4,idur,0                   ; PRIMARY ENVELOPE
if        ir==0 kgoto tone                        ; NO EXPREESSION IF FIRST NOTE
  kslur     linseg    0,idur/2,p4,idur/2,0        ; SIMPLE SWELL ON TIED NOTES
  katt      =  katt+kslur
tone:
  asig      oscil     katt,p5,1
            out       asig
endin

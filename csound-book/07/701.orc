  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 701               
  idur      =  abs(p3)                            ; NEED POSITIVE DUR FOR ENVELOPE
  ir        tival                                 ; FIND OUT IF THIS IS A TIED NOTE
  i1        =  -1                                 ; SET OSCIL PHASE FOR A TIED NOTE
            tigoto    slur                        ; SKIP REINIT OF ENV ON TIED NOTES
  i1        =  0                                  ; FIRST NOTE, SO RESET OSC PHASE
  katt      line      p4, idur, 0                 ; OVERALL ENVELOPE
slur:                   
if              ir==0   kgoto tone                ; NO SWELL IF FIRST NOTE
  kslur     linseg    0, idur/2, p4, idur/2, 0    ; SIMPLE SWELL SHAPE 
  katt      =  katt+kslur                         ; ADD SWELL TO PRIMARY ENVELOPE
tone:                   
  asig      oscili    katt, cpspch(p5), 1, i1     ; REINIT PHASE IF FIRST NOTE
            out       asig    
endin           

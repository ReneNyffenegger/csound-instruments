;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;         FM WOOD DRUM ORCHESTRA FILE                   ;
;                                                       ;
;         P3 = DURATION        P4 = AMPLITUDE           ;
;         P5 = PITCH IN PCH                             ;
;                                                       ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1 

instr     1
  idur      =  .18
if   p3 < .18  igoto reset
            igoto     index
reset:
  idur      =  p3
index:
  kndx      envlpx    1,.001,.002,.001,2,1,.001
  kamp      envlpx    p4,.001,idur,(idur*.92),2,1,.001
  asig      foscili   kamp,cpspch(p5),1,4.5,kndx,1
            out       asig
endin

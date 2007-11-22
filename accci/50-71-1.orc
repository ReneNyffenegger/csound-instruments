; ************************************************************************
; ACCCI:     50-71-1.ORC
; synthesis: subtractive synthesis(50)
;            two fixed formant regions(71)
;            buzz pulse as source(1)
; coded:     jpg 11/93


  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1


instr 1; *****************************************************************
  idur      =  p3
  iamp      =  p4 
  ifqc      =  cpspch(p5)
  inmh      =  sr/2/ifqc

  asrc      buzz      iamp,ifqc,inmh,1            ; buzz source

  a1        reson     asrc,1000,100,0             ; formant regions
  a2        reson     a1,3000,500,0

  asig      balance   a2,asrc                     ; in/out balance
  asig      linen     asig, .1, idur, .1          ; envelope
            out       asig*4
endin

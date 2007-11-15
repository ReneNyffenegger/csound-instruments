  sr        =  30000
  kr        =  5000
  ksmps     =  6

;i1 0 dur file skip atk dk
;f1 0 2048 13 1 1 h0 h1 h2 ...
instr 1
  iamp      =  30000
  itk       =  p6
  idk       =  p7
  isu       =  p3-(itk+idk)
  in        =  ftlen( 1 )
  in2       =  in/2
  imult     =  in2/32767
        ;aenv linseg 0,itk,iamp,isu,iamp,idk,0
  asig      soundin   p4,p5
  krms      rms       asig
  kndx      =  in2+(imult*krms)
  kamp      tablei    kndx,1
            out       asig * kamp
endin

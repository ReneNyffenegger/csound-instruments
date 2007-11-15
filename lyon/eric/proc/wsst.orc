  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

;i1 0 dur file skip atk dk
;f1 0 16384 13 1 1 h0 h1 h2 ...
instr 1
  iroll     =  200
  iamp      =  30000
  itk       =  p6
  idk       =  p7
  igaidog   =  p8
  isu       =  p3-(itk+idk)
  idog      =  ftlen( 1 )
  idog2     =  idog/2
  imult     =  (idog2/32767)*igaidog
  aenv      linseg    0,itk,iamp,isu,iamp,idk,0
  aidog1,aidog2       soundin                     p4,p5
  andx1     =  idog2+(imult*aidog1)
  aws1      tablei    andx1,1
  andx2     =  idog2+(imult*aidog2)
  aws2      tablei    andx2,1
  aws1      atone     aws1,iroll
  aws2      atone     aws2,iroll
            outs      aws1*aenv,aws2*aenv
endin

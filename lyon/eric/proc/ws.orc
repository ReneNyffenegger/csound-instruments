  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

;i1 0 dur file skip atk dk gain hpfroll
;f1 0 16384 13 1 1 h0 h1 h2 ...
instr 1
  iamp      =  30000
  itk       =  p6
  idk       =  p7
  igain     =  p8
  irollup   =  p9
  isu       =  p3-(itk+idk)
  in        =  ftlen( 1 )
  in2       =  in/2
  imult     =  in2/32767
  aenv      linseg    0,itk,iamp,isu,iamp,idk,0
  asig      soundin   p4,p5
  asig      =  asig * igain
  andx      =  in2+(imult*asig)
  aws       tablei    andx,1
  aout      atone     aws,irollup
            out       aout*aenv
endin

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
  iflen     =  ftlen( 1 )
  iflen2    =  iflen/2
  aenv      linseg    0,itk,10000.0,isu,10000.0,idk,0
  kenv1     line      1.0, p3, 0
  asig      oscili    kenv1, 500, 2
        ;andx = in2+(imult*asig)
  aws       tablei    asig*iflen2,1,0,iflen2
  aout      atone     aws,irollup
            out       aout*aenv
endin

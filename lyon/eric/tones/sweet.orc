  sr        =  44100
  kr        =  4410
  ksmps     =  10
;minimum dur = .51
;i1 0 dur freq amp vspeed1 vspeed2 atk dk
instr 1
  iatk      =  p8 
  idk       =  p9
  isust     =  p3-(iatk+idk)

  icar      =  cpspch( p4 )
  imod      =  icar*.995
  iamp      =  p5*29000
  igain     =  iamp*.48
;idown = igain*.4
  idown     =  igain*.7
  ivs1      =  p6
  ivs2      =  p7
  indexsust =  p3-.5
  idev      =  icar*.01
  aenv      linseg    0,iatk,igain,isust,idown,idk,0
  kvib1     oscil     idev,ivs1,1
  kvib2     oscil     idev,ivs2,1
  kindex    linseg    0,.15,1.5,.15,.6,indexsust,.3,.2,.001
  kidev     randi     .1,13,.555
  kindex    =  (kindex+kidev)*icar
  amod      oscil     kindex,imod,1
  afr1      =  icar + amod + kvib1
  afr2      =  icar + amod + kvib2
  asig1     oscil     aenv,afr1,1
  asig2     oscil     aenv,afr2,1
        ;asig1 oscil igain,afr1,1
        ;asig2 oscil igain,afr2,1
            out       asig1+asig2
endin

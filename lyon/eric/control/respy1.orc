  sr        =  8192
  kr        =  8192
  ksmps     =  1

; csoundbeta -h -f -d -o func futon2.orch futon2.s

instr 1
  iamp1     =  p4
  isp1      =  p5
  iseed1    =  p6
  iamp2     =  p7
  isp2      =  p8
  iseed2    =  p9
  ivamp     =  p10
  ivsp      =  p11

  iampsum   =  iamp1+iamp2+ivamp
  iampsum2  =  iampsum * 2
  ar1       randh     iamp1, isp1, iseed1
  avib      oscil     ivamp, ivsp, 1
  ar2       randi     iamp2, isp2, iseed2
  asum      =  ar1+avib+ar2
  asum      =  (asum+iampsum)/iampsum2
            out       asum                        ;
endin

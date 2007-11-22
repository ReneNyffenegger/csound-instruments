  sr        =  22050
  kr        =  2205
  ksmps     =  10.0
  nchnls    =  2

instr   1       ;pluck with echoes
  kgate     linseg    p4,.1,0,1,0                 ;.1 second ramp
  icps      =  cpspch(p5)                         ;p5 in pch
  asig      pluck     kgate,icps,icps,0,1,0,0     ;simple pluck
;Make two slapback echoes, each one softer than the input:                      
  atap1     delay     asig*.7,p6                  ;p6 second delay
  atap2     delay     asig*.5,p7                  ;p7 second delay
            outs      asig+atap1,asig+atap2       ;add stereo echoes
endin           

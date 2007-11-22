  sr        =  22050
  kr        =  2205
  ksmps     =  10.0
  nchnls    =  2

instr   2       ;dry pluck
  gasend    init      0                           ;init global "send"
  kgate     linseg    p4,.1,0,1,0                 ;.1 second ramp
  icps      =  cpspch(p5)                         ;p5 in pch
  asig      pluck     kgate,icps,icps,0,1,0,0     ;simple pluck
            outs      asig,asig                   ;straight out
  gasend    =  gasend+asig                        ;add to global var
endin           
;------------- A global effect instrument -----------------;                    
instr   3       ;stereo echoes
  atap1     delay     gasend*p4,p6                ;use global var
  atap2     delay     gasend*p5,p7                ;for inputs
            outs      atap1,atap2                 ;stereo echoes
  gasend    =  0                                  ;clear global var
endin           

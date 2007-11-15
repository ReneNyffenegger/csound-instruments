  sr        =  44100                              ;
  kr        =  8820                               ;
  ksmps     =  5                                  ;

instr 72
  afile     soundin   1, 0
  afile     =  afile * p4
  ktime     line      0, p3, p3
  krmsr,krmso,kerr,kcps lpread                    ktime, 1
  asig      lpreson   afile   
            out       asig
endin

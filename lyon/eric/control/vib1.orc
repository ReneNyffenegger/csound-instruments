  sr        =  8192
  kr        =  8192
  ksmps     =  1

instr 1
  ispeed    =  p4 * p5 
  idev      =  p6                                 ;
  avib      oscil     idev, ispeed, 1
  avib      =  1. + avib                          ;
            out       avib
endin
;=================================================
;Table testing instrument made in class on 9/14/06
;RP
;=================================================
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2


instr   1
  ifn       =  p4                                 ;p4 of i-statement will have function number
  ival0     table     0,ifn                       ;get 0th val
  ival1     table     1,ifn                       ;get 1st val
  ival7     table     7,ifn                       ;get 7th val
            print     ival0,ival1,ival7                       
endin

instr   2
  ifn       =  p4
  isize     =  p5
  kval      line      0,p3,isize-1
  koutput   table     kval,ifn
            display   koutput,p3
endin
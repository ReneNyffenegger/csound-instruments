  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1
;=======================================================================;
; KARSTR          Plucked String Instrument                             ;
;                 Coded by Tom Dimeo                                    ;
;                 Brooklyn College of Music Computer Music Studio       ;
;=======================================================================;
instr        1
  ga1       init      0
  i1        =  cpsoct(p5)
  i2        =  1/i1-.5/sr
  i3        =  p4*10

  k1        linseg    1,i2,1,.0001,0,p3-i2-.0001,0
  a1        rand      k1
  a2        delay     a1+ga1,i2
  a1        delay1    a2
  a4        line      .498,p3,.48
  ga1       =  a4*(a1+a2)
  ga1       alpass    ga1,0,i2
  a3        =  ga1*i3
  a3        tone      a3,(p4-1000)*.5
            out       a3
endin

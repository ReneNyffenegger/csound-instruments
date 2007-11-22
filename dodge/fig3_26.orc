  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

;=======================================================================;
; FIG3_26         Drum Instrument based on Risset  (Dodge p. 93-94)     ;
;                 Coded by Thomas Dimeo                                 ;
;                 Brooklyn College Computer Music Studio                ;
;=======================================================================;
instr      1
  i1        =  1/p3
  i2        =  cpspch(p5)
  i3        =  p4/2
  i4        =  p4/6
  i5        =  p4/2.5

  k1        oscili    i3,i1,2
  a1        randi     k1,400
  a1        oscili    a1,500,3
  a2        oscili    i4,i1,2
  a2        oscili    a2,i2/10,4
  a3        oscili    i5,i1,1
  a3        oscili    a3,i2,3
            out       a1+a2+a3
endin

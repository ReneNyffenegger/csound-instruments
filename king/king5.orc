  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

instr 1
  kamp1     line      ampdb(p5),p3,0
  kamp2     line      0,p3,ampdb(p5)
  as1a      oscil     20,cpspch(p4),1
  as1b      oscil     20,cpspch(p4)*1.4987,2
  as1c      delay     as1b,.02
  as1       =  as1a+as1c
  at1       atone     as1,cpspch(p4)
  as2a      oscil     20,cpspch(p4)*1.4987,2
  as2b      oscil     20,cpspch(p4),1
  as2c      delay     as2a,.025
  as2       =  as2a+as2c
  at2       atone     as2,cpspch(p4)
  ab1a      gbuzz     20,at1, 5, 0, 1, 1
  ab1b      gbuzz     20,at1, 5, 0, 1, 2
  ab1       delay     ab1b,.015
  aport1    tone      ab1,100
  ab2a      gbuzz     20,at1, 5, 0, 1, 1
  ab2b      gbuzz     20,at2, 5, 0, 2, 2
  ab2       delay     ab2b,.03
  aport2    tone      ab2,100
  ag1       gain      aport1,kamp2
  ag2       gain      aport2,kamp1
  add       oscil     20,1/cpspch(p4),1
  addp      =  add+50
  av1       vdelay    ag1,addp,100
  av2       vdelay    ag2,addp,200
  asuml     =  ag1+av1
  asumr     =  ag2+av2
            outs      asuml,asumr
endin

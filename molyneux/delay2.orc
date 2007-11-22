  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1


instr     1
  ipitch    =  cpspch(p5)
  idlt      =  1/ipitch
  knh       init      (sr*.4)/ipitch
  abuzz     buzz      p4,ipitch,knh,3
  kamp      oscil1i   0.00,1,p3,4
  araw      =  abuzz*kamp
  asig      init      0
  adelay    delay     (araw+asig),idlt    
  aflt1     reson     adelay,ipitch,(ipitch*.1),1
  aflt2     reson     adelay,(ipitch*2),(ipitch*.2),1
  aflt3     reson     adelay,(ipitch*3),(ipitch*.3),1
  aflt4     reson     adelay,(ipitch*4),(ipitch*.4),1
  aflt5     reson     adelay,(ipitch*5),(ipitch*.5),1
  aflt6     reson     adelay,(ipitch*6),(ipitch*.6),1
  afltbnk   =  aflt1+aflt2+aflt3+aflt4+aflt5+aflt6
  abal      balance   afltbnk,abuzz
  asig      envlpx    abal,.03,p3,.5,2,.85,.01
            out       asig
endin
 

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr     1
  ipitch    =  cpspch(p5)
  idlt      =  1/ipitch
  arnd      rand      p4
  apop      envlpx    arnd,.002,.005,.002,2,1,.01
  asig      init      0
  adelay    delay     (apop+asig),idlt    
  afilter   reson     adelay,ipitch,(ipitch*.1),1
  abal      balance   afilter,arnd
  asig      envlpx    abal,.03,p3,.1,2,.15,.01
            out       asig
endin
 

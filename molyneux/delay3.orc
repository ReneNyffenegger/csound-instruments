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
  asig1     init      0
  asig2     init      0
  asig3     init      0
  asig4     init      0
  asig5     init      0
  asig6     init      0
  adelay1   delay     (araw+asig1),idlt   
  adelay2   delay     (araw+asig2),(idlt/2)    
  adelay3   delay     (araw+asig3),(idlt/3)
  adelay4   delay     (araw+asig4),(idlt/4)
  adelay5   delay     (araw+asig5),(idlt/5)
  adelay6   delay     (araw+asig6),(idlt/6)
  aflt1     reson     adelay1,ipitch,(ipitch*.1),1
  aflt2     reson     adelay2,(ipitch*2),(ipitch*.15),1
  aflt3     reson     adelay3,(ipitch*3),(ipitch*.20),1
  aflt4     reson     adelay4,(ipitch*4),(ipitch*.25),1
  aflt5     reson     adelay5,(ipitch*5),(ipitch*.30),1
  aflt6     reson     adelay6,(ipitch*6),(ipitch*.35),1
  abal1     balance   aflt1,(abuzz/6)
  abal2     balance   aflt2,(abuzz/6)
  abal3     balance   aflt3,(abuzz/6)
  abal4     balance   aflt4,(abuzz/6)
  abal5     balance   aflt5,(abuzz/6)
  abal6     balance   aflt6,(abuzz/6)
  asig1     envlpx    abal1,.20,p3,.5,2,.95,.01
  asig2     envlpx    abal2,.18,p3,.5,2,.85,.01
  asig3     envlpx    abal3,.16,p3,.5,2,.75,.01
  asig4     envlpx    abal4,.14,p3,.5,2,.45,.01
  asig5     envlpx    abal5,.12,p3,.5,2,.35,.01
  asig6     envlpx    abal6,.10,p3,.5,2,.25,.01
  asig      =  asig1+asig2+asig3+asig4+asig5+asig6
            out       asig
endin
 

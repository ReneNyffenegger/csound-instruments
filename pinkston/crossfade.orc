  sr        =  22050                                                 
  kr        =  2205
  ksmps     =  10
  nchnls    =  2

instr   1               ;simple waveform interpolation 
;-------------------------------;initialization block
  iamp      =  p4
  ipitch    =  cpspch(p5)
  irise     =  p6
  idecay    =  p7
  ipan      =  p8                                 ;pan position between 1(L) & 0(R)
  ileft     =  sqrt(ipan)
  iright    =  sqrt(1-ipan)
  idelay    =  p9                                 ;delay time in secs before xfade
  ifade     =  p10                                ;duration of xfade in secs
  igatefn   =  p11                                ;control function for xfade
  ifn1      =  p12
  ifn2      =  p13
;-------------------------------;performance block
  kgate1    oscil1i   idelay,1,ifade,igatefn
  kgate2    =  1-kgate1                           ;kgate2 inverse of kgate1
  asig1     oscili    iamp*kgate1,ipitch,ifn1     ;signal 1
  asig2     oscili    iamp*kgate2,ipitch,ifn2     ;signal 2
  aoutput   linen     asig1+asig2,irise,p3,idecay ;sum and envelope
            outs      aoutput*ileft,aoutput*iright
endin

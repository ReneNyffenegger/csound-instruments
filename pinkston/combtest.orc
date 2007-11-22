  sr        =  22050
  kr        =  2205
  ksmps     =  10.0
  nchnls    =  2

instr   1       ;simple soundin player 
  gasend    init      0                           ;init global "send"
  iskip     =  p6                                 ;optional skip time in p6
  asig      soundin   "richard.wav",iskip     
  adrysig   =  asig*p4                            ;p4 = amp fac for dry signal
  awetsig   =  asig*p5                            ;p5 = amp fac for wet signal
            outs      adrysig,adrysig             ;straight out
  gasend    =  gasend+awetsig                     ;add to global var
endin           
;------------- Single Comb Filter -----------------;                    
instr   2       ;comb filter
;p4 has comb loop time - usually in seconds, but if > 5,
;assume pch and calculate loop time by 1/cpspch(p4)
  ilpt      =  (p4 > 5 ? 1/cpspch(p4) : p4)
  irvt      =  p5                                 ;reverb time for comb in secs
  iscale    =  p6                                 ;rescaling factor
  iflag     =  p7                                 ;if non-zero, we clear gasend
  istor     =  p8                                 ;0 (default) to clear istor
  ainsig    =  gasend*iscale
  arvbsig   comb      ainsig,irvt,ilpt,istor
            outs      arvbsig,arvbsig 
;Allow for multiple notes on instrument 2 - only the 
;last currently executing instance should zero gasend
if      (iflag = 0) goto exit
  gasend    =  0                                  ;zero only if flag set
exit:
endin           

;---------------------------------------------------------;
; Simple instruments demonstrating the use of the Csound
; reverb and reverb2 units. They are based on the example
; comb instrument (combtest.orc), which has additional
; comments in the code. RP
;---------------------------------------------------------;

  sr        =  22050
  kr        =  2205
  ksmps     =  10.0
  nchnls    =  2

instr   1       ;dry 
  gasend    init      0                           ;init global "send"
  iskip     =  p6                                 ;optional skip time in p6
  asig      soundin   "richard.wav",iskip     
  adrysig   =  asig*p4                            ;p4 = amp fac for dry signal
  awetsig   =  asig*p5                            ;p5 = amp fac for wet signal
            outs      adrysig,adrysig             ;straight out
  gasend    =  gasend+awetsig                     ;add to global var
endin           
;------------- Basic Reverb Instrument -----------------;                       
instr   2
  iscale    =  p4                                 ;initial rescaling factor
  irvt      =  p5                                 ;reverb time in secs
  istor     =  p6                                 ;0 (default) to clear istor
  ainsig    =  gasend*iscale
  arvbsig   reverb    ainsig,irvt,istor
            outs      arvbsig,arvbsig 
;Allow for multiple notes on instrument 2:
if      (p7 = 0) goto exit
  gasend    =  0                                  ;zero only if flag set
exit:
endin           
;------------- Enhanced Reverb Instrument ---------------;                      
instr   3
  iscale    =  p4                                 ;initial rescaling factor
  irvt      =  p5                                 ;reverb time in secs
  idiff     =  p6
  istor     =  p7                                 ;0 (default) to clear istor
  ainsig    =  gasend*iscale
  arvbsig   reverb2   ainsig,irvt,idiff,istor
            outs      arvbsig,arvbsig 
;Allow for multiple notes on instrument 2:
if      (p8 = 0) goto exit
  gasend    =  0                                  ;zero only if flag set
exit:
endin           

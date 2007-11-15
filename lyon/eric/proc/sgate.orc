;This processor reads soundfile soundin.1
;it gates it with itself slightly predelayed
;then it lpfilters the origsignal, reverberates resonates and outputs mono

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1
;i1 0 dur delay cf rolloff gain file
instr 1
  ifile     =  p8
  igain     =  p7
  idelay    =  p4
  irevtime  =  1.4
  irevamp   =  .3
  idry      =  1-irevamp
  irolloff  =  p6
  icf       =  p5
  ibw       =  icf/10
  iresgain  =  5

  asig      soundin   ifile,idelay
  aenv      soundin   ifile,0
  aenv      =  igain*aenv
  arebal    balance   asig,aenv

;post processing
  alpf      tone      arebal,irolloff
  arev      reverb    arebal,irevtime
  arev      tone      arev,irolloff
;       gaout = (alpf*idry)+(arev*irevamp)
;       ares reson gaout,icf,ibw,1
;       out gaout+(ares*iresgain)
            out       arev
endin
; for placing resonances into mix
;instr 2
;iamp = 1.5
;iincr = .5/p3
;       
        ;kenv oscil iamp,iincr,1
        ;ares balance ares,gaout
        ;out ares*kenv
;endin
instr 3
endin

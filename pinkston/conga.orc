  sr        =  22050
  kr        =  2205
  ksmps     =  10
  nchnls    =  1
;==================================================;
;               Drum Set Instrument                ;
;                                                  ;
; This instrument demonstrates how to use loscil & ;
; table units to implement a sampler-like drum set ;
; RP                                               ;
;==================================================;
instr   1
  isampfn   =  20                                 ;map note #'s to sample #'s
  idatafn   =  21                                 ;root key and loop data func
  iampfn    =  22                                 ;velocity to amplitude map
  ismpno    table     p4,isampfn                  ;look up this midi note # in smpno table
  ismpno    =  int(ismpno)                        ;clean off any fraction
  index     =  (ismpno-1)*4
  iroot     table     index,idatafn               ;root key
  imode     table     index+1,idatafn             ;loop mode
  iloops    table     index+2,idatafn             ;loop start sample
  iloope    table     index+3,idatafn             ;loop end sample
  iamp      table     p5,iampfn                   ;map midi velocity to amp
  ipitch    =  3.00 + p4/12                       ;convert midi nn to oct
  iroot     =  3.00 + iroot/12                    ;convert root nn to oct
  kgate     expseg    1,p3*.9,.1,p3*.1,.001
  asig      loscil    iamp,cpsoct(ipitch),ismpno,cpsoct(iroot),imode,iloops,iloope
            out       asig*kgate
endin

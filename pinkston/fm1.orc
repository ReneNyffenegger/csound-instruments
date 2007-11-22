;---------------------------;
; Pinkston: FM Instrument 1 ;
;---------------------------;

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr   1       ;simple FM instrument
  isine     =  1                                  ;f01 has sine table
  iamp      =  p4                                 ;peak amp of carrier
  icarhz    =  p5                                 ;carrier frequency
  imodhz    =  p6                                 ;modulator frequency
  index     =  p7                                 ;max index of modulation
  index1    =  p8                                 ;minimum index
  irise     =  p9                                 ;rise time
  idecay    =  p10                                ;decay time
  isteady   =  p3-irise-idecay                    ;steady state time
  imaxdev   =  index*imodhz                       ;D = I * M
  imindev   =  index1*imodhz                      ;minimum deviation
  ivardev   =  imaxdev-imindev                    ;variable deviation
  kenv      expseg    .001,irise,1,isteady,1,idecay,.001      
  kmodamp   =  imindev+ivardev*kenv               ;amplitude of modulator
  amodsig   oscili    kmodamp,imodhz,isine        ;gated modulator
  acarsig   oscili    iamp*kenv,icarhz+amodsig,isine ;simple FM
            out       acarsig 
endin           

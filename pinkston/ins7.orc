;-----------------------------------------;
; Pinkston Example Complex Instrument 7   ;
;-----------------------------------------;

  sr        =  22050
  kr        =  2205
  ksmps     =  10
  nchnls    =  2

instr   7                               ;constrained random music
;--------------------------Initialization block ---------------------------;
  ipkamp    =  p4      
  idurfn    =  p5                                 ;the possible durations
  ipchfn    =  p6                                 ;the possible pitches
  iampfn    =  p7                                 ;amp scaling function
  iprise    =  p8                                 ;phrase env rise time
  ipdec     =  p9                                 ;phrase env decay time
  inrise    =  p10                                ;individual note amp rise
  indec     =  p11                                ;individual note amp decay
  iseed1    =  p12                                ;for duration rand unit
  iseed2    =  p13                                ;for pitch rand unit
  iseed3    =  p14                                ;for panning rand unit
  ipkdur    =  .2501                              ;max expected dur
;------------------------- The Phrase Envelope ----------------------------;                    
  kphrase   expseg    .001,iprise,1,p3-iprise-ipdec,1,ipdec,.001      
;--------------------------------------------------------------------------;                    
  kdurloc   rand      .5,iseed1                   ;get random table indices
  kpchloc   rand      .5,iseed2                   ;between -.5 and +.5
  kpan      rand      .5,iseed3       
;--------------------------------------------------------------------------;                    
noteinit:
                                        ;start reinit block     
  idurloc   =  .5+i(kdurloc)                      ;make positive i-time var
  idur      table     idurloc,idurfn,1            ;select from dur table
  iamp      table     idur/ipkdur,iampfn,1        ;relate amp to dur
  iamp      =  .25 + .75 * iamp                   ;amp range from .25 to 1
  ipchloc   =  .5+i(kpchloc)                      ;make a positive i-var
  ipch      table     ipchloc,ipchfn,1            ;select from pch table
  icps      =  (ipch == 0 ? 0 : cpspch(ipch))     ;allow for 0s (rests)
  ilfac     =  i(kpan)+.5                         ;make positive
  ileft     =  sqrt(ilfac)                        ;"fill the hole...
  iright    =  sqrt(1-ilfac)                      ;...between the speakers"
if      (icps == 0) goto rest                     ;a table val of 0 = a rest
  irise     =  inrise*idur                        ;compute note rise time
  idecay    =  indec*idur                         ;compute note decay time
  isust     =  idur-irise-idecay                  ;sustain portion
  knote     expseg    .001,irise,1,isust,1,idecay,.001        
  asig      pluck     knote*iamp*ipkamp,icps,icps,0,1,0,0     
  asig      =  asig*kphrase                       ;apply the phrase envelope
            outs      asig*ileft,asig*iright      ;apply the panning
rest:
            timout    0,idur,exit                 ;timout can be anywhere,
            reinit    noteinit                    ;in the reinit block,
exit:
endin                                   ;which ends here.

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2



instr     1706 
  ipkamp    =  p4                                 ; INITIALIZATION BLOCK:
  idurfn    =  p5                                 ; THE POSSIBLE DURATIONS
  ipchfn    =  p6                                 ; THE POSSIBLE PITCHES
  iampfn    =  p7                                 ; AMP SCALING FUNCTION
  iprise    =  p8                                 ; PHRASE ENV RISE TIME
  ipdec     =  p9                                 ; PHRASE ENV DECAY TIME
  inrise    =  p10                                ; INDIVIDUAL NOTE AMP RISE
  indec     =  p11                                ; INDIVIDUAL NOTE AMP DECAY
  iseed1    =  p12                                ; FOR DURATION RAND UNIT
  iseed2    =  p13                                ; FOR PITCH RAND UNIT
  iseed3    =  p14                                ; FOR PANNING RAND UNIT
  ipkdur    =  .2501                              ; MAX EXPECTED DUR
                                             ; THE PHRASE ENVELOPE:
  kphrase   expseg    .001, iprise, 1, p3-iprise-ipdec, 1, ipdec, .001
  kdurloc   rand      .5, iseed1                  ; GET RANDOM TABLE INDICES
  kpchloc   rand      .5, iseed2                  ; BETWEEN -.5 AND +.5
  kpan      rand      .5, iseed3          
noteinit:
                                    ; START REINIT BLOCK
  idurloc   =  .5+i(kdurloc)                      ; MAKE POSITIVE i-time VAR
  idur      table     idurloc, idurfn, 1          ; SELECT FROM DUR TABLE
  iamp      table     idur/ipkdur, iampfn, 1      ; RELATE AMP TO DUR
  iamp      =  .25+.75*iamp                       ; AMP RANGE FROM .25 TO 1
  ipchloc   =  .5+i(kpchloc)                      ; MAKE A POSITIVE i-var
  ipch      table     ipchloc, ipchfn, 1          ; SELECT FROM PCH TABLE
  icps      =  (ipch==0?0:cpspch(ipch))           ; ALLOW FOR 0s (RESTS)
  ilfac     =  i(kpan)+.5                         ; MAKE POSITIVE
  ileft     =  sqrt(ilfac)                        ; "FILL THE HOLE...
  iright    =  sqrt(1-ilfac)                      ; ...BETWEEN THE SPEAKERS"
if        (icps==0) goto rest                     ; A TABLE VAL OF 0 = A REST
  irise     =  inrise*idur                        ; COMPUTE NOTE RISE TIME
  idecay    =  indec*idur                         ; COMPUTE NOTE DECAY TIME
  isust     =  idur-irise-idecay                  ; SUSTAIN PORTION
  knote     expseg    .001, irise, 1, isust, 1, idecay, .001
  asig      pluck     knote*iamp*ipkamp, icps, icps, 0, 1, 0, 0
  asig      =  asig*kphrase                       ; APPLY THE PHRASE ENVELOPE
            outs      asig*ileft, asig*iright     ; APPLY THE PANNING
rest:
            timout    0, idur, exit               ; TIMOUT CAN BE ANYWHERE
            reinit    noteinit                    ; IN THE REINIT BLOCK
exit:
endin                              ; WHICH ENDS HERE

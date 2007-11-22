  nchnls    =  2

instr     1
  icf       cpsmidi   
  ifc       =  sr/4                               ;HP CUTOFF DEFAULTS TO SR/4
  iq        =  15                                 ;Q OF FILTER, CAN'T BE ZERO
  ibw       =  icf/iq
  kgate     oscili    1,16,2,0
  kenv      oscili    1,1,3
  kpan      oscili    .5,1,4
  kpan      =  .5+kpan
  anoise    rand      32000
  asig      reson     anoise,icf,ibw,2            ;BAND PASS
  asig      atone     asig,ifc                    ;HIGH PASS
  asig      atone     asig,ifc                    ;SHARPLY
  asig      balance   asig,anoise
  asig      =  asig*kgate*kenv                    ;APPLY ENVELOPES AFTER BALANCE
  aleft     =  sqrt(kpan)
  aright    =  sqrt(1-kpan)

  imax      ampmidi   1, 100
  kgate     linenr    imax, 0, 1, .01
            outs      asig*aleft*kgate,asig*aright*kgate
endin

instr          2
  icps      cpsmidi   

  icps1     =  icps  * 1.649432                   ; CNTR FREQ FOR BANK OF FLTS
  icps2     =  icps1 * 1.649432
  icps3     =  icps2 * 1.649432


  arnd      rand      2000000                     ; WHITE NOISE
  aflt1     reson     arnd, icps1,500,1           ; BANK O' FILTERS
  aflt2     reson     aflt1,icps2,500,0
  aflt3     reson     aflt2,icps3,500,0
  kcf1      oscil1    0,icps,8,6                  ; VARY THE CENTER FREQUENCY
  kcfval    =  icps + kcf1
  kbw1      oscil1    0,icps,8,6                  ; AND THE BANDWIDTH
  kbwval    =  icps + kbw1
  aflt4     reson     aflt3,kcfval,kbwval,0       ; OF THIS FILTER
  abal      balance   aflt4,arnd
reset:
            timout    0,.05,contin                ; REPEAT SND EVERY .05 SECNDS
            reinit    reset
contin:
  asig      envlpx    abal,3/2,3,3/2,7,1,.01,.9
            rireturn  

  imax      ampmidi   1, 100
  kgate     linenr    imax, .02, .5, .001

  kpan      oscili    .5,.3,4
  kpan      =  .5+kpan
  aleft     =  sqrt(kpan)
  aright    =  sqrt(1-kpan)

            outs      asig*aleft*kgate,asig*aright*kgate
endin

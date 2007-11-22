  nchnls    =  2 

instr          1
  icps      cpsmidi   
  iamp      ampmidi   10000, 100
  aeg       linenr    iamp, .2, 1, .01
  a1        oscil     aeg, icps, 1
            outs      a1,a1
endin

instr          2
  icps      cpsmidi   
  iamp      ampmidi   9000, 100
  a2        linenr    iamp, .2, 2, .01
  k1        oscil     icps * .017, 6, 1
  a1        oscil     a2, icps + k1, 2
            outs      a1,a1
endin

instr          3

  itab      =  3
  iattack   =  .4
  irelease  =  .2
  iatdec    =  .01
  ifund     cpsmidi   
  iamp      ampmidi   1000, 100
  inumh     =  sr/2/ifund                         ; CREATES A BANDLIMITED PULSE
  ifun      =  1
  icutoff   =  ifund
  idur      =  1
  kvibrate  randh     1, 1                        ;RANDOMIZE RATE FROM 4 TO 6 HZ
  iv1       =  ifund*.03
  iv2       =  ifund*.04
  iv3       =  ifund*.05
  iv4       =  ifund*.06

  kvibf     linseg    0,idur/4,iv1,idur/4,iv2,idur/4,iv3,idur/4,iv4
  kvib      oscil     kvibf,  (kvibrate + 5), 1

  icfreqf1  table     0,itab
  icfreqf2  table     1,itab
  icfreqf3  table     2,itab
  icfreqf4  table     3,itab
 
  ibwf1     table     5,itab
  ibwf2     table     6,itab
  ibwf3     table     7,itab
  ibwf4     table     8,itab

  iampf1    table     10,itab
  iampf2    table     11,itab
  iampf3    table     12,itab
  iampf4    table     13,itab

  iampf1    =  iampf1 + dbamp(iamp)
  iampf2    =  iampf2 + dbamp(iamp)
  iampf3    =  iampf3 + dbamp(iamp)
  iampf4    =  iampf4 + dbamp(iamp)

  iampf1    =  ampdb(iampf1) + iamp
  iampf2    =  ampdb(iampf2) + iamp
  iampf3    =  ampdb(iampf3) + iamp
  iampf4    =  ampdb(iampf4) + iamp

  abuzz     buzz      1, ifund+kvib, inumh, ifun

  kampf1    linenr    iampf1, iattack, irelease, iatdec
  asigf1    reson     abuzz, icfreqf1, ibwf1
  asigf1    tone      asigf1, icutoff
  asigf1    =  kampf1 * asigf1

  kampf2    linenr    iampf2, iattack,  irelease, iatdec
  asigf2    reson     abuzz, icfreqf2, ibwf2
  asigf2    tone      asigf2, icutoff
  asigf2    =  kampf2 * asigf2

  kampf3    linenr    iampf3, iattack,  irelease, iatdec
  asigf3    reson     abuzz, icfreqf3, ibwf3
  asigf3    tone      asigf3, icutoff
  asigf3    =  kampf3 * asigf3

  kampf4    linenr    iampf4, iattack,  irelease, iatdec
  asigf4    reson     abuzz, icfreqf4, ibwf4
  asigf4    tone      asigf4, icutoff
  asigf4    =  kampf4 * asigf4

  asig      =  asigf1 + asigf2 + asigf3 + asigf4
            outs      asig,asig
endin


instr          4
  ifamp     =  .4                                 ; REL AMP: ATTACK TRANSIENT
  ivibamp   =  (1-.4)/2                           ; REL AMP: PHASING COMPONENT
  iamp      =  ivibamp                            ; REL AMP: FUND TIMBRE
  ifreq     cpsmidi   
  ifunc     =  9                                  ; FUNDAMENTAL TIMBRE FUNC
  iarand    =  .1
  ifrqrnd   =  15
  ifrqvib   =  .1
  ifrise    =  .02                                ; ATTACK TRANSIENT SPEED
  iat       =  .01                                ; FUNDAMENTAL ATTACK SPEED
  idec      =  6
  idelt     =  .1                                 ; DELAY TIME
  ifazamp   =  .002                               ; PHASING AMPLITUDE
  iatten    =  1
  ifazvib   =  .09                                ; PHASING SPEED
                                        
  kgate     envlpx    3000,iat,10,idec,8,iatten,.01
  kfgate    oscil1i   0,ifamp,ifrise,5            ; ATTACK ENVELOPE

  ifac      table     ifreq,6                     ; VIBRATO SCALING
  krand     randi     iarand,ifrqrnd,-1           ; VIBRATO RANDOM FACTOR
  kvib      oscil     krand+ifac,ifrqvib+krand,1  ; "BEATING" VIBRATO
  afazvib   oscili    ifazamp,ifazvib,1           ; "PHASING" VIBRATO 

  aform     oscili    kfgate,ifreq,4              ; 3 PHASING COMPONENTS
  avibsig   oscili    ivibamp,ifreq+kvib,ifunc
  asig      oscili    iamp,ifreq,ifunc                 

  ktrango   oscil1i   0,1,10*.2,7                 ; TRANSIENT REMOVAL GATE...
  adelin    =  (asig+avibsig)*ktrango             ; ...FOR THE DELAYED SIGNAL
  adelsig   delayr    idelt                       ; DELAY FOR PHASE FILTERING
  aphasig   deltapi   idelt-ifazamp+afazvib-.0001 ; SCALED WITHIN DEFINED... 
            delayw    adelin                      ; ...LIMITS

  imax      ampmidi   1, 100
  k2gate    linenr    imax, 0, 1, .001
            outs      (avibsig+asig+aform)*kgate*2*k2gate,aphasig*kgate*2*k2gate
endin

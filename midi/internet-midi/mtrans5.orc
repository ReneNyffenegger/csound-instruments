  sr        =  44100
  kr        =  2205
  ksmps     =  20
  nchnls    =  2


  ; PERCUSSIVE INSTRUMENT: THIS CODE FORMS A PITCHED PERCUSSION INSTRUMENT 
  ; BY USING WHITE NOISE AND A RESON FILTER. 
  
            massign   1,1

instr     1

  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc, 0, .2, .01

  ;idur        =         p3
  idur      =  13
  ;ifreq       =         cpsoct(.08333*(p4)+3)    ;FREQ IS IN MIDI NOTE NUMBER 
  ifreq     =  cpsoct(.08333*(127)+3)
  ;iamp        =         p5*252                   ;AMP IS IN MIDI VELOCITY 
  iamp      =  100*252
  ifq       =  2048                               ;FINAL Q
  iscale    =  iamp/33000
  ibeat     0                                     ;DETUNING IN BEATS

  ;isdur       table     p4, 3
  isdur     table     127, 3
  atak      rand      iamp
  ipq       table     iscale,2,1                  ;SCALE Q CHANGE TO AMP(% OF IFQ THAT YIELDS ISQ)
  isq       =  ifq*ipq                            ;OPENNING Q
  kqchng    expon     isq, idur, ifq              ;EXPONENTIALLY NARROWING FILTER Q
  kfchng    linseg    ibeat+ifreq, isdur, ifreq-ibeat, 13, ifreq-ibeat ;CREATE A BEATING, DOWNWARD GLISS
  ;af1sig      reson     atak, ifreq, ifreq/kqchng, 2
  af1sig    reson     atak, knote, ifreq/kqchng, 2
  ;af2sig      reson     atak, kfchng, ifreq/kqchng, 2
  af2sig    reson     atak, knote, ifreq/kqchng, 2
  arfsig    balance   af1sig, atak
  alfsig    balance   af2sig, atak
  iatm      table     iscale, 1, 1                ;SCALE ATTACK TIME TO AMP
  ktsig     expseg    .0001, iatm, 1, .01, 1, isdur-(.01+iatm), .00001, 13, .00001
            outs      (alfsig*ktsig*.5)*kgate, (arfsig*ktsig*.5)*kgate
endin 















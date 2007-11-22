  nchnls    =  2         

  ; PERCUSSIVE INSTRUMENT: THIS CODE FORMS A PITCHED PERCUSSION INSTRUMENT 
  ; BY USING WHITE NOISE AND A RESON FILTER. IDUR MUST EQUAL 12. NOTES LOWER
  ; THAN IBEAT IN CPS WILL BLOW UP. HIGHEST OCTAVE DOESN'T SOUND AS 
  ; REALISTIC. NOTE THAT PITCH AND AMPLITUDE ARE IN MIDI FORMAT. 
  
instr 1
            massign   1,1
  inote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc,0,.2,.01
  idur      =  12
  ifreq     =  inote
  iamp      =  100*252                
  ifq       =  2048                 
  iscale    =  iamp/33000
  ibeat     =  20                    
  ipq       table     iscale,2,1
  isq       =  ifq*ipq 
  isdur     table     inote, 3
  iatm      table     iscale,1,1
  
  atak      rand      iamp
  kqchng    expon     isq,idur,ifq
  kfchng    linseg    ibeat+ifreq,isdur,ifreq-ibeat,13,ifreq-ibeat
  af1sig    reson     atak,ifreq,ifreq/kqchng,2
  af2sig    reson     atak,kfchng,ifreq/kqchng,2
  arfsig    balance   af1sig,atak
  alfsig    balance   af2sig,atak
  ktsig     expseg    .001,iatm,1,.01,1,isdur-(.01+iatm),.0001
            outs      (alfsig*ktsig*.5)*kgate,(arfsig*ktsig*.5)*kgate
endin

instr          1

  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc,0,.2,.01

;idur          =         p6
  idur      =  .05
;kphrase       linen     1,.1,p3,1
  kphrase   linen     1,.1,5.5,1
;anoise        rand      p5
  anoise    rand      knote
;kcfrq         expseg    100,p3,10000
  kcfrq     expseg    100,5.5,10000
;afilt         reson     anoise,kcfrq,kcfrq*.1,2
  afilt     reson     anoise,knote,knote*1.2
startreinit:
            timout    0,idur,continue
            reinit    startreinit
continue:
  kenvlp    linen     1,.001,idur,idur-.001
            rireturn  
            out       (afilt*kenvlp*kphrase*5)*kgate
endin

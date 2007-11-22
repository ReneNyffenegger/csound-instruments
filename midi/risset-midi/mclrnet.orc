; RISSET'S CLARINET

instr          1

  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc,0,.2,.01

;i1            =              cpspch(p4)
  i1        =  cpspch(7.04)
  i2        =  .64
;if            p3 > .75       igoto start
if            .75 > .75      igoto start
;i2            =              p3-.085
  i2        =  .75-.085

start:
;a1            linen          255,.085,p3,i2
  a1        linen     255,.085,.75,i2
;a1            oscili         a1,i1,3
  a1        oscili    a1,knote,3
  a1        tablei    a1+256,1
               ;out           p5*a1
            out       (20000*a1)*kgate
endin

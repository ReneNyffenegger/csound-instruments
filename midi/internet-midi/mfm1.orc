; BASIC CHOWNING FM INSTRUMENT
; JOHN M. ARNOTT II
; 2/16/90


; P3=DURATION   P4=FUNDAMENTAL  P5=AMPLITUDE P6=FN#1    P7=PEAKINDEX
; P8=FN#2       P9=CARRIERFACT P10=MODFACTOR 

instr          1
            massign   1,1
  knote     cpsmidib  
  inote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc,0,.2,.01
  ifc       =  inote*5
  ifm       =  inote*7
  kindex    oscil1i   0,10,8,2
  kgate     oscil1i   0,1000,8,2
  amodsig   oscili    kindex*ifm, ifm, 1
  asig      oscili    kgate, ifc+amodsig, 1
            out       asig*kgate
endin

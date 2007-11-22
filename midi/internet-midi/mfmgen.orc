instr       1
            massign   1,1
  knote     cpsmidib  
  inote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc,0,.2,.01
  ihzu      =  inote                              ;U != L
  ihzl      =  inote
  in4       =  1
  in5       =  1
  in6       =  2
  in7       =  inote
  in8       =  inote
  in9       =  2
  in10      =  2
  in11      =  3
  in12      =  10000
  in13      =  2
  in14      =  3.2
if      in4=1   goto a                            ;NO REFLECTED GENERATOR
if      in4=2   goto b                            ;REFLECTED HZL

a:
if      in5=1   goto a1                           ;A1, A2 PRODUCE DIFFERENT TIMBRES WITH
if      in5=2   goto a2                           ;SAME GENERATORS WHICH ALSO SHARE SAME   
                                                ;MODULATOR BUT HAVE DIFFERENT CARRIERS
                                                ;(P9 AND P10 MUST BE SAME FOR A1 AND A2
                                                ;IN ORDER TO CREATE SUCH RELATED TIMBRES)

a1:
if      in6=1   goto a1a                          ;HZU, HZL SBS OF FUND OF MODULATOR
if      in6=2   goto a1b                          ;HZU, HZL SBS OF SEC PARTIAL OF MODULATORS                                     ;   of modulator
if      in6=3   goto a1c                          ;HZU SB OF FUND OF MOD, HZL SB OF SEC PARTIAL OF MOD
if      in6=4   goto a1d                          ;HZL SB OF FUND OF MOD, HZU SB OF SEC PARTIAL OF MOD     

a1a:
  iu        =  in9                                ;U=P9   
  il        =  in10*(-in9)                        ;CONSTANT FACTOR (P10) PRODUCES DIFFERENT
            goto      x                           ;TIMBRES WITH SAME GENERATORS WHICH ALSO
                                                ;SHARE SAME CARRIER BUT HAVE DIFFERENT
                                                ;MODULATORS (P5 MUST BE SAME FOR ALL         
                                                ;SUCH RELATED TIMBRES)

a1b:
  iu        =  in9*(in14/in13)                    ;P13=FUNDAMENTAL OF MODULATOR
  il        =  (in10*(-in9))*(in14/in13)          ;P14=SECOND PARTIAL OF MODULATOR
            goto      x
a1c:
  iu        =  in9
  il        =  (in10*(-in9))*(in14/in13)   
            goto      x
a1d:
  iu        =  in9*(in14/in13)
  il        =  in10*(-in9) 
            goto      x

a2:
if      in6=1   goto a2a
if      in6=2   goto a2b
if      in6=3   goto a2c
if      in6=4   goto a2d    
       
a2a:
  il        =  -in9              
  iu        =  in10*in9
            goto      x
a2b:
  il        =  -in9*(in14/in13)
  iu        =  (in10*in9)*(in14/in13)
            goto      x
a2c:
  il        =  -in9*(in14/in13)
  iu        =  in10*in9
            goto      x
a2d:
  il        =  -in9
  iu        =  (in10*in9)*(in14/in13)     
            goto      x

x:
  imod      =  (ihzu-ihzl)/(iu-il)
  icar      =  ihzu-(iu*imod)
            goto      z
     
b:
if      in5=1   goto b1
if      in5=2   goto b2
      
b1:
if      in6=1   goto b1a
if      in6=2   goto b1b
if      in6=3   goto b1c
if      in6=4   goto b1d    
b1a:
  iu        =  in9
  il        =  in10*(-in9)
            goto      y
b1b:
  iu        =  in9*(in14/in13)
  il        =  (in10*(-in9))*(in14/in13)
            goto      y 
b1c:
  iu        =  in9
  il        =  (in10*(-in9))*(in14/in13)
            goto      y
b1d:
  iu        =  in9*(in14/in13)
  il        =  in10*(-in9) 
            goto      y

b2:
if      in6=1   goto b2a
if      in6=2   goto b2b
if      in6=3   goto b2c
if      in6=4   goto b2d    
b2a:
  il        =  -in9              
  iu        =  in10*in9
            goto      y
b2b:
  il        =  -in9*(in14/in13)
  iu        =  (in10*in9)*(in14/in13)
            goto      y
b2c:
  il        =  -in9*(in14/in13)
  iu        =  in10*in9
            goto      y
b2d:
  il        =  -in9
  iu        =  (in10*in9)*(in14/in13)     
            goto      y

y:
  imod      =  (ihzu-(-ihzl))/(iu-il)
  icar      =  ihzu-(iu*imod)     
            goto      z

z:
  a1        oscili    imod*in11,imod,2            ;p11=index
  a1        oscili    in12,icar+a1,1              ;p12=amp
            out       a1*kgate
endin

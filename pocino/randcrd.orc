;  bug - probably the tone again

; 'randchrd.orc' 

  nchnls    =  2

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1
          
instr 1


  krandamp  randh     p5*2.5, p6, p5/10000
  krandpan  randh     0.5, p6, p5/15000
;ksmoothamp port    krandamp, 0.01
  ksmoothamp   port   krandamp, 0.04
  ksmoothpan   port   krandpan, 0.03
  atri      oscili    p4, p5, 1
  afiltered tone      atri, ksmoothamp + p5*0.8


  aout1     =  (ksmoothpan + 0.5) * afiltered
  aout2     =  (0.5 - ksmoothpan) * afiltered

            outs      aout1, aout2

endin

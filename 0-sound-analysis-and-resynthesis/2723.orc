  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1


instr     2723
  iosdur    =  p3
  imeth     =  p4
  ktimpt    line      0, iosdur, iosdur
  krmsr, krmso, kerr, kcps  lpread                ktimpt, "gong1_1.lpc"
if        (imeth == 1) goto method1
if        (imeth == 2) goto method2
if        (imeth == 3) goto method3
if        (imeth == 4) goto method4
method1:        
  asig      pluck     10000, 300+.1*kcps, 200, 0, 1
            goto      contin
method2:        
  asig      pluck     krmso, 300, 200, 0, 1
            goto      contin
method3:        
  asig      pluck     krmso, 300+.1*kcps, 200, 0, 1
            goto      contin
method4:        
  asig1     pluck     krmso, 300+.1*kcps, 200, 0, 1
  asig2     pluck     krmso, 300+50*kerr, 200, 0, 1
  asig      =  asig1+asig2
contin:     
            out       asig*p5
endin      


  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1


instr      2810
  iend      =  p4  
  ktime     line      0, p3, iend 
  kfreq1, kamp1       pvread  ktime, "hellorcb.pvx", 40   
  kfreq2, kamp2       pvread  ktime, "hellorcb.pvx", 45   
  aosc1     oscili    kamp1*1500, kfreq1*.40, 1   ;f1 is a sine
  aosc2     oscili    kamp2*1500, kfreq2*.45, 1   
            out       aosc1+aosc2 
endin

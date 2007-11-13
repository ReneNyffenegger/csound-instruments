  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1


instr     2802
  ifreqscale   =      1
  ispecwp   =  0
  ibeg      =  0    
  iend      =  p4                                 ; p4 = DURATION OF INPUT_SOUND
  ktime     line      iend, p3, ibeg              ; VALUES GO FROM END TO BEGINNING
  apv       pvoc      ktime, ifreqscale, "hellorcb.pvx", ispecwp
            out       apv
endin

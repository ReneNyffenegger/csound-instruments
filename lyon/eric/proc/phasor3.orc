  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  isamps    =  p4
  isi       =  sr/isamps
  icps      =  p5 * isi
  idev1     =  p6
  idev2     =  p7
  ispeed    =  p8
   
  idel      =  .1
  ifeed     =  .8
  ifs       =  .2
   
  kdevamp   linseg    idev1,p3,idev2
  kdev      oscil     kdevamp, ispeed, 1
  kdev      =  kdev * isi
  kfb       oscil     ifeed/2, ifs, 1
  kfb       =  kfb + ifeed/2
  aphs      phasor    icps+kdev
  aloop1    tablei    aphs*isamps, 2
  addl1     delayr    .2
  atap1     deltap    idel
            delayw    aloop1+(atap1*kfb)
            out       atap1
endin
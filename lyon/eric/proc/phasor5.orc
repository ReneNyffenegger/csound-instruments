  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

  gisigf    =  1                                  ; sound
  gidelf    =  2                                  ; delay time function
  gibendf   =  2                                  ; pitch bend function
  gifeedf   =  2                                  ; feedback function
  gideepf   =  2                                  ; pitch bend depth function

; all raised cos for func 2
instr 1
  isamps    =  p4
  isi       =  sr/isamps
  icps      =  p5 * isi
  ipbds     =  p6
  ipbs      =  p7
  ifbs      =  p8
  ids       =  p9
   
  imindel   =  p10
  imaxdel   =  p11
  imaxfeed  =  p12
  ipbmax    =  p13
  immdel    =  imaxdel-imindel
  ionetime  =  1/p3
   
  kdevamp   oscil     isi*ipbmax, ipbds, gideepf
  kdev      oscil     kdevamp, ipbs, gibendf
  kfb       oscil     imaxfeed, ifbs, gifeedf
  kdel      oscili    immdel, ids, gidelf
  kdel      =  kdel + imindel
  aphs      phasor    icps+kdev
  aloop1    tablei    aphs*isamps, gisigf
  addl1     delayr    .5
  atap1     deltapi   kdel
            delayw    aloop1+(atap1*kfb)
            out       atap1
endin
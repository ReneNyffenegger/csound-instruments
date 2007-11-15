  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

  gisigf    =  1                                  ; sound
  gidelf    =  2                                  ; delay time function
  gibendf   =  3                                  ; pitch bend function
  gifeedf   =  4                                  ; feedback function
  gideepf   =  5                                  ; pitch bend depth function

instr 1
  isamps    =  p4
  isi       =  sr/isamps
  icps      =  p5 * isi
  ispeed    =  p6
  ionetime  =  1/p3
  kdevamp   oscil     isi, ionetime, gideepf
  kdev      oscil     kdevamp, ispeed, gibendf
  kfb       oscil     1.0, ionetime, gifeedf
  kdel      oscili    1.0, ionetime, gidelf
  aphs      phasor    icps+kdev
  aloop1    tablei    aphs*isamps, gisigf
  addl1     delayr    .5
  atap1     deltapi   kdel
            delayw    aloop1+(atap1*kfb)
            out       atap1
endin
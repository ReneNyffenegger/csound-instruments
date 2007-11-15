  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

instr 1

  ifile     =  p4
  iskip     =  p5
  imide1    =  p6
  imade1    =  p7
  idspe1    =  p8
  imide2    =  p9
  imade2    =  p10
  idspe2    =  p11
  imife1    =  p12
  imafe1    =  p13
  ifesp1    =  p14
  imife2    =  p15
  imafe2    =  p16
  ifesp2    =  p17
  iseed1    =  p18
  iseed2    =  p19
  iseed3    =  p20
  iseed4    =  p21
; file skip mindel1 maxdel1 sp1 mindel2 maxdel2, sp2
; minfeed1 maxfeed1 fspeed
; sp2
  ipfac     =  p22
  imax1     =  imade1 * 2.
  ide1g     =  (imade1-imide1)/2.0
  ide1b     =  ide1g + imide1
  ife1g     =  (imafe1-imife1)/2.0
  ife1b     =  ife1g + imife1
  imax2     =  imade2 * 2.
  ide2g     =  (imade2-imide2)/2.0
  ide2b     =  ide2g + imide2
  ife2g     =  (imafe2-imife2)/2.0
  ife2b     =  ife2g + imife2

  idk       =  .05
  isust     =  p3-idk
  kenv      linseg    1,isust,1,idk,0
  a1        soundin   ifile, iskip
        
  kdel1     randh     ide1g, idspe1, iseed1
  kdel1     =  kdel1 + ide1b
  kdel1     port      kdel1, ipfac
  kfe1      randh     ife1g, ifesp1, iseed2
  kfe1      =  kfe1 + ife1b
  kfe1      port      kfe1, ipfac
  asnd1     =  a1      
  addl1     delayr    imax1
  atap1     deltapi   kdel1
  asnd1     =  asnd1 + (atap1*kfe1)
            delayw    asnd1

  kdel2     randh     ide2g, idspe2, iseed3
  kdel2     =  kdel2 + ide1b
  kdel2     port      kdel2, ipfac
  kfe2      randh     ife2g, ifesp2, iseed4
  kfe2      =  kfe2 + ife2b
  kfe2      port      kfe2, ipfac
  asnd2     =  a1      
  addl2     delayr    imax2
  atap2     deltapi   kdel2
  asnd2     =  asnd2 + (atap2*kfe2)
            delayw    asnd2
            outs      atap1*kenv, atap2*kenv
endin
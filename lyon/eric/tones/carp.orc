  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
;i1 0 dur freq amp depth seed1 seed2 seed3
;with current settings duration must be > .5
  ifreq     =  p4
;ifreq = cpspch( p4 )
  iamp      =  (p5 * 10000) * ( ifreq / 200 ) 
  iamp1     =  iamp * .1
  ifile     =  0
  imeth     =  1
  irou      =  1
  istr      =  .8
  ia1       =  .2
  ia2       =  .1
  id        =  .2
  is        =  p3-(ia1+ia2+id)
  iseed1    =  p7
  iseed2    =  p8
  iseed3    =  p9
  idfac     =  p6
  idmax1    =  .02 * idfac
  idmax2    =  .015 * idfac
  idmax3    =  .01 * idfac
  idmin1    =  idmax1 * .1
  idmin2    =  idmax2 * .1
  idmin3    =  idmax3 * .1

  karpen    linseg    0, ia1, iamp1, ia2, iamp, is, iamp, id, 0
  akarp     pluck     karpen,ifreq,ifreq,ifile,imeth,irou,istr

  kdev1     line      idmax1, p3, idmin1
  kdev2     line      idmax2, p3, idmin2
  kdev3     line      idmax3, p3, idmin3
  kdel1     randi     kdev1 ,2.95,iseed1
  kdel2     randi     kdev2, 3.25,iseed2
  kdel3     randi     kdev3 ,4.77,iseed3
  kdel1     =  kdel1 + .05
  kdel2     =  kdel2 + .035
  kdel3     =  kdel3 + .02

  aeffect   delayr    .3
  atap1     deltapi   kdel1
  atap2     deltapi   kdel2
  atap3     deltapi   kdel3
            delayw    akarp
  asharp    =  atap1+atap2+atap3+akarp
  aout      atone     asharp, 15

            out       aout
endin

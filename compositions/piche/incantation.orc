  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr   4
  gkpit     rand      .005
endin


instr   1
  ilast     =  2
  iseed     =  p6
  ivib      =  .03*iseed
  ivoi      =  p8

  krik      rand      8,.38413*iseed
  kpik      rand      2,.5765*iseed

newvalue:

  idu       table     i(krik) ,34,0,0,1
  ipi       table     i(kpik+ilast),33,0,0,1
  kpi       =  cpspch(ipi+p11)
  ipo       =  cpspch(ipi+p11)
  kvibenv   expseg    ipo*.001,1.5,ipo*ivib,idu-2,ipo*ivib, .5, ipo*.015 
  kbend     rand      .3,.89*iseed
  kford     rand      1.5,.0345*iseed
  ibend     =  i(kbend+.33)*i(kbend+.33)+.02
  igli      =  (idu/2)+.2
  ishifsp   =  (i(kford+1.5)*i(kford+1.5)/idu)+.2
  ilast     =  i(kpik+ilast)

            timout    0,idu,go
            reinit    newvalue
            rireturn  
go:
  kpi       port      kpi,ibend,cpspch(ipi+p11)
  kam       randh     .45, 1,.46543*iseed
  kam       port      kam+.55,.5,p7


  kshif     randh     5,ishifsp,-.4478*iseed
  kshif     =  int(kshif+5)*9

  kind      =  kshif
  kif0      =  kpi *(1+i(gkpit))
  iind      =  (p5*9)-9

  ifif1     table     iind,ivoi,0
  ifif2     table     iind+1,ivoi,0
  ifif3     table     iind+2,ivoi,0
  iria1     table     iind+3,ivoi,0
  iria2     table     iind+4,ivoi,0
  iria3     table     iind+5,ivoi,0

  kdev1     table     kind+6,ivoi,0
  kdev2     table     kind+7,ivoi,0
  kdev3     table     kind+8,ivoi,0

  kdev1     randh     kdev1/2,ishifsp,.0980*iseed
  kdev2     randh     kdev2/2,ishifsp,.6983*iseed
  kdev3     randh     kdev3/2,ishifsp,.4*iseed

  kfif1     table     kind,ivoi,0
  kfif2     table     kind+1,ivoi,0
  kfif3     table     kind+2,ivoi,0
  kria1     table     kind+3,ivoi,0
  kria2     table     kind+4,ivoi,0
  kria3     table     kind+5,ivoi,0
    
  kif1      port      kfif1+kdev1,igli,ifif1
  kif2      port      kfif2+kdev2,igli,ifif2
  kif3      port      kfif3+kdev3,igli,ifif3
  kia1      port      kria1-10,igli,iria1
  kia2      port      kria2,igli,iria2
  kia3      port      kria3,igli,iria3

  krandvib  randi     .2,3.5,iseed*.123
; kvibenv expseg p4*.001,1.5,p4*ivib,p3-.35,p4*ivib,1,p4*.015
  kvib      oscil     kvibenv,5.5*(1+krandvib),4
    
  kenv      linseg    0.001,.1+p3*.1,1,p3-(.2+p3*.25),1,.1+p3*.15,0.001 

  kdev      randi     .009,12,iseed*.765
  kdev      =  1+kdev
  kpit      linseg    .95,.1,1,p3-.2,1,.1,0.92


  kpitch    =  kdev*kif0*kpit+kvib

  ar        fof       ampdb(kia1)*kenv*kam, kpitch, kif1, 0, 50, .0025, .025, .007, 50, 1, 2, p3
  ar1       fof       ampdb(kia2)*kenv*kam*kam, kpitch, kif2, 0, 100, .0025, .025, .007, 50, 1, 2, p3
  ar2       fof       ampdb(kia3)*kenv*kam*kam*kam, kpitch, kif3, 0, 150, .0025, .025, .007, 50, 1, 2, p3
  ar3       fof       ampdb(kia3)*kenv*kam*kam*kam*.7, kpitch, kif3+1000, 0,150, .0025, .025, .007, 50, 1, 2, p3

            out       (ar+ar1+ar2)+ar3
endin

instr   15
  kmod      expseg    p5,.0151,p5*.1,p3*0.9,.005
  asid      foscil    ampdb(p5),cpspch(p4),2.380,3.967,kmod,1 
  agon      expseg    0.001,.0151,1,.1,.7,p3*0.9,.005 
            out       (asid)*agon
endin


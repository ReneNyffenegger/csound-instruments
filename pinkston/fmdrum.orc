
  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  2

;Simple FM drum instrument using foscil
;Built in class on 09/28/06

instr   1       ;FM Percussion Instr
  ipkamp    =  ampdb(p4)
  ibasoct   =  octpch(p5)
  icarfac   =  p6
  imodfac   =  p7
  imaxbnd   =  p8
  itrdur    =  p9
  itridur   =  itrdur*.75                         ;slightly shorter index envelope duration
  itrbdur   =  itrdur*1.5                         ;slightly longer pitch bend duration
  iendbnd   =  p10
  indx1     =  p11
  indx2     =  p12
  isusamp   =  ampdb(p13)
  kbend     linseg    imaxbnd,itrbdur,iendbnd,1,iendbnd ;pitch bend in oct
  koct      =  ibasoct+kbend
  kcarhz    =  cpsoct(koct*icarfac)
  kmodhz    =  cpsoct(koct*imodfac)
  kndx      expseg    indx1,itridur,indx2,p3-itridur,indx2
  aamp      expseg    ipkamp,itrdur,isusamp,p3-itrdur,.01
  asig      foscili   aamp,cpsoct(ibasoct+kbend),icarfac,imodfac,kndx,1       
            outs      asig,asig
endin
;ORC CODE OF AN ECLECTIC INSTRUMENT I CALL THE SHBASHRINGER
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

instr 1
  ipitch    =  cpspch(p4)
  iloud     =  (ipitch<440?10000:14000)
  kvib      line      ipitch*.02,p3,ipitch* -0.02
  kias      =  ipitch*kvib
  klate     line      1,p3,10000
  kline     line      iloud,p3,1
  krise1    line      1,p3,2500
  krise2    line      2500,p3,1
  irise     =  (p3>1?p3/3:p3/6)
  idur      =  p3/3
  idec      =  (p3>2?p3/3:p3/6)
  kamp      =  (p3>1?8000:6000)
  klamp     linen     kamp, irise, idur, idec
  a1        oscil     klamp/4,kias,1              ;reed 
  a2        oscil     klamp/4, kias,2             ;string 
  a3        pluck     kline,ipitch/2,ipitch/3,3,3,0
  a4        pluck     kline*.5,ipitch*.33,ipitch*.24,0,4,0,4
  a5        pluck     klate,ipitch,ipitch*.5,0,4,1,4 
  a6        fof       krise1,a4,84,0,25,.003,.02,.007,500,2,4,p3,.5,2 ;deceased choir boy 1
  a7        fof       krise2,a5,110,0,55,.003,.02,.007,500,2,4,p3,.5,2 ;deceased choir boy 2
  aleft     =  a7+a5+a3+a1
  aright    =  a6+a4+a2
            outs      aleft,aright
endin

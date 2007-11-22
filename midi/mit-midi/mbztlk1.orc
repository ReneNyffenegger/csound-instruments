;BUZZTALK - TEST OF TERM ANALGOUE MODEL OF SPEECH
;USES SLAWSON'S FORMANTS

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2


            massign   1,1
instr          1

  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc,0,2,.01

  a1        buzz      2000,knote,20,1             ;p4=amp,p5=cps,p6=knh
  a2        reson     a1,800,150,1,0
  a3        reson     a1,1300,150,1,0
  a4        reson     a1,2500,200,1,0
  a5        reson     a1,2500,300,1,0

  a6        balance   (a2+a3+a4+a5),a1
            outs      a6*kgate, a6*kgate
  ga1       =  a6*kgate
endin







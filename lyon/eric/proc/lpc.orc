  sr        =  44100
  kr        =  44100
  ksmps     =  1

;i1 0 dur file skip
instr 100
endin
instr 1
  ilast     =  p3
  ifile     =  p4
  iskip     =  p5
  asig      soundin   ifile,iskip
        ;asig = asig * .001
        ;anoise randi 1000,20000,.666 ; noise source
        ;asig oscili 1000,70.0,1
        ;asig = asig+anoise
  ktimpt    line      0,p3,p3
  krmsr,krmso,kerr,kcps lpread                    ktimpt,1 ;file = lp.1
  ar        lpreson   asig
            out       ar*.01
endin

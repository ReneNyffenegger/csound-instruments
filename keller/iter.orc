  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1
          
instr 1
; Synthesis by Functional Iterations
; instrument based on an article by Di Scipio & Prignano
; Journal of New Music Research, vol.25 (1996), pp. 31-46

  kcount    =  0                                  ; COUNTER FOR ITERATIONS. KEEP inb SMALL TO REDUCE PROCESSING TIME!
  ifreq     =  cpspch(p4)
  inb       =  p5
  ir1       =  p6
  irf       =  p7
  ix1       =  p8
  ixf       =  p9
  imaxvol   =  10000                              ; YOU´D BETTER NORMALIZE IT FOR R>3.14

  arenv     linseg    0,.01,1,p3-.11,.6,.1,0
  aosc      oscili    1, ifreq, 1
  aosc      =  (1+ aosc)/2
  ar        =  ir1 + (irf-ir1)*arenv*aosc         ; CYCLIC AR TO GET AN ARBITRARY PITCHED WAVE

  avibosc   oscili    1, 5, 1
  avibosc   =  (1+avibosc)/2
  axenvibr  linseg    0, .5, 0, .5, 1, p3-1, 1    ; TIMBRAL MODULATION BY CHANGING INITIAL CONDITIONS
  ax        =  ix1+(ixf-ix1)*axenvibr*avibosc

iter:
  ax        =  sin(ar * ax)                       ; DOESN´T REALLY MATTER THE FUNCTION USED... TRY OTHERS AS WELL!
  kcount    =  kcount + 1
if        kcount < inb goto iter
out: 
            out       20000* ax*arenv-10000
endin

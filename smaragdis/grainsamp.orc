;  bug - it has to be the randh.  It used to work fine.
;  rand workis fine too.  In this case, explosion at the onset!

; Rick

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1
          
instr 1
  insnd     =  10
  ibasfrq   =  sr / ftlen(insnd)                  ; USE ORIGINAL SAMPLE RATE OF insnd FILE
; kamp    expseg    4000, p3/2, 4000, p3/2, 8000
  kamp      randh     8000, 20
  kpitch    line      ibasfrq, p3, ibasfrq * 4
  kdens     line      500, p3, 25
  kaoff     line      0, p3, 8000
  kpoff     line      0, p3, ibasfrq * .5
  kgdur     line      .4, p3, .01
  imaxgdur  =  .5
  asig      grain     kamp, kpitch, kdens, kaoff, kpoff, kgdur, insnd, 5, imaxgdur, 0
            out       asig
endin

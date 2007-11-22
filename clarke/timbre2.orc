;timbre2.orc
  sr        =  44100
  kr        =  2100
  ksmps     =  21
  nchnls    =  2

instr          1
  i1        =  sr/ftlen(3)                        ;FACTOR FOR SR/TABLELENGTH
  k2        linseg    16 ,p3*.3 ,.5 ,p3*.3 ,16 ,p3*.4 ,16 ;ENVELOPE FOR SPEED
  a5        phasor    i1/k2                       ;PHS FOR SPEED
  a1        phasor    i1
  a1        rand      .5
  a1        =  (a1 -.5)*i1*.014                   ;(RAND 0 -> -1) * SCALING FOR SR/TABL(* PARAM VALUE)
  a5        =  a5 - a1                            ;RANDOM VRTN TO OFFSET
  k1        rand      .018                        ;DUR RNG = 18MS
  k1        =  k1 + .04                           ;DUR = 40 MS (WITH RANDOM VARTN)
  a2        linseg    .96 ,p3*.2 ,.2 ,p3*.4 ,3 ,p3*.2 ,1 ,p3*.2 ,1 ;PTCH ENVELOPE
;              amp            dens ptc spd    oct bnd tex dur dbt  olps fna fnb dur phs mod
  a4        fog       5000 ,p4   ,a2  ,a5  ,0  ,0 ,.01 ,k1 ,.01 ,32 ,3  ,2  ,p3 ,0  ,0
            outs      a4 ,a4
endin

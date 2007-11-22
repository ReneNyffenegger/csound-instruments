;timbre3.orc
  sr        =  44100
  kr        =  2100
  ksmps     =  21
  nchnls    =  1

instr 1
  a7        linseg    0 ,.1 ,5000 ,p3-.2 ,5000 ,.1 ,0 ;ENVELOPE
  i2        =  .31                                ;CORRECTION FOR TABLE LENGTH
  k3        linseg    1 ,p3/2 ,0 ,p3/2 ,0         ;SCLAR FOR RANDOMNESS
  i1        =  sr/ftlen(3)                        ;FACTOR FOR SR/TABLELENGTH
  k2        =  p5
  a5        phasor    (i1/k2) / i2                ;PHS FOR SPEED, CORRECTED FOR TABLE LENGTH
  a5        =  a5 * i2                            ;CORRECTION FOR TABLE LENGTH
  a3        linseg    p4 ,p3*.8 ,100 ,p3*.2 ,100
  a1        rand      .5
  a3        =  a3 + (a3 * a1*k3)
  a8        linseg    p6*p7 ,p3*.7 ,p6 ,p3*.3 ,p6
  a6        =  a8 + (a8*a1*k3)
;                   amp dens ptc spd  oct bnd tex dur   dbt olps fna fnb dur phs mod
  a4        fog       a7 ,a3  ,a6  ,a5  ,0  ,0 ,.01 ,.02 ,.01 ,32 ,3 ,2  ,p3 ,0   ,0
            out       a4*3
endin

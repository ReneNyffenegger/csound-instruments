;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;         BASIC KOTO ORCHESTRA FILE                              ;
;                                                                ;
;         P3 = DURATION        P4 = AMPLITUDE                    ;
;         P5 = PITCH IN PCH    P6 = PITCH BEND IN OCT.DECIMAL    ;
;                                                                ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1 

instr     1
  ihz       =  cpspch(p5)
  ihz2      =  ihz * 2.0006
  ihz3      =  ihz * 1.9999
  ihz4      =  ihz * 1.0005
  ihz5      =  ihz * .9998
  koct      init      octcps(ihz)
  koct2     init      octcps(ihz2)
  koct3     init      octcps(ihz3)
  koct4     init      octcps(ihz4)
  koct5     init      octcps(ihz5)
  kbend     oscil1i   0.00,p6,p3,4                ;    /* p6 in oct.decimal */
  khz       =  cpsoct(koct+kbend)
  khz2      =  cpsoct(koct2+kbend)
  khz3      =  cpsoct(koct3+kbend)
  khz4      =  cpsoct(koct4+kbend)
  khz5      =  cpsoct(koct5+kbend)
  ibuf      =  (p5 < 7.00 ? ihz : ihz/2)
  aplk1     pluck     (p4*.62),khz,ibuf,6,4,1, 1.003
            timout    0.0,.002,continue
koto2:
  aplk2     pluck     (p4*.52),khz2,ibuf,6,3,1
            timout    0.0,.004,continue
koto3:
  aplk3     pluck     (p4*.52),khz3,ibuf,6,3,1
            timout    0.0,.005,continue
koto4:
  aplk4     pluck     (p4*.62),khz4,ibuf,6,4,1, 1.001
            timout    0.0,.007,continue
koto5:
  aplk5     pluck     (p4*.62),khz5,ibuf,6,4,1, 1.001
continue:
  asignal   =  aplk1+aplk2+aplk3+aplk4+aplk5
  asig      envlpx    asignal,.06,p3,(p3*.1),7,.66,.008
            out       asig
endin

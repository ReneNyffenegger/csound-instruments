;         BASIC KOTO ORCHESTRA FILE                              ;
;                    GARTH MOLYNEUX                              ;
;                                                                ;
;   THIS KOTO INSTRUMENT ALLOWS FOR PITCH BEND IN EITHER         ;
;   DIRECTION AT THE END OF THE NOTE.                            ;
;                                                                ;
;         P3 = DURATION        P4 = AMPLITUDE                    ;
;         P5 = PITCH IN PCH    P6 = PITCH BEND IN OCT.DECIMAL    ;
;                                                                ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr          1
            massign   1,1
  knote     cpsmidib  
  inote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc,0,.2,.01
  ihz       =  inote
  ihz2      =  ihz*2.0006
  ihz3      =  ihz*1.9999
  ihz4      =  ihz*1.0005
  ihz5      =  ihz*.9998
  koct      init      octcps(ihz)
  koct2     init      octcps(ihz2)
  koct3     init      octcps(ihz3)
  koct4     init      octcps(ihz4)
  koct5     init      octcps(ihz5)
  kbend     oscil1i   0.15,-.25,3,4
  khz       =  cpsoct(koct+kbend)
  khz2      =  cpsoct(koct2+kbend)
  khz3      =  cpsoct(koct3+kbend)
  khz4      =  cpsoct(koct4+kbend)
  khz5      =  cpsoct(koct5+kbend)
  aplk1     pluck     (5500*.62),khz,ihz,0,3,0
            timout    0.0,.002,continue
koto2:
  aplk2     pluck     (5500*.62),khz2,ihz2,0,3,0
            timout    0.0,.004,continue
koto3:
  aplk3     pluck     (5500*.62),khz3,ihz3,0,3,0
            timout    0.0,.005,continue
koto4:
  aplk4     pluck     (5500*.62),khz4,ihz4,0,3,0
            timout    0.0,.007,continue
koto5:
  aplk5     pluck     (5500*.62),khz5,ihz5,0,3,0
continue:
  asignal   =  aplk1+aplk2+aplk3+aplk4+aplk5
  asig      envlpx    asignal,.0001,3,(3*.1),2,.999,.008
            out       asig*kgate
endin

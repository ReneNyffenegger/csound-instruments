;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;         basic koto orchestra file                              ;
;                                                                ;
;         p3 = duration        p4 = amplitude                    ;
;         p5 = pitch in pch    p6 = pitch bend in oct.decimal    ;
;                                                                ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  nchnls    =  2 

            massign   1,1

instr         1

  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc, 0, .2, .01

     ;ihz           =              cpspch(p5)
  ihz       =  cpspch(7.06)
  ihz2      =  ihz * 2.0006
  ihz3      =  ihz * 1.9999
  ihz4      =  ihz * 1.0005
  ihz5      =  ihz * .9998
  koct      init      octcps(ihz)
  koct2     init      octcps(ihz2)
  koct3     init      octcps(ihz3)
  koct4     init      octcps(ihz4)
  koct5     init      octcps(ihz5)
     ;kbend         oscil1i        0.15,p6,p3,4;   /* p6 in oct.decimal */
  kbend     oscil1i   0.15,0.00,1.5,4
  khz       =  cpsoct(koct+kbend)
  khz2      =  cpsoct(koct2+kbend)
  khz3      =  cpsoct(koct3+kbend)
  khz4      =  cpsoct(koct4+kbend)
  khz5      =  cpsoct(koct5+kbend)
     ;aplk1         pluck          (p4*.62),khz,ihz,6,4,1, 1.01
  aplk1     pluck     (10000*.62),knote,ihz,6,4,1, 1.01    
            timout    0.0,.002,continue
;koto2:  aplk2      pluck          (p4*.62),khz2,ihz2,6,4,1, 1.005
koto2:
  aplk2     pluck     (10000*.62),knote,ihz2,6,4,1, 1.005
            timout    0.0,.004,continue
;koto3:  aplk3      pluck          (p4*.62),khz3,ihz3,6,4,1, 1.003
koto3:
  aplk3     pluck     (10000*.62),knote,ihz3,6,4,1, 1.003
            timout    0.0,.005,continue
;koto4:  aplk4      pluck          (p4*.62),khz4,ihz4,6,4,1, 1.002
koto4:
  aplk4     pluck     (10000*.62),knote,ihz4,6,4,1, 1.002
            timout    0.0,.007,continue
;koto5:  aplk5      pluck          (p4*.62),khz5,ihz5,6,4,1, 1.001
koto5:
  aplk5     pluck     (10000*.62),knote,ihz5,6,4,1, 1.001

continue:
  asignal   =  aplk1+aplk2+aplk3+aplk4+aplk5
     ;asig          envlpx         asignal,.06,p3,(p3*.1),4,.66,.008
  asig      envlpx    asignal,.06,1.5,(1.5*.1),4,.66,.008
            outs      asig*kgate,asig*kgate
endin



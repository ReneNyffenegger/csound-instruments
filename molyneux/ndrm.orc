;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;        noisy  drum orchestra file                    ;
;                                                      ;
;    p3 = duration                           ;
;    p4 = amplitude                          ;
;    p5 = pitch in pch                                 ;
;    p6 = pitch bend in oct                  ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr     1
  ipitch    =  cpspch(p5)
  kpchg     oscil1i   0.41, p6, (p3-0.41), 3
  kpitch    =  cpsoct(kpchg + (octpch(p5)))
  kamp      envlpx    p4, .03, p3, (p3 *.96), 2, .86, .005
  kbwchg    oscil1i   0.00,(ipitch * 0.6), p3, 2
  kbw       =  kbwchg + (ipitch * 0.1)
  arnd      rand      kamp, -1
  aflt11    reson     (arnd*.6), kpitch, kbw, 2
  aflt12    reson     (arnd*.8), (kpitch * 1.5), (kbw*1.2), 2
  aflt13    reson     (arnd*1.0), (kpitch * 3), (kbw*1.9), 2
  aflt21    reson     aflt11, kpitch, kbw, 1
  aflt22    reson     aflt12, (kpitch * 1.5), (kbw*1.2), 1
  aflt23    reson     aflt13, (kpitch * 3), (kbw*1.9), 1
  abal      balance   aflt21+aflt22+aflt23, arnd
  aplk      pluck     p4, kpitch, ipitch, 0, 4, 0.5, 1.11
  asig      =  (abal * .68) + (aplk * .39)
            out       asig
endin

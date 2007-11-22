; FILTERDRUM.ORC

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

; p3    =               duration
; p4    =               amplitude
; p5    =               pitch in pch
; p6    =               pitch bend in oct

instr   1                                                                       ; filtered/stretched drum

  ipitch    =  cpspch(p5)                         ; converts pitch to cps
  kpchg     oscil1i   0.41, p6, (p3 - 0.1), 3
  kpitch    =  cpsoct(kpchg + (octpch(p5)))       ; converts oct to cps
  kamp      linen     p4, .3, p3, (p3 *.84)       ; kamp, irise, idur, idec
  kbwd      oscil1i   0.5, (ipitch * 0.6), p3, 2  ; bandwidth description
  kbw       =  kbwd + (ipitch * 0.1)
  arnd      rand      kamp, -1                    ; amp, seed
  aflt1     reson     (arnd * .4), kpitch, kbw, 2 ; filter set 1
  aflt2     reson     (arnd * .6), (kpitch * 1.5), (kbw * .9), 2 ; asig, center frq, band width, fdback
  aflt3     reson     (arnd * 1.3), (kpitch * 3), (kbw  * 1.7), 2
  aflt4     reson     aflt1, kpitch, kbw, 1       ; filter set 2
  aflt5     reson     aflt2, (kpitch * .5), (kbw*1.2), 1
  aflt6     reson     aflt3, (kpitch * 2), (kbw*1.9), 1
  abal      balance   aflt4 + aflt5 + aflt6, arnd ; balance filtered signal with rand
  aplk      pluck     p4, kpitch, ipitch, 0, 4, 0.5, 1.11 ; Karplus-Strong stretched drum
                                                                                                        ; algorithm:  amp, kcps, icps, f#,
                                                                                                        ; meth, roughness, stretch
  asig      =  (abal * .68) + (aplk * .39)        ; add filtered signal to drum
            outs      asig, asig
endin


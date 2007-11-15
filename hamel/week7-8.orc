
; ORQUESTRA FILE
 
  sr        =  44100
  kr        =  4410
  ksmps     =  10.0


instr 1
  iptch     =  cpspch(p5)                         ; centrepitch
  iwidth    =  iptch * .01                        ; width = 1 /100 of cps
  kenv1     linseg    1, p3, 0                    ; ramp envelope
  kran      randh     iwidth, kr                  ; generate range of iwidth
  kran      =  kran + iptch                       ; centre on iptch
  asig      oscil     kenv1 * p4, kran, 1         ; noise oscillator
            out       asig
endin



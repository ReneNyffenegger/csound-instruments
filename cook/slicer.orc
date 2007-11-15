  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  1

instr    1 ; Advances through a sample by repeating slices

  ilevl     =  p4*32767                           ; Output level
  irate     =  p5                                 ; Slicing rate (Hz)
  ishift    =  p6                                 ; Distance traversed through sample
  istep     =  irate*p3                           ; Number of steps
  ileng     =  ftsr(1)/ftlen(1)                   ; Sample length

  kstep     oscili    istep, 1/p3, 2              ; Generate ramp at 1/p3
  kstep     =  (int(kstep))/(istep - 1)           ; Quantise ramp
  kramp     oscili    1/irate, irate, 2           ; Generate ramp at irate
  kenv      oscili    1, irate, 3                 ; Generate envelope
  kind      =  (kstep*ishift + kramp)*ileng       ; Calculate and scale index
  asamp     table3    kind, 1, 1, 0, 1            ; Sample indexing
            out       asamp*kenv*ilevl            ; Calculate, scale and output

endin
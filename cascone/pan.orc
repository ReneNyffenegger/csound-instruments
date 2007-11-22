  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2    

  garvb     init      0

instr 3
  iamp      =  p4
  icps      =  p5
  icar      =  p6
  imod      =  p7
  indx      =  p8                      
  irvb      =  p9
  ipan      =  p10
  afm       foscili   iamp, icps, icar, imod, indx, 11
  asig      oscil     afm, 1/p3, 18
            outs      asig*ipan, asig*(1-ipan)
  garvb     =  garvb+(asig*irvb)
endin

instr 4
  iamp      =  p4
  icps      =  p5
  icar      =  p6
  imod      =  p7
  indx      =  p8                      
  irvb      =  p9
  ipan      =  p10
  afm       foscili   iamp, icps, icar, imod, indx, 11
  asig      oscil     afm, 1/p3, 18
  irtl      =  sqrt(ipan)                         ; SQRT PANNING TECHNIQUE
  irtr      =  sqrt(1-ipan)                       ; pg 247,fig.7.20 DODGE/JERSE BOOK
            outs      asig*irtl, asig*irtr
  garvb     =  garvb+(asig*irvb)
endin
                                                                                          
instr 5
  iamp      =  p4
  icps      =  p5
  icar      =  p6
  imod      =  p7
  indx      =  p8                      
  irvb      =  p9
  ipan      =  p10
  afm       foscili   iamp, icps, icar, imod, indx, 11
  asig      oscil     afm, 1/p3, 18
  irtl      =  sqrt(2)/2*cos(ipan)+sin(ipan)      ; CONSTANT POWER PANNING
  irtr      =  sqrt(2)/2*cos(ipan)-sin(ipan)      ; FROM C.ROADS "CM TUTORIAL" pp460
            outs      asig*irtl, asig*irtr
  garvb     =  garvb+(asig*irvb)
endin

instr 99
  asig      nreverb   garvb, p4, p5
            outs      asig, asig
  garvb     =  0
endin

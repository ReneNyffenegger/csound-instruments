  sr        =  44100
  kr        =  4410
  ksmps     =  10
  gisine    =  1
  gitri     =  2
  gisaw     =  3
  gisquare  =  4
  gipulse   =  5

instr 99
  a1        =  0
  a2        =  0
  a3        =  0
  a4        =  0
  a5        =  0
endin

instr 1
  k1        randh     1.0, 0.65378450830467, 0.9351
  k1        =  182.0299+((454.9648-182.0299)*((k1+1.)/2.))
  a1        oscil     1.0,k1,gisine
  a2        oscil     1.0,435.091878958046436,gisine
  a3        oscil     1.0,1234.921091175638139,gisine
  a4        oscil     1.0,8.949099418311381,gisine
  a5        =  a4 * a1*a2*a3
            out       a5*30000.00
endin

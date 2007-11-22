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
  a6        =  0
  a7        =  0
endin

instr 1
  k1        randh     1.0, 0.776266812952235, 0.9458
  k1        =  183.2048+((518.9897-183.2048)*((k1+1.)/2.))
  a1        oscil     1.0,k1,gitri
  a2        oscil     1.0,280.254603698849678,gisquare
  a3        oscil     1. * (1+a2),938.620902188122272,gisquare
  a4        oscil     1.0,280.254603698849678,gisquare
  a5        oscil     1.0 * (1+a4),938.620902188122272,gisquare
  a6        oscil     1.0,15.149003965221345,gisine
  a7        =  a6 * (a1+a3+a5)*.2
            out       a7*30000.00
endin

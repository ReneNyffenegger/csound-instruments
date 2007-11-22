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
endin

instr     1
  a1        oscil     1.0,853.472497877664864,gisine
  a2        oscil     1.0,935.97927950322628,gisquare
  a3        oscil     1.0 * (1+a2),1043.709940351545811,gisquare
  a4        oscil     1.0,3091.42767122015357,gisine
  a5        oscil     1.0,11.936452026432381,gisine
  a6        =  a5 * a1*a3*a4
            out       a6*20000.00
endin

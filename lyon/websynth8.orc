  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

  gisine    =  1
  gitri     =  2
  gisaw     =  3
  gisquare  =  4
  gipulse   =  5

instr 99
  a1        =  0
  a2        =  0
  a3        =  0
  k3        =  0
  a5        =  0
  a6        =  0
  k6        =  0
  a8        =  0
  a9        =  0
  a4        =  0
  a7        =  0
endin

instr 1
  k1        randh     1.0, 0.440050051547587, 0.6162
  k1        =  137.6793+((358.3679-137.6793)*((k1+1.)/2.))
  k2        randh     1.0, 0.863656175788492, 0.9897
  k2        =  206.5190+((537.5518-206.5190)*((k2+1.)/2.))
  k4        randh     1.0, 8.712175804190338, 0.9043
  k4        =  185.2895+((592.8486-185.2895)*((k4+1.)/2.))
  k5        randh     1.0, 1.392112800385803, 0.5196
  k5        =  277.9342+((889.2729-277.9342)*((k5+1.)/2.))
  a1        oscil     1.0,168.999688168987632,gisine
  a2        oscil     1.0,k1,gisquare
  a3        oscil     1.0,k2,gisquare
  k3        oscil     1.0,0.116983264992014,gisine
  k3        =  924.9562+((3699.8247-924.9562)*((k3+1.)/2.))
  a5        oscil     1.0,k4,gisquare
  a6        oscil     1.0,k5,gisquare
  k6        oscil     1.0,0.094141245232895,gisine
  k6        =  511.1122+((2044.4486-511.1122)*((k6+1.)/2.))
  a8        oscil     1.0,1.124467896018177,gisine
  a4        reson     a2*a3, k3, k3*0.07974980531726, 1
  kdel1     =  1/k3
  addl1     delayr    1.0000
  a4tp      deltapi   kdel1
  a4        =  a4 + (a4tp*0.8)
            delayw    a4
  a4        balance   a4,a2*a3
  a4        =  a4*.2
  a7        reson     a5*a6, k6, k6*0.277547496953048, 1
  kdel2     =  1/k6
  addl2     delayr    1.0000
  a7tp      deltapi   kdel2
  a7        =  a7 + (a7tp*0.8)
            delayw    a7
  a7        balance   a7,a5*a6
  a7        =  a7*.2
  a9        =  a8 * (a1+a4+a7)*.2
            out       a9*30000.00
endin

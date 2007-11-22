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
  k4        =  0
  k5        =  0
  a6        =  0
  a7        =  0
  a7        =  0
endin

instr 1
  k1        randh     1.0, 0.270938829518855, 0.1214
  k1        =  285.4828+((677.9081-285.4828)*((k1+1.)/2.))
  k2        randh     1.0, 1.70374568188563, 0.9253
  k2        =  197.0774+((1268.8159-197.0774)*((k2+1.)/2.))
  k3        randh     1.0, 1.256591910962015, 0.3582
  k3        =  295.6161+((1903.2239-295.6161)*((k3+1.)/2.))
  a1        oscil     1.0,k1,gisaw
  a2        oscil     1.0,745.308952964842319,gisquare
  a3        oscil     1.0 * (1+a2),869.208797514438629,gisquare
  a4        oscil     1.0,k2,gisquare
  a5        oscil     1.0,k3,gisquare
  k4        oscil     1.0,0.093227945305407,gisine
  k4        =  990.7587+((3963.0349-990.7587)*((k4+1.)/2.))
  k5        oscil     1.0,0.093227945305407,gisaw
  k5        =  780.9597+((1832.5344-780.9597)*((k5+1.)/2.))
  a6        reson     a4*a5, k4, k4*0.282276563788764, 1
  kdel1     =  1/k4
  addl1     delayr    1.0000
  a6tp      deltapi   kdel1
  a6        =  a6 + (a6tp*0.8)
            delayw    a6
  a6        balance   a6,a4*a5
  a6        =  a6*.2
  a7        reson     a1*a3*a6, k5, k5*0.348104960843921, 1
  a7        balance   a7,a1*a3*a6
  a7        =  a7*.2
  a7        reson     a7, k5, k5*0.551398015674204, 1
  a7        balance   a7,a7
  a7        =  a7*.2
            out       a7*30000.00
endin

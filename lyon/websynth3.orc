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
  k3        =  0
  k4        =  0
  a5        =  0
  a6        =  0
  a6        =  0
endin

instr 1
  k1        randh     1.0, 4.882486648391932, 0.7611
  k1        =  105.0900+((255.8213-105.0900)*((k1+1.)/2.))
  k2        randh     1.0, 0.575497001875192, 0.6937
  k2        =  157.6349+((383.7320-157.6349)*((k2+1.)/2.))
  a1        oscil     1.0,1160.718763987533748,gisine
  a2        oscil     1.0,371.561204455792904,gisine
  a3        oscil     1.0,k1,gisquare
  a4        oscil     1.0,k2,gisquare
  k3        oscil     1.0,0.18647950200364,gisine
  k3        =  545.0200+((2180.0798-545.0200)*((k3+1.)/2.))
  k4        oscil     1.0,0.18647950200364,gisaw
  k4        =  831.5264+((3636.5957-831.5264)*((k4+1.)/2.))
  a5        reson     a3*a4, k3, k3*0.264730446762405, 1
  kdel1     =  1/k3
  addl1     delayr    1.0000
  a5tp      deltapi   kdel1
  a5        =  a5 + (a5tp*0.8)
            delayw    a5
  a5        balance   a5,a3*a4
  a5        =  a5*.2
  a6        reson     a1*a2*a5, k4, k4*0.47720440030098, 1
  a6        balance   a6,a1*a2*a5
  a6        =  a6*.2
  a6        reson     a6, k4, k4*0.513217041920871, 1
  a6        balance   a6,a6
  a6        =  a6*.2
            out       a6*30000.00
endin

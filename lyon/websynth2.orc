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
  k4        =  0
  a5        =  0
  a6        =  0
  k7        =  0
  k8        =  0
  a4        =  0
  a7        =  0
  a8        =  0
  a8        =  0
endin

instr 1
  k1        randh     1.0, 1.219999737013131, 0.5199
  k1        =  238.8372+((667.1257-238.8372)*((k1+1.)/2.))
  k2        randh     1.0, 5.101369301276281, 0.2324
  k2        =  85.2126+((519.2100-85.2126)*((k2+1.)/2.))
  k3        randh     1.0, 0.701085806824267, 0.5389
  k3        =  127.8189+((778.8150-127.8189)*((k3+1.)/2.))
  k5        randh     1.0, 3.999281866522506, 0.6105
  k5        =  176.5648+((916.6395-176.5648)*((k5+1.)/2.))
  k6        randh     1.0, 0.994582575745881, 0.3668
  k6        =  264.8472+((1374.9592-264.8472)*((k6+1.)/2.))
  a1        oscil     1.0,k1,gitri
  a2        oscil     1.0,k2,gisquare
  a3        oscil     1.0,k3,gisquare
  k4        oscil     1.0,0.102826512358151,gisine
  k4        =  414.5239+((1658.0955-414.5239)*((k4+1.)/2.))
  a5        oscil     1.0,k5,gisquare
  a6        oscil     1.0,k6,gisquare
  k7        oscil     1.0,0.115445494144224,gisine
  k7        =  284 .6046+((1138.4185-284.6046)*((k7+1.)/2.))
  k8        oscil     1.0,0.115445494144224,gisaw
  k8        =  819 .3613+((2461.4106-819.3613)*((k8+1.)/2.))
  a4        reson     a2*a3, k4, k4*0.33615486510098, 1
  kdel1     =  1/k4
  addl1     delayr    1.0000
  a4tp      deltapi   kdel1
  a4        =  a4 + (a4tp*0.8)
            delayw    a4
  a4        balance   a4,a2*a3
  a4        =  a4*.2
  a7        reson     a5*a6, k7, k7*0.289787898398936, 1
  kdel2     =  1/k7
  addl2     delayr    1.0000
  a7tp      deltapi   kdel2
  a7        =  a7 + (a7tp*0.8)
            delayw    a7
  a7        balance   a7,a5*a6
  a7        =  a7*.2
  a8        reson     a1*a4*a7, k8, k8*0.647668009158224, 1
  a8        balance   a8,a1*a4*a7
  a8        =  a8*.2
  a8        reson     a8, k8, k8*0.204903103969991, 1
  a8        balance   a8,a8
  a8        =  a8*.2
            out       a8*30000.00
endin

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr    1 ; 8-way Interpolating Scanner (random crossfader)

  ilevl     =  p4                                 ; Output level
  irate     =  p5                                 ; Random rate

  kdclick   linseg    0, .002, 1, p3-.004, 1, .002, 0
  iseed     =  rnd(1)
  krnd      randi     .5, irate, iseed
  krnd      =  sqrt(krnd + .5)
  krnd1     table     krnd, 1, 1, 0, 1
  krnd2     table     krnd, 1, 1, .125, 1
  krnd3     table     krnd, 1, 1, .250, 1
  krnd4     table     krnd, 1, 1, .375, 1
  krnd5     table     krnd, 1, 1, .500, 1
  krnd6     table     krnd, 1, 1, .625, 1
  krnd7     table     krnd, 1, 1, .750, 1
  krnd8     table     krnd, 1, 1, .875, 1
  ain1      diskin    "sample1.wav", 1, 0, 1
  ain2      diskin    "sample2.wav", 1, 0, 1
  ain3      diskin    "Sample3", 1, 0, 1
  ain4      diskin    "sample4.wav", 1, 0, 1
  ain5      diskin    "Sample5", 1, 0, 1
  ain6      diskin    "Sample6", 1, 0, 1
  ain7      diskin    "Sample7", 1, 0, 1
  ain8      diskin    "Sample8", 1, 0, 1
  ain1      =  ain1*krnd1
  ain2      =  ain2*krnd2
  ain3      =  ain3*krnd3
  ain4      =  ain4*krnd4
  ain5      =  ain5*krnd5
  ain6      =  ain6*krnd6
  ain7      =  ain7*krnd7
  ain8      =  ain8*krnd8
  aout      sum       ain1, ain2, ain3, ain4, ain5, ain6, ain7, ain8
            out       aout*kdclick*ilevl

endin

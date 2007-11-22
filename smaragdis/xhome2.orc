
                                   ; TOOT1.ORC 
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1


instr 1

  ifreq     =  cpspch( p5)
  imodrat   =  ifreq * 100 / 88

  kenv      oscil     p4,       1 / p3 ,  2
  kmen      oscil     p6,       1 / p3,        3
  kpeg      oscil     p7,       1 / p3,        4
  klfo      oscil     p10, p11,      1
  kvib      oscil     p8,       p9 + kmen ,    1

  a2mod     oscil     p14 * kmen, p13 * imodrat, 1 
  amod      oscil     kmen, imodrat + a2mod, 1
  a1        oscil     kenv, ifreq + amod + kpeg + kvib, 1
  a2        oscil     p12 * kenv, ifreq + amod + klfo + kpeg + kvib, 1
            out       a1 + a2
endin
;p4=aamp p5=afreq p6=mamp p7=pamp p8=vamp p9=vfreq 
;p10=champ p11=chfreq p12=chmix p13=m2amp

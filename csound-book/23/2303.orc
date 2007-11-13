sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

gadrysig  init      0        ; INITIALIZE GLOBAL VARIABLE



          instr     2303
iwetamt   =         p4
idryamt   =         1-p4
kenv      linseg    19000, .1, 1000, p3-.1, 0
anoise    randi     kenv, sr/2, .5
gadrysig  =         gadrysig + anoise*iwetamt
          out       anoise*idryamt
          endin

          instr     2304
irevtime  =         p4
areverb   reverb    gadrysig, irevtime
          out       areverb+gadrysig
gadrysig  =         0
          endin

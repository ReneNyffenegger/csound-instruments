  sr        =  44100
  kr        =  2205
  ksmps     =  20
  nchnls    =  1
instr 1
  kamp      expseg    1, .2, 8000, p3-.4, 5000, .2, 1 ; amplitude envelope
  ipitch    =  cpspch(p4)
  kbright   expon     p6, p3, p7                  ; envelope of gbuzz timbral brightness
  iharmonics   =      int((.5 * sr) / ipitch)
 ; "iharmonics" returns the maximum number of harmonics below Nyquist
            print     ipitch, iharmonics          ; print these values in the sterr output
  a1        gbuzz     kamp,  ipitch,  iharmonics,  p5,  kbright,  1
            out       a1
endin

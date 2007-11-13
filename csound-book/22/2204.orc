sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2


          instr     2204                     ; VDELAY VIBRATO
icps      =         cpspch(p5)               ; BASIC PITCH
ilfohz    =         p6                       ; LFO RATE IN CPS
idelfac   =         p7                       ; BETWEEN 0 & .999
imaxdel   =         p8                       ; MAX DELAY IN SECS
ilfoamp   =         idelfac*imaxdel/2        ; LFO FN IS +/- 1
kgate     linen     p4, .1,p3, .2            ; BASIC NOTE ENVLP
avarydel  oscili    ilfoamp, ilfohz, 1       ; FN1 IS LFO WAVE
asig      oscili    kgate, icps, 2           ; FN2 IS OSC WAVE
adelay    =         imaxdel/2+avarydel       ; OFFSET TO .5 MAX
aout      vdelay    asig, adelay, imaxdel    ; VARYING DELAY
          outs      aout, aout
          endin

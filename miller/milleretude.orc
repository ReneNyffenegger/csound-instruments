  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2
instr          1,4                                ; P4  = AMPLITUDE OF OUTPUT WAVE
  i1        =  1/p3                               ; P5  = CARRIER FREQUENCY SPECIFIED IN HZ
  idev1     =  p7 * p6                            ; P6  = MODULATING FREQUENCY IN HZ
  idev2     =  (p8-p7) * p6                       ; P7  = MODULATION INDEX 1
                                                  ; P8  = MODULATION INDEX 2
  ampcar    oscil     p4,i1,p9                    ; P9  = CARRIER ENVELOPE FUNCTION
  ampmod    oscil     idev2,i1,p10                ; P10 = MODULATOR ENVELOPE FUNCTION

  amod      oscili    ampmod+idev1,p6,1
  gasig     oscili    ampcar,p5+amod,1

            outs1     gasig *.25
            outs2     gasig *.25
endin

instr          2
  i1        =  1/p3                               ; P4  = AMPLITUDE OF OUTPUT WAVE
  idev1     =  p7 * p6                            ; P5  = CARRIER FREQUENCY SPECIFIED IN HZ
  idev2     =  (p8-p7) * p6                       ; P6  = MODULATING FREQUENCY IN HZ
  k1        randi     120,10                      ; P7  = MODULATION INDEX 1
  k2        randi     200,20                      ; P8  = MODULATION INDEX 2
  ampcar    oscil     p4,i1,p9                    ; P9  = CARRIER ENVELOPE FUNCTION
  ampmod    oscil     idev2,i1,p10                ; P10 = MODULATOR ENVELOPE FUNCTION

  amod      oscili    ampmod+idev1,p6+k1,1
  gasig     oscili    ampcar,k2+p5+amod,1
            outs1     gasig * .25
            outs2     gasig * .25
endin

instr          3                                  ; PANER
  k1        oscil     1,1/p3,p4
            outs1     gasig*k1
            outs2     gasig*(1-k1)
endin

instr          5
  k1        linseg    p5,p3.4,p5,p3.6,p5*.9
  a1        pluck     p4,cpspch(p5),cpspch(p5),0,1,0,0
            outs      a1,a1
endin

instr          6
  k1        expseg    p4*.8,p3*.25,p4,p3*.6,p4*.2,p3*.15,.01
  a1        foscili   k1,1,p5,p6,p7,1,0
            outs      a1,a1
endin

instr          7
  k1        expseg    p4*.001,p3*.2,p4,p3*.7,p4,p3*.1,p4*.001
  k2        expseg    p7,p3*.02,p7*.5
  k3        oscil     10,p8,1
  k4        oscil     1,1/p3,2
  a1        foscili   k1,1,p5+k3,p6,k2,1,0
            outs      a1,a1
endin

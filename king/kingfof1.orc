

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

instr 1 

  kamp1     line      p5, p3, 0
  kamp2     line      p5*0.35,p3,0
  kamp3     envlpx    p5, 0.02, p3/2, 0.03,3,1,.01,-0.5

  a1        pluck     kamp1, cpspch(p4), cpspch(p4)*.95,7,1
  a2        fof       kamp2,cpspch(p4),50,0,.4,.003,.02,.007,57,1,3,p3

;a3       loscil    1, cpspch(p4), 11, 440, 0

            outs      a1,a2

endin

instr  2 

  kamp1     line      p5, p3, 0
  kamp2     line      p5*0.35,p3,0
  kamp3     envlpx    p5, 0.02, p3/2, 0.03,3,1,.01,-0.5

  a1        pluck     kamp1, cpspch(p4), cpspch(p4)*1.05,7,2,3
  a2        oscil     kamp2, cpspch(p4), 1

;a3       loscil    1, cpspch(p4), 11, 440, 0

            outs      a2,a1

endin

instr  3 

  kamp1     line      p5, p3, 0
  kamp2     line      p5*0.35,p3,0
  kamp3     envlpx    p5, 0.02, p3/2, 0.03,3,1,.01,-0.5

  a1        pluck     kamp1, cpspch(p4), cpspch(p4)*.95,8,2,3
  a2        oscil     kamp2, cpspch(p4), 1

;a3       loscil    1, cpspch(p4), 11, 440, 0

            outs      a1,a2

endin

instr  4 

  kamp1     line      p5, p3, 0
  kamp2     line      p5*0.35,p3,0
  kamp3     envlpx    p5, 0.02, p3/2, 0.03,3,1,.01,-0.5

  a1        pluck     kamp1, cpspch(p4), cpspch(p4)*1.05,1,2,3
  a2        oscil     kamp2, cpspch(p4), 1

;a3       loscil    1, cpspch(p4), 11, 440, 0

            outs      a2,a1

endin

; Orquestra modificada porque a original não compilava

  sr        =  44100
  kr        =  4410
  ksmps     =  10.0


instr 1 
; asig1 fof       p4, cpspch(p5), 700, 0, 3, .003, 130, .01, 7, 5, 1, 1, p3
; asig2 fof       p4, cpspch(p5), 122, 0, 3, .003, 70, .01, 7, 5, 1, 1, p3
; asig3 fof       p4, cpspch(p5), 260, 0, 3, .003, 160, .01, 7, 5, 1, 1, p3
  asig1     fof       p4, 200, 650, 0, 40, .003, .02, .007, 5, 1, 1, p3
  asig2     fof       p4, 200, 650, 0, 40, .003, .02, .007, 5, 1, 1, p3
  asig3     fof       p4, 200, 650, 0, 40, .003, .02, .007, 5, 1, 1, p3
        
            out       (asig1 + asig2 + asig3 ) / 3
endin





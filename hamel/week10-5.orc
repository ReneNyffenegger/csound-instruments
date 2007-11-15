; ORQUESTRA FILE
 
  sr        =  44100
  kr        =  4410
  ksmps     =  10.0



instr 1
  itrans    =  cpspch(8.00) / cpspch(p5)          ; ratio of orig to new pitch
  aindex    phasor    (.894/1.5) / (1.5 * itrans) ; read once in table duration
  asig      table     aindex*32768, 1             ; read table 1
            out       asig                        ;output 
endin


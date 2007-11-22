  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

  ga1       init      0
  ga2       init      0
  ga3       init      0
  ga4       init      0

instr 1

  a1        loscil    15000, 1, 1, 1, 1, 1, 87936
            outs      a1, a1

  ga1       =  a1 * p4
  ga2       =  a1 * p4
  ga3       =  a1 * p5
  ga4       =  a1 * p5
endin

instr 2
  a1        reverb    ga1, p5
  a2        reverb    ga2, p5
        
            outs      a1 * p4, a2 * p4
  ga1       =  0
  ga2       =  0
endin

instr 3
  a1        reverb2   ga3, p5, .3
  a2        reverb2   ga4, p5, .3

            outs      a1 * p4, a2 * p4
  ga3       =  0
  ga4       =  0
endin

instr 4
  a1        oscilx    32000, 1, 2, 1

  ga1       =  a1 * p4
  ga2       =  a1 * p4
  ga3       =  a1 * p5
  ga4       =  a1 * p5
endin

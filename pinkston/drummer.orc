;RP's solution to the GM drummer problem.
;Note that p3 is set to equal the length of
;the sample file for each note, regardless
;of the value of p3 in the score.

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

instr   10
  iamp      table     p4,11                       ;fn 11 has our vel/amp scaling func
  ismp      table     p5,12                       ;fn 12 has nn to function map
  iscl      table     p5,13                       ;fn 13 has nn to amp scaling map
  ipan      table     p5,14                       ;fn 14 has nn to pan position map
  p3        =  ftlen(ismp)/sr                     ;adjust p3 to actual sample length
  ileft     =  sqrt(ipan)
  iright    =  sqrt(1-ipan)
  icps      =  cpsoct(p5/12+3)                    ;convert midi nn to cps
  asig      loscil    iamp*iscl,icps,ismp
            outs      asig*ileft,asig*iright
endin

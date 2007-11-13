sr = 44100
kr = 2205
ksmps = 20
nchnls = 1

instr 1
  ;SF([ ; fdded code to produce low pass filtering of soundfiles
  ; p9 = 1st half-power point,      p10 = 2nd h.p. point
  ; p11 = rate of change between p9 & p10,  p12= function # for change
  irate = (p11=0? 1/p3 : p11)
  k1 oscili p10-p9 , irate, p12
  khp = k1 + p9     ; changing half-power point
  a2 soundin "santur1.wav"
  a1 tone a2, khp
  out a1
endin


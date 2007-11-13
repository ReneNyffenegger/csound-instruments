sr = 44100
kr = 2205
ksmps = 20
nchnls = 1

 ; p9 = attack hardness; p10 = fm c:m ratio ; p11 = fm index

 instr 3
 ipitch = (p4<15? cpspch(p4) : p4)   ; p4 can be in cps or pch
 iscale = octcps(ipitch)
 iscale = (18-iscale)*.1      ; scalar : c4 = 1., c5 = .9, c3 = 1.1, etc.
 iscale = .5*iscale*p9
 kamp envlpx p5, p6, p3, p7, 60, p8, .01

 ; Pitch skew
 k1 expseg iscale, p9*p6, .005,p3-p6, .005  ; envelope for % pitch skew
 k2 expseg kr - 1, p9*p6, p9*30, p3-p6, 20 ; envelope for pitch skew rate
 knoise  randi k1*ipitch, k2              ; pitch skew
 ; f.m. index envelope
 kindex  expseg p9*p11, p9*p6, p11, p3-(p9*p6),.6*p11
 asound foscili kamp, knoise + ipitch, 1, p10, kindex, 100
 out asound
 endin


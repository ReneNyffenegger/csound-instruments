   ; Functions needed: 50 51 52 100
   ;  p6 = attack time (.001-.01) ;        p7 = % tremolo (.2 - .33)
   ;  p8 = 1st tremolo (2. - 5.);          p9 = 2nd tremolo rate
   ;  p10 = c:m1                           p11 = c:m2
   ;  p12 = c:m3                           p13 = modulation indx
   ;  p14 = function to vary tremolo rate (usually 50; also 52,51)
   ;  p15 = attack hardness        ; p16 atss for mod. indx


   sr = 44100
   kr = 4410
   ksmps = 10
   nchnls = 1

   instr 1
   ipitch = (p 4 <15 ? cpspch(p4) : p4)    ; pch or cps input
   iscale = octcps(ipitch)
   iscale = (18-iscale) * .1                 ; scalar

   ; ENVELOPE
   amp linseg 0,p6,1.,.05/p15-p6,(p15+iscale+1)/3*.56,.1*p3,.3,.15*p3,.12,.25*p3,.06,.5*p3-(.05/p15),0
   p5 = iscale * ((p15+1)/2) * p5
   amp = amp * p5

   ; TREMOLO
     k1 randi p15*.07,2.2/p15
     k2 oscil p9-p8,1/p3,p14               ;varies rate of tremolo
   ktrem oscili p7+k1*p7,p8+k2,100         ;tremolo
   ; Random Amplitude Deviation
     k1 expseg p15*.2,p15*p6,p15*.05,p3,p15*.04
   krandamp randi k1,50/p15
   amp = amp + ((ktrem+krandamp)*amp)        ;TOTAL AMPLITUDE

   ; RANDOM FREQUENCY DEVIATION
   k1 expseg p15*.9*iscale,p6,p15*.003,p3,.002
   i4 = 800/(iscale>1?iscale:(1/iscale))
   k2 expseg 750/(iscale>1?iscale:1/iscale),p6,45/iscale,p3,60/iscale
   krandpitch randi k1*.5*ipitch,k2
   kpitch = ipitch + krandpitch              ; FREQUENCY

   ; FREQUENCY  MODULATION - 3 oscillators
   kindex expseg p15,p15*iscale*.055,p15*.6,.1*p3,.3,.15*p3,.12,.25*p3,.06,.5*p3-.055,.01
   kindex = kindex * p13 * iscale            ; MODULATION INDEX
   ; modulating oscillator 1
     kmod1 = p10*kpitch
   amod1 oscili kindex * kmod1, kmod1, 100
   ; Freq. Modulation oscillator 2
     kmod2 = p11 * kpitch
   amod2 oscili kindex * kmod2, kmod2, 100
   if p12=0 goto ready
   ; Freq. Modulation oscillator 3
       kmod3 = p12 * kpitch
       amod3 oscili kindex * kmod3, kmod3, 100
    amod2 = amod2+amod3

   ready:
   kdepth expon  p15, p3, iscale * p16 * p13      ; modulation depth
   a1 oscili amp, kpitch + (kdepth*(amod1+amod2)), 100  ; carrier

   out a1
   endin


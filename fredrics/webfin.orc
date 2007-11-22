  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

; CELLO INSRUMENT
  
instr 1
  iamp      =  p5
  ifreq     =  cpspch(p4)
  iarand    =  .009
  ifrand    =  3
  ifvib     =  3
  ilfac     =  sqrt(p9)
  irfac     =  sqrt(1-p9)
  iat       =  p6*2.1
  idec      =  p7*2.1
  aresig    =  0

  krand     randi     iarand, ifrand, -1
  kvib      oscil     krand, ifvib, 1
  acelsig   foscili   iamp, ifreq*(1+kvib), p10, p11, p12, 1
  asig1     envlpx    acelsig, iat, p3-p13-.1, idec, 2, p8, .01
if        (p13=0)goto continue
  aresig    reverb    asig1, p13
continue:
            outs      (asig1*ilfac)+(aresig*.5), (asig1*irfac)+(aresig*.5)
 
endin

; CELLO TRILL INSRUMENT
  
instr 2          
  iamp      =  p5
  ifreq     =  cpspch(p4)
  ilfac     =  sqrt(p9)
  irfac     =  sqrt(1-p9)
  iat       =  p6*2.1
  idec      =  p7*2.1
  ihnote    =  cpspch(p4+.02)
  itrate    =  6
  ktrill    init      0

            timout    0, .2, notrill
  ktrill    oscil     ihnote-ifreq, itrate, 6
notrill:
  acetsig   foscili   iamp, ifreq+ktrill, p10, p11, p12, 1
  atsig1    envlpx    acetsig, iat, p3, idec, 2, p8, .01
            outs      atsig1*ilfac, atsig1*irfac

endin

; PIANO INSTRUMENT (TREBLE)

instr 3
  ifamp     =  .3
  ivibamp   =  .3
  iamp      =  (1- ivibamp)- ifamp
  ifreq     =  cpspch(p4)
  ifunc     =  4
  iarand    =  .0075
  ifreqrand =  15
  ifreqvib  =  p8
  ifrise    =  .02
  iat       =  .01
  idec      =  p6*2.1

  kfgate    oscil1i   0, ifamp, ifrise, 8
  kgate     envlpx    p5, iat, p3, idec, 3, p7, .01
  krand     randi     iarand, ifreqrand, -1
  kvib      oscil     krand+1, ifreqvib+krand, 1
  aform     oscili    kfgate, ifreq*2, 9          
  avibpt    oscili    ivibamp*kvib, ifreq, ifunc
  apiano1   oscili    iamp, ifreq, ifunc
            outs      (avibpt+apiano1)*kgate+(aform*p5), (apiano1*kgate)*.1
endin        

; PIANO INSTRUMENT (BASS) 

instr 4
  ifamp     =  .3
  ivibamp   =  .2
  iamp      =  (1- ivibamp)- ifamp
  ifreq     =  cpspch(p4)
  ifunc     =  5
  iarand    =  .01
  ifreqrand =  15
  ifreqvib  =  p8
  ifrise    =  .02
  iat       =  .01
  idec      =  p6*2.1

  kfgate    oscil1i   0, ifamp, ifrise, 8
  kgate     envlpx    p5, iat, p3, idec, 3, p7, .01
  krand     randi     iarand, ifreqrand, -1
  kvib      oscil     krand+.2, ifreqvib+krand, 1
  aform     oscili    kfgate, ifreq, 7 
  avibpb    oscili    ivibamp*kvib, ifreq, ifunc
  apiano2   oscili    iamp, ifreq, ifunc

            outs      (apiano2*kgate)*.1, (avibpb+apiano2)*kgate+(aform*p5)
 
endin

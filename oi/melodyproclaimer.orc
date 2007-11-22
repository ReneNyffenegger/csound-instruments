

instr 10        ;melody proclaimer (via score)
;proclaims melodies' current notes (for use by the melody and harmony 
;generators) on 120 channels of table 3---
; these correspond to the 40 modal channels 
;as mc0=>0,40,80, etc.
;p1=10.NNMM... where NN.MM... is the destination instrument which will be
;sent the note (or none if the NN==0).
;p4=the pitch of the note to be proclaimed, in general pitch notation
;p5=the channel (0,...,119) on which to proclaim it.
;p6=if >p5, proclaim on the range (p5,p6) inclusive, otherwise on p5 only
;p7=decode using mode number p7, if -ve, the mode of the concerned melody
;channel is used.  (i.e., if p4 is scalar, it is interpreted as being a
;degree of mode p7; if p4 is modal, it is converted from the mode of p7
;to the mode of melody channel p5.
;if the destination is >0, an event is scheduled with p-fields:
;i [destination],p2,p8,p9,[proclaimed pitch],p10...etc

  p3        =  .001
  i8ve      =  int(abs(p4)+.1)
again:
  imd       =  int(10*frac(p4)+.1)
  iinm      =  (p7<0?(p5<40?p5:(p5<80?p5-40:p5-80)):p7) ;ostensibly, the input mode 

if (p4==0 || (p4>0 && p7<0)) igoto done
if (p4<0) igoto scalar
$md2sd(imd'iinm)
$sd2md(isd'p5)
            igoto     done
scalar:
  isd       =  int(100*frac(-p4)+.2)
$sd2md(isd'iinm)
done:
  iproc     =  i8ve+(imd/10)+(iinm/1000)
            tableiw   iproc,p5,3
  p5        =  p5+1
if (p6>=p5) igoto again
  idest     =  int(frac(p1)*100+.1)
  idest     =  idest+frac(p1*100)

if (idest<1 || iproc<.1) igoto endit

            schedule  idest,0,p8,p9,iproc,p10,p11,p12,p13,p14,p15,p16,p17,p18,p19,p20
endit:
$forcedShutoff
endin


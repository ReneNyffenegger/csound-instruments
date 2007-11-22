;for the melody proclaimer alone (also used by the melody and 
;harmony generators):
;melody channels: 120 channels, each:
; current note in 8ve.md notation, mode corresponding to above +n40, 
; i.e., mode 0 applies to melody channels 0,40,80; 1 to 1,41,81, etc.
; 0.0 signifies a rest
f3  0 128   -2    0     0     0   

# define Melody #10#

;10 melody proclaimer---proclaims melodies' current notes 
;				(for use by the melody and harmony 
;				generators) as directed by the score, 
;				on 120 "channels" in ftable 3---
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
;i [destination],p2,p8,[proclaimed pitch],p9,p10...etc

;i$Melody.00 0 1 8.00  0 0 -1 


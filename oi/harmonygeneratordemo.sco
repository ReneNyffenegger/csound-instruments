#include"ZAKINI~2.TXT"	;zak initializer definition
#include"TUNING~2.TXT"	;tuning-related ftables
#include"MODEPR~2.TXT"	;mode-related ftables
#include"CHORDP~2.TXT"	;chord-related ftables
#include"MELODY~3.TXT"	;melody-related ftables
#include"HARMON~2.TXT"	;the harmony generator's ftables
#include"OTHERF~1.TXT"	;other, synthesis-related ftables


;Here, I redefine some tables to suit me:

;tuning tables (5--9)---number of degrees, list of .oct values. 
;
;basic just 12, 7-limit
f5  0 16    -2    12    0.00  0.093122    0.169927    0.222395    0.321930    0.415040    0.485429    0.584965    0.678074 0.777610 0.807357 0.906893 0.

;modal definitions (20--29) select modes from scales (givin an SD offest!)
; index 0=k ---there are k modes in this table, 
; index 1=n ---they are to be selected from n scalar degrees
; index 2=m ---each mode is to have m degrees,
; index 3 onward: k lists of m scalar degree offsets (above keynote)
;
;the church modes "on C"---0=Ionian, 1=Dorian,       2=Phrygian,     3=Lydian,       4=Mixolydian,   5=Aeolian,      6=Locrian.
f20 0 64    -2    7     12    7     0     2     4     5     7     9     11    0     2     3     5     7     9     10 0 1 3 5 7 8 10 0 2 4 6 7 9 11 0 2 4 5 7 9 10 0 2 3 5 7 8 10 0 1 3 5 6 8 10 

;Chords may be defined either in terms of scalar or modal degrees.
;In this demo, I use modal definitions (see chordProclaimerDEMO.sco
;for an example of scalar chord definition):

;modal chord definitions (10--14) select chords from a mode: 
; index 0=number of types,
; list of table locs (for each type) and, at each location:
; number of components in chord, a list of steps from the root
; e.g. 3 2 4 = diatonic triad
;
; basic diatonic chords: type 0=triad, 1=7th
f10 0 64    -2    2     3     6     3     2     4     4     2     4     6       

;harmonic mode markov tables (30--39) n lists of n conditional probabilities
; where index i*n+j=probability of transition from chord i to chord j
;a circle-of fifthsish progression---not too sophisticated!
f30 0 64    -2    4     1     1     0     1     1     1     1     1     1     1     18    1     1     1     1     1 1 1 18 1 3 1 1 1 1 1 18 18 1 1 1 1 1 1 1 18 1 1 1 1 1 3 1 18 1 1 1 1  




t0      60   
i$Zakinit     0      0      12     16     0      1    
i$Tuning      0      0      5    
i$Mode 0      0      20.00  30     0      0      4 ;Ionian

;12 harmony generator(/chord proc.)---generates and proclaims a chord,
;					possibly influenced by several 
;				things: the previous chord and Markov chains
;			defined by the harmonic mode; up to three pitches
;		from currently-sounding melodies; other, simultaneously-
;	sounding chords; demanded chord type; etc., etc., etc.
;p4=C.DDdd where C=chord channel on which to proclaim generated chord {1,2,3}
; and where DD and dd=prefered number of SD steps to separate tones. 
; if DDdd=0 (i.e., the default), 3 and 4 steps are prefered.
;p5=R.E where R=the reference chord channel---the new chord will be chosen
; in reference to that on chord channel R. if R is not {1,2,3} or if R=C,
; then no chord is used as a referece (i.e., a chord will be chosen freely).
; and where E=the suitability on [0,1) of tones D steps outside 
; the bounding chord tones.
; (e.g., of a melodic 7th above a chord, or another chord rooted there).
;p6=a demanded chord type.  if 0.T, the modal type T; if N.TT, the scalar
; type TT; if -ve, the type is uncertain, and will be chosen by the algorithm.
;p7---p9=M.F where M refers to melody channels which to harmonize 
; (ignored if -ve) where F [0,1) the importance of that channel.
;p10=modal chord definition table number (default =10)
;p11=scalar chord definition table number (default =15)

;in the first section, free composition of harmony:

;     channel.steps ref-ch.suit-outside demanded.type melody_channels
i12 1  1      1.0000 0.0    -0.1   -1.0   -1.0   -1.0
i12 +  1      1.0000 0.0    -0.1   -1.0   -1.0   -1.0
i12 +  1      1.0000 0.0    -0.1   -1.0   -1.0   -1.0
i12 +  1      1.0000 0.0    -0.1   -1.0   -1.0   -1.0
i12 +  1      1.0000 0.0    -0.1   -1.0   -1.0   -1.0
i12 +  1      1.0000 0.0    -0.1   -1.0   -1.0   -1.0
i12 +  1      1.0000 0.0    -0.1   -1.0   -1.0   -1.0
i12 +  1      1.0000 0.0    -0.1   -1.0   -1.0   -1.0

;now, demanding certain chord types--four triads and four sevenths 
;(modal chord definitions):

i12 +  1      1.0000 0.0    0.0    -1.0   -1.0   -1.0
i12 +  1      1.0000 0.0    0.0    -1.0   -1.0   -1.0
i12 +  1      1.0000 0.0    0.0    -1.0   -1.0   -1.0
i12 +  1      1.0000 0.0    0.0    -1.0   -1.0   -1.0
i12 +  1      1.0000 0.0    0.1    -1.0   -1.0   -1.0
i12 +  1      1.0000 0.0    0.1    -1.0   -1.0   -1.0
i12 +  1      1.0000 0.0    0.1    -1.0   -1.0   -1.0
i12 +  1      1.0000 0.0    0.1    -1.0   -1.0   -1.0
;the second half of i12, i13, must be called with the same pfields
i13 1  1      1.0000 0.0    -0.1   -1.0   -1.0   -1.0
i13 +  1      1.0000 0.0    -0.1   -1.0   -1.0   -1.0
i13 +  1      1.0000 0.0    -0.1   -1.0   -1.0   -1.0
i13 +  1      1.0000 0.0    -0.1   -1.0   -1.0   -1.0
i13 +  1      1.0000 0.0    -0.1   -1.0   -1.0   -1.0
i13 +  1      1.0000 0.0    -0.1   -1.0   -1.0   -1.0
i13 +  1      1.0000 0.0    -0.1   -1.0   -1.0   -1.0
i13 +  1      1.0000 0.0    -0.1   -1.0   -1.0   -1.0
i13 +  1      1.0000 0.0    0.0    -1.0   -1.0   -1.0
i13 +  1      1.0000 0.0    0.0    -1.0   -1.0   -1.0
i13 +  1      1.0000 0.0    0.0    -1.0   -1.0   -1.0
i13 +  1      1.0000 0.0    0.0    -1.0   -1.0   -1.0
i13 +  1      1.0000 0.0    0.1    -1.0   -1.0   -1.0
i13 +  1      1.0000 0.0    0.1    -1.0   -1.0   -1.0
i13 +  1      1.0000 0.0    0.1    -1.0   -1.0   -1.0
i13 +  1      1.0000 0.0    0.1    -1.0   -1.0   -1.0

;this instrument plays the chords it finds on chord channel p4 in 8ve p5.
i60 1  1      1      8    
i60 +  1      1      8    
i60 +  1      1      8    
i60 +  1      1      8    
i60 +  1      1      8    
i60 +  1      1      8    
i60 +  1      1      8    
i60 +  1      1      8    
i60 +  1      1      8    
i60 +  1      1      8    
i60 +  1      1      8    
i60 +  1      1      8    
i60 +  1      1      8    
i60 +  1      1      8    
i60 +  1      1      8    
i60 +  1      1      8    



s
t0      60   
;in this section, two simultaneous progressions, the second, on chord
;channel 2, written in response to the first and at twice the tempo,
;all while demanding modal triads.

;lower:
;       channel.steps ref-ch.suit-outside demanded.type melody_channels
i12.1  1      1      1.0000 0.0    0.0    -1.0   -1.0   -1.0
i12.1  2      1      1.0000 0.0    0.0    -1.0   -1.0   -1.0
i12.1  3      1      1.0000 0.0    0.0    -1.0   -1.0   -1.0
i12.1  4      1      1.0000 0.0    0.0    -1.0   -1.0   -1.0
i12.1  5      1      1.0000 0.0    0.0    -1.0   -1.0   -1.0

;the second half of i12, i13, must be called 
i13.1  1      1      1.0000 0.0    0.0    -1.0   -1.0   -1.0
i13.1  2      1      1.0000 0.0    0.0    -1.0   -1.0   -1.0
i13.1  3      1      1.0000 0.0    0.0    -1.0   -1.0   -1.0
i13.1  4      1      1.0000 0.0    0.0    -1.0   -1.0   -1.0
i13.1  5      1      1.0000 0.0    0.0    -1.0   -1.0   -1.0


;upper
i12.2  1.01   .5     2.0000 1.0    0.0    -1.0   -1.0   -1.0
i12.2  1.51   .5     2.0000 1.0    0.0    -1.0   -1.0   -1.0
i12.2  2.01   .5     2.0000 1.0    0.0    -1.0   -1.0   -1.0
i12.2  2.51   .5     2.0000 1.0    0.0    -1.0   -1.0   -1.0
i12.2  3.01   .5     2.0000 1.0    0.0    -1.0   -1.0   -1.0
i12.2  3.51   .5     2.0000 1.0    0.0    -1.0   -1.0   -1.0
i12.2  4.01   .5     2.0000 1.0    0.0    -1.0   -1.0   -1.0
i12.2  4.51   .5     2.0000 1.0    0.0    -1.0   -1.0   -1.0
i12.2  5.01   .5     2.0000 1.0    0.0    -1.0   -1.0   -1.0
i12.2  5.51   .5     2.0000 1.0    0.0    -1.0   -1.0   -1.0

;the second half of i12, i13, must be called 
i13.2  1.01   .5     2.0000 1.0    0.0    -1.0   -1.0   -1.0
i13.2  1.51   .5     2.0000 1.0    0.0    -1.0   -1.0   -1.0
i13.2  2.01   .5     2.0000 1.0    0.0    -1.0   -1.0   -1.0
i13.2  2.51   .5     2.0000 1.0    0.0    -1.0   -1.0   -1.0
i13.2  3.01   .5     2.0000 1.0    0.0    -1.0   -1.0   -1.0
i13.2  3.51   .5     2.0000 1.0    0.0    -1.0   -1.0   -1.0
i13.2  4.01   .5     2.0000 1.0    0.0    -1.0   -1.0   -1.0
i13.2  4.51   .5     2.0000 1.0    0.0    -1.0   -1.0   -1.0
i13.2  5.01   .5     2.0000 1.0    0.0    -1.0   -1.0   -1.0
i13.2  5.51   .5     2.0000 1.0    0.0    -1.0   -1.0   -1.0

;this instrument plays the chords it finds on chord channel p4 in 8ve p5.
i60 1  1      1      7    
i60 2  1      1      7    
i60 3  1      1      7    
i60 4  1      1      7    
i60 5  1      1      7    

i60 1.01      .5     2      8    
i60 1.51      .5     2      8    
i60 2.01      .5     2      8    
i60 2.51      .5     2      8    
i60 3.01      .5     2      8    
i60 3.51      .5     2      8    
i60 4.01      .5     2      8    
i60 4.51      .5     2      8    
i60 5.01      .5     2      8    
i60 5.51      .5     2      8    

f0  7                                   ;otherwise schedule adds extra time to the end of the section.


s
;again, but now allowing the upper progression to take roots on other
;than the components of the lower, according to DDdd and E---in this 
;case, (DDdd==0304), allowing the roots to land a third away from 
;the outer components of the reference chord.

;lower:
;        channel.steps ref-ch.suit-outside demanded.type melody_channels
i12.1  1      1      1.0000 0.0    0.0    -1.0   -1.0   -1.0
i12.1  2      1      1.0000 0.0    0.0    -1.0   -1.0   -1.0
i12.1  3      1      1.0000 0.0    0.0    -1.0   -1.0   -1.0
i12.1  4      1      1.0000 0.0    0.0    -1.0   -1.0   -1.0
i12.1  5      1      1.0000 0.0    0.0    -1.0   -1.0   -1.0
;upper
i12.2  1.01   .5     2.0304 1.8    0.0    -1.0   -1.0   -1.0
i12.2  +      .5     2.0304 1.8    0.0    -1.0   -1.0   -1.0
i12.2  +      .5     2.0304 1.8    0.0    -1.0   -1.0   -1.0
i12.2  +      .5     2.0304 1.8    0.0    -1.0   -1.0   -1.0
i12.2  +      .5     2.0304 1.8    0.0    -1.0   -1.0   -1.0
i12.2  +      .5     2.0304 1.8    0.0    -1.0   -1.0   -1.0
i12.2  +      .5     2.0304 1.8    0.0    -1.0   -1.0   -1.0
i12.2  +      .5     2.0304 1.8    0.0    -1.0   -1.0   -1.0
i12.2  +      .5     2.0304 1.8    0.0    -1.0   -1.0   -1.0
i12.2  +      .5     2.0304 1.8    0.0    -1.0   -1.0   -1.0


;the second half of i12, i13, must be called 
i13.1  1      1      1.0000 0.0    0.0    -1.0   -1.0   -1.0
i13.1  2      1      1.0000 0.0    0.0    -1.0   -1.0   -1.0
i13.1  3      1      1.0000 0.0    0.0    -1.0   -1.0   -1.0
i13.1  4      1      1.0000 0.0    0.0    -1.0   -1.0   -1.0
i13.1  5      1      1.0000 0.0    0.0    -1.0   -1.0   -1.0
i13.2  1.01   .5     2.0000 1.0    0.0    -1.0   -1.0   -1.0
i13.2  1.51   .5     2.0000 1.0    0.0    -1.0   -1.0   -1.0
i13.2  2.01   .5     2.0000 1.0    0.0    -1.0   -1.0   -1.0
i13.2  2.51   .5     2.0000 1.0    0.0    -1.0   -1.0   -1.0
i13.2  3.01   .5     2.0000 1.0    0.0    -1.0   -1.0   -1.0
i13.2  3.51   .5     2.0000 1.0    0.0    -1.0   -1.0   -1.0
i13.2  4.01   .5     2.0000 1.0    0.0    -1.0   -1.0   -1.0
i13.2  4.51   .5     2.0000 1.0    0.0    -1.0   -1.0   -1.0
i13.2  5.01   .5     2.0000 1.0    0.0    -1.0   -1.0   -1.0
i13.2  5.51   .5     2.0000 1.0    0.0    -1.0   -1.0   -1.0



;this instrument plays the chords it finds on chord channel p4 in 8ve p5.
i60 1  1      1      7    
i60 2  1      1      7    
i60 3  1      1      7    
i60 4  1      1      7    
i60 5  1      1      7    

i60 1.01      .5     2      8    
i60 1.51      .5     2      8    
i60 2.01      .5     2      8    
i60 2.51      .5     2      8    
i60 3.01      .5     2      8    
i60 3.51      .5     2      8    
i60 4.01      .5     2      8    
i60 4.51      .5     2      8    
i60 5.01      .5     2      8    
i60 5.51      .5     2      8    

f0  7                                   ;otherwise schedule adds extra time to the end of the section.


s

;finally, a harmony composed in response to a given (proclaimed) melody.
;---note: this also serves as a demonstration of the melody proclaimer.

i$Mode 0      0      20.04  30     0      0      4 ;Mixolydian

;      channel.steps ref-ch.suit-outside demanded.type melody_channels
i12 1  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i12 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i12 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i12 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i12 +  1.5    1.0000 0.0    0.0    1.9    -1.0   -1.0
i12 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i12 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i12 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i12 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i12 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i12 12 1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i12 +  2.25   1.0000 0.0    0.0    1.9    -1.0   -1.0
i12 +  3      1.0000 0.0    0.0    1.9    -1.0   -1.0
i12 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i12 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i12 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i12 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i12 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i12 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i12 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i12 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i12 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i12 28 1.5    1.0000 0.0    0.0    1.9    -1.0   -1.0
i12 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i12 +  1.5    1.0000 0.0    0.0    1.9    -1.0   -1.0
i12 +  1.5    1.0000 0.0    0.0    1.9    -1.0   -1.0
i12 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i12 +  2      1.0000 0.0    0.0    1.9    -1.0   -1.0
i12 +  2      1.0000 0.0    0.0    1.9    -1.0   -1.0
i12 39 1.5    1.0000 0.0    0.0    1.9    -1.0   -1.0
i12 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i12 42 1.5    1.0000 0.0    0.0    1.9    -1.0   -1.0
i12 +  1.5    1.0000 0.0    0.0    1.9    -1.0   -1.0
i12 +  1.5    1.0000 0.0    0.0    1.9    -1.0   -1.0
i12 +  1.5    1.0000 0.0    0.0    1.9    -1.0   -1.0
i12 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i12 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0

i13 1  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i13 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i13 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i13 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i13 +  1.5    1.0000 0.0    0.0    1.9    -1.0   -1.0
i13 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i13 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i13 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i13 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i13 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i13 12 1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i13 +  2.25   1.0000 0.0    0.0    1.9    -1.0   -1.0
i13 +  3      1.0000 0.0    0.0    1.9    -1.0   -1.0
i13 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i13 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i13 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i13 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i13 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i13 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i13 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i13 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i13 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i13 28 1.5    1.0000 0.0    0.0    1.9    -1.0   -1.0
i13 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i13 +  1.5    1.0000 0.0    0.0    1.9    -1.0   -1.0
i13 +  1.5    1.0000 0.0    0.0    1.9    -1.0   -1.0
i13 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i13 +  2      1.0000 0.0    0.0    1.9    -1.0   -1.0
i13 +  2      1.0000 0.0    0.0    1.9    -1.0   -1.0
i13 39 1.5    1.0000 0.0    0.0    1.9    -1.0   -1.0
i13 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i13 42 1.5    1.0000 0.0    0.0    1.9    -1.0   -1.0
i13 +  1.5    1.0000 0.0    0.0    1.9    -1.0   -1.0
i13 +  1.5    1.0000 0.0    0.0    1.9    -1.0   -1.0
i13 +  1.5    1.0000 0.0    0.0    1.9    -1.0   -1.0
i13 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0
i13 +  1      1.0000 0.0    0.0    1.9    -1.0   -1.0

i60 1  1      1      7    
i60 +  1      1      7    
i60 +  1      1      7    
i60 +  1      1      7    
i60 +  1.5    1      7    
i60 +  1      1      7    
i60 +  1      1      7    
i60 +  1      1      7    
i60 +  1      1      7    
i60 +  1      1      7    
i60 12 1      1      7    
i60 +  2.25   1      7    
i60 +  3      1      7    
i60 +  1      1      7    
i60 +  1      1      7    
i60 +  1      1      7    
i60 +  1      1      7    
i60 +  1      1      7    
i60 +  1      1      7    
i60 +  1      1      7    
i60 +  1      1      7    
i60 +  1      1      7    
i60 28 1.5    1      7    
i60 +  1      1      7    
i60 +  1.5    1      7    
i60 +  1.5    1      7    
i60 +  1      1      7    
i60 +  2      1      7    
i60 +  2      1      7    
i60 39 1.5    1      7    
i60 +  1      1      7    
i60 42 1.5    1      7    
i60 +  1.5    1      7    
i60 +  1.5    1      7    
i60 +  1.5    1      7    
i60 +  1      1      7    
i60 +  1      1      7    


;the melody---a Transylvanian folksong, "In the Graveyard," 
;transcribed from a Hungariton recording.

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
;i [destination],p2,p8,p9,[proclaimed pitch],p10...etc



i$Melody..71  1      0.25   -9.00  1      0      0      .25  
i$Melody..71  +      0.25   -9.00  1      0      0      .25  
i$Melody..71  +      0.5    -9.00  1      0      0      .5   
i$Melody..71  +      0.5    -9.02  1      0      0      .5   
i$Melody..71  +      0.5    -9.02  1      0      0      .5   
i$Melody..71  +      0.5    -9.02  1      0      0      .5   
i$Melody..71  +      0.25   -9.05  1      0      0      .25  
i$Melody..71  +      0.25   -9.05  1      0      0      .25  
i$Melody..71  +      1.0    -9.05  1      0      0      1    
i$Melody..71  +      1.0    -9.07  1      0      0      1    
i$Melody..71  +      0.5    -9.02  1      0      0      .5   
i$Melody..71  +      0.25   -9.00  1      0      0      .25  
i$Melody..71  +      1.0    -9.00  1      0      0      1    
i$Melody..71  +      2.0    -9.00  1      0      0      2    
i$Melody..71  +      2.0    -8.07  1      0      0      2    

i$Melody..71  12     0.5    -9.00  1      0      0      .5   
i$Melody..71  +      0.5    -9.02  1      0      0      .5   
i$Melody..71  +      0.5    -9.04  1      0      0      .5   
i$Melody..71  +      3.75   -9.00  1      0      0      3.75   
i$Melody..71  +      0.5    -9.07  1      0      0      .5   
i$Melody..71  +      0.5    -9.07  1      0      0      .5   
i$Melody..71  +      0.5    -9.09  1      0      0      .5   
i$Melody..71  +      3.5    -9.05  1      0      0      3.5  
i$Melody..71  +      0.5    -9.02  1      0      0      .5   
i$Melody..71  +      1.5    -9.00  1      0      0      1.5  
i$Melody..71  +      2.0    -8.07  1      0      0      2    

i$Melody..71  28     0.5    -8.07  1      0      0      .5   
i$Melody..71  +      0.5    -8.10  1      0      0      .5   
i$Melody..71  +      0.5    -8.10  1      0      0      .5   
i$Melody..71  +      1.0    -8.10  1      0      0      1    
i$Melody..71  +      0.5    -9.00  1      0      0      .5   
i$Melody..71  +      0.5    -9.00  1      0      0      .5   
i$Melody..71  +      0.5    -9.02  1      0      0      .5   
i$Melody..71  +      1.5    -8.10  1      0      0      1.5  
i$Melody..71  +      1.0    -9.00  1      0      0      1    
i$Melody..71  +      2.0    -9.02  1      0      0      2    
i$Melody..71  +      2.0    -8.10  1      0      0      2    

i$Melody..71  39     0.5    -9.05  1      0      0      .5   
i$Melody..71  +      0.5    -9.05  1      0      0      .5   
i$Melody..71  +      0.5    -9.05  1      0      0      .5   
i$Melody..71  +      1.3    -9.05  1      0      0      1.3  
i$Melody..71  41.5   0.5    -9.00  1      0      0      .5   
i$Melody..71  +      0.5    -9.02  1      0      0      .5   
i$Melody..71  +      0.5    -9.02  1      0      0      .5   
i$Melody..71  +      0.5    -9.00  1      0      0      .5   
i$Melody..71  +      1.0    -9.00  1      0      0      1    
i$Melody..71  +      0.5    -8.07  1      0      0      .5   
i$Melody..71  +      3.5    -8.07  1      0      0      3.5  
i$Melody..71  +      1.0    -8.07  1      0      0      1    

f0  51                                  ;otherwise schedule adds extra time to the end of the section.
e
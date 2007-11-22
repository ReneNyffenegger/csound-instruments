
#include"TUNING~2.TXT"	;tuning-related ftables
#include"MODEPR~2.TXT"	;mode-related ftables
#include"CHORDP~2.TXT"	;chord-related ftables
#include"OTHERF~1.TXT"	;other, synthesis-related ftables


;Here, I redefine the tuning, etc., to suit me:

;tuning tables (5--9)---number of degrees, list of .oct values. E.g.:
; 17-tone arabic pythagorean
f5  0 32    -2    17    0.00  0.075 0.150 0.170 0.245 0.320 0.340 0.415 0.490 0.565 0.585 0.660 0.735 0.755 0.830 0.905 0.980 0   
; al-farabi's 19
f6  0 32    -2    19    0.00  0.075 0.126 0.170 0.245 0.320 0.340 0.365 0.415 0.490 0.541 0.585 0.660 0.735 0.755 0.799 0.830 0.905 0.956 0
;basic just 12, 7-limit
f7  0 16    -2    12    0.00  0.093122    0.169927    0.222395    0.321930    0.415040    0.485429    0.584965    0.678074 0.777610 0.807357 0.906893 0.
;Rameau sharp
f8  0 16    -2    12    0.00  .0775 .1608333    .2541667    .3216667    .4191667    .485  .5808333    .6666667    .7416667 .8391667 .9025 0



;the church modes "on C"---0=Ionian, 1=Dorian,       2=Phrygian,     3=Lydian,       4=Mixolydian,   5=Aeolian,      6=Locrian.
f20 0 64    -2    7     12    7     0     2     4     5     7     9     11    0     2     3     5     7     9     10 0 1 3 5 7 8 10 0 2 4 6 7 9 11 0 2 4 5 7 9 10 0 2 3 5 7 8 10 0 1 3 5 6 8 10 



t0      60   

;PART1---USING SCALAR NOTATION:

;SCALAR NOTATION---the code is -ve:
;	-8ve.DD, where DD is the two-digit modal degree (0,...,99).
;	(note that scalar degree 00 is inaccesible in 8ve 0.)

;different octaves
i70 .25       .5     90     -5.00 
i70 +  .5     90     -6.00 
i70 +  .5     90     -7.00 
i70 +  .5     90     -8.00 
i70 +  .5     90     -9.00 
i70 +  .5     90     -10.00 
i70 +  .5     90     -11.00 


s
;proclaiming a new tuning (the default tuning is table 5):
i$Tuning      0      0      5           ; 17-tone arabic pythagorean
i70 .25       .5     90     -7.00
i70 +  .5     90     -7.01
i70 +  .5     90     -7.02
i70 +  .5     90     -7.03
i70 +  .5     90     -7.04 
i70 +  .5     90     -7.05 
i70 +  .5     90     -7.06 
i70 +  .5     90     -7.07
i70 +  .5     90     -7.08 
i70 +  .5     90     -7.09 
i70 +  .5     90     -7.10 
i70 +  .5     90     -7.11 
i70 +  .5     90     -7.12 
i70 +  .5     90     -7.13 
i70 +  .5     90     -7.14 
i70 +  .5     90     -7.15 
i70 +  .5     90     -7.16 
s
i$Tuning      0      0      6           ; al-farabi's 19
i70 .25       .25    90     -8.00
i70 +  .25    90     -8.01
i70 +  .25    90     -8.02
i70 +  .25    90     -8.03
i70 +  .25    90     -8.04 
i70 +  .25    90     -8.05 
i70 +  .25    90     -8.06 
i70 +  .25    90     -8.07
i70 +  .25    90     -8.08 
i70 +  .25    90     -8.09 
i70 +  .25    90     -8.10 
i70 +  .25    90     -8.11 
i70 +  .25    90     -8.12 
i70 +  .25    90     -8.13 
i70 +  .25    90     -8.14 
i70 +  .25    90     -8.15 
i70 +  .25    90     -8.16 
i70 +  .25    90     -8.17 
i70 +  .25    90     -8.18 

s
i$Tuning      0      0      8           ;Rameau sharp (a well teperament)
;comparing minor thirds:
i70 .5 .5     80     -8.00
i70 .55       .5     80     -8.03
i70 1.0       .5     80     -8.01
i70 1.05      .5     80     -8.04
i70 1.5       .5     80     -8.02
i70 1.55      .5     80     -8.05 
i70 2.0       .5     80     -8.03 
i70 2.05      .5     80     -8.06 
i70 2.5       .5     80     -8.04 
i70 2.55      .5     80     -8.07 
i70 3.0       .5     80     -8.05
i70 3.05      .5     80     -8.08 
i70 3.5       .5     80     -8.06 
i70 3.55      .5     80     -8.09 
i70 4.0       .5     80     -8.07 
i70 4.05      .5     80     -8.10 
i70 4.5       .5     80     -8.08 
i70 4.55      .5     80     -8.11 
i70 5.0       .5     80     -8.09 
i70 5.05      .5     80     -9.00 
i70 5.5       .5     80     -8.10 
i70 5.55      .5     80     -9.01 
i70 6.0       .5     80     -8.11 
i70 6.05      .5     80     -9.02 
s
;comparing fifths:
i70 .5 .5     80     -7.00
i70 .55       .5     80     -7.07
i70 1.0       .5     80     -7.01
i70 1.05      .5     80     -7.08
i70 1.5       .5     80     -7.02
i70 1.55      .5     80     -7.09 
i70 2.0       .5     80     -7.03 
i70 2.05      .5     80     -7.10 
i70 2.5       .5     80     -7.04 
i70 2.55      .5     80     -7.11 
i70 3.0       .5     80     -7.05
i70 3.05      .5     80     -8.00 
i70 3.5       .5     80     -7.06 
i70 3.55      .5     80     -8.01 
i70 4.0       .5     80     -7.07 
i70 4.05      .5     80     -8.02 
i70 4.5       .5     80     -7.08 
i70 4.55      .5     80     -8.03 
i70 5.0       .5     80     -7.09 
i70 5.05      .5     80     -8.04 
i70 5.5       .5     80     -7.10 
i70 5.55      .5     80     -8.05 
i70 6.0       .5     80     -7.11 
i70 6.05      .5     80     -8.06 
s

;PART 2---USING MODDAL NOTATION:

;MODAL NOTATION---the code is 0 or +ve:
;	8ve.DCC, where D is the one-digit modal degree (0,...,9)
;	and CC is the two-digit mode channel (00,...,39).

t0      120  
;mode proclaimer---
;          mode code  Markov tn SD offset mode channels
i$Mode 0      0      20.00  30     0      0      4 ;Ionian on "C"
;where,
;"mode code"=(mode table number).(two digit number of mode in table, 0..n)
;Markov table number is used in automatic melody/harmony generation.
;SD offset is used for modulation/transposition---the mode begins on
;	scalar degree 00+the offset.
;The last two numbers indicate a range of "mode channels" on which
;	to "proclaim" the current mode. (So, different lines might be 
;	in different modes.)

;a short melody in modal notation:
;in Ionian on "C"
i70 .2 0.5    86     8.0                ;Notice how the notation for the melody
i70 +  0.5    83     8.1                ;remains the same, while the mode changes.
i70 +  0.5    83     8.2    
i70 +  1.5    84     8.0     
i70 +  0.5    86     8.4    
i70 +  0.5    83     8.5    
i70 +  0.5    83     8.3    
i70 +  0.5    83     8.1    
i70 +  0.5    84     8.0    
i70 +  1.0    86     7.4    
i70 +  1.0    84     7.6    
i70 +  1.5    83     8.0    

i$Mode 10     0      20.01  30     0      0      4 ;Dorian on "C"
i70 10 0.5    86     8.0    
i70 +  0.5    83     8.1    
i70 +  0.5    83     8.2    
i70 +  1.5    84     8.0     
i70 +  0.5    86     8.4    
i70 +  0.5    83     8.5    
i70 +  0.5    83     8.3    
i70 +  0.5    83     8.1    
i70 +  0.5    84     8.0    
i70 +  1.0    86     7.4    
i70 +  1.0    84     7.6    
i70 +  1.5    83     8.0 

i$Mode 20     0      20.02  30     0      0      4 ;Phrygian on "C"
i70 20 0.5    86     8.0    
i70 +  0.5    83     8.1    
i70 +  0.5    83     8.2    
i70 +  1.5    84     8.0     
i70 +  0.5    86     8.4    
i70 +  0.5    83     8.5    
i70 +  0.5    83     8.3    
i70 +  0.5    83     8.1    
i70 +  0.5    84     8.0    
i70 +  1.0    86     7.4    
i70 +  1.0    84     7.6    
i70 +  1.5    83     8.0 

i$Mode 30     0      20.03  30     0      0      4 ;Lydian on "C"
i70 30 0.5    86     8.0    
i70 +  0.5    83     8.1    
i70 +  0.5    83     8.2    
i70 +  1.5    84     8.0     
i70 +  0.5    86     8.4    
i70 +  0.5    83     8.5    
i70 +  0.5    83     8.3    
i70 +  0.5    83     8.1    
i70 +  0.5    84     8.0    
i70 +  1.0    86     7.4    
i70 +  1.0    84     7.6    
i70 +  1.5    83     8.0 

i$Mode 40     0      20.03  30     7      0      4 ;Lydian on "G"
i70 40 0.5    86     8.0    
i70 +  0.5    83     8.1    
i70 +  0.5    83     8.2    
i70 +  1.5    84     8.0     
i70 +  0.5    86     8.4    
i70 +  0.5    83     8.5    
i70 +  0.5    83     8.3    
i70 +  0.5    83     8.1    
i70 +  0.5    84     8.0    
i70 +  1.0    86     7.4    
i70 +  1.0    84     7.6    
i70 +  1.5    83     8.0 

i$Mode 50     0      20.03  30     5      0      4 ;Lydian on "F"
i70 50 0.5    86     8.0    
i70 +  0.5    83     8.1    
i70 +  0.5    83     8.2    
i70 +  1.5    84     8.0     
i70 +  0.5    86     8.4    
i70 +  0.5    83     8.5    
i70 +  0.5    83     8.3    
i70 +  0.5    83     8.1    
i70 +  0.5    84     8.0    
i70 +  1.0    86     7.4    
i70 +  1.0    84     7.6    
i70 +  1.5    83     8.0 
s

;PART 3---USING CHORDAL NOTATION:

;CHORDAL NOTATION---the code is +ve and large, ~>=100:
;	Coo.c or CooOO.c where C=chord channel number {1, 2, 3}, 
;	oo=dictated 8ve number, 
;	ooOO= an acceptable range of 8ve numbers (inclusive) 	
;	(one will be chosen at random), and 
;	c=chord component number (1...6).
;	If c=0 or >6, one will be chosen at random. (I find this 
;	useful for pitched percussion, for example.)

;8  chord proclaimer---proclaims the presiding chords, as directed 
;			 	by the score, onto "chord channels" in ftable 4.
;p4=chord code, p5=chord channel 1--3, p6=mode channel
;chord code:
;0 or +ve=natural (selection from mode) modal root.type (.0) (types 0..n)
;-ve= selection from scale: scalar root.type (.00)(types 1..n)
;trailing digit=chord definition table number-10(modal) or -15(scalar)
;so, the trailing digits may be (.00--.04)if modal and (.000--.004)if scalar

i8  0  1      7.0    1      0           ;a circle of fifths every 7 seconds
i8  +  1      3.0    1      0    
i8  +  1      6.0    1      0    
i8  +  1      2.0    1      0    
i8  +  1      5.0    1      0    
i8  +  1      1.0    1      0    
i8  +  1      4.0    1      0    
i8  +  1      0.0    1      0    
i8  +  1      7.0    1      0        
i8  +  1      3.0    1      0    
i8  +  1      6.0    1      0    
i8  +  1      2.0    1      0    
i8  +  1      5.0    1      0    
i8  +  1      1.0    1      0    
i8  +  1      4.0    1      0    
i8  +  1      0.0    1      0    
i8  +  1      7.0    1      0        
i8  +  1      3.0    1      0    
i8  +  1      6.0    1      0    
i8  +  1      2.0    1      0    
i8  +  1      5.0    1      0    
i8  +  1      1.0    1      0    
i8  +  1      4.0    1      0    
i8  +  1      0.0    1      0    

i70 0  .25    86     107.1              ;Here, chordal notation is used to play 
i70 +  .25    86     107.2              ;an arppegio pattern.
i70 +  .25    86     107.3 
i70 +  .25    86     107.4 
i70 +  .25    86     107.1 	
i70 +  .25    86     107.2 	
i70 +  .25    86     107.3 
i70 +  .25    86     107.4 
i70 +  .25    86     107.1 	
i70 +  .25    86     107.2 	
i70 +  .25    86     107.3 
i70 +  .25    86     107.4 
i70 +  .25    86     107.1 	
i70 +  .25    86     107.2 	
i70 +  .25    86     107.3 
i70 +  .25    86     107.4 
i70 +  .25    86     107.1 	
i70 +  .25    86     107.2 	
i70 +  .25    86     107.3 
i70 +  .25    86     107.4 
i70 +  .25    86     107.1 	
i70 +  .25    86     107.2 	
i70 +  .25    86     107.3 
i70 +  .25    86     107.4 
i70 +  .25    86     107.1 	
i70 +  .25    86     107.2 	
i70 +  .25    86     107.3 
i70 +  .25    86     107.4 

i70 +  .25    86     107.0              ;here, random chord components in octave 7.
i70 +  .25    86     107.0 	
i70 +  .25    86     107.0 
i70 +  .25    86     107.0 
i70 +  .25    86     107.0 	
i70 +  .25    86     107.0 	
i70 +  .25    86     107.0 
i70 +  .25    86     107.0 
i70 +  .25    86     107.0 	
i70 +  .25    86     107.0 	
i70 +  .25    86     107.0 
i70 +  .25    86     107.0 
i70 +  .25    86     107.0 	
i70 +  .25    86     107.0 	
i70 +  .25    86     107.0 
i70 +  .25    86     107.0 
i70 +  .25    86     107.0 	
i70 +  .25    86     107.0 	
i70 +  .25    86     107.0 
i70 +  .25    86     107.0 
i70 +  .25    86     107.0 	
i70 +  .25    86     107.0 	
i70 +  .25    86     107.0 
i70 +  .25    86     107.0 
i70 +  .25    86     107.0 	
i70 +  .25    86     107.0 	
i70 +  .25    86     107.0 
i70 +  .25    86     107.0 

i70 +  .25    86     10608.0            ;here, random chord components in octaves 6, 7 or 8.
i70 +  .25    86     10608.0 	
i70 +  .25    86     10608.0 
i70 +  .25    86     10608.0 
i70 +  .25    86     10608.0 	
i70 +  .25    86     10608.0 	
i70 +  .25    86     10608.0 
i70 +  .25    86     10608.0 
i70 +  .25    86     10608.0 	
i70 +  .25    86     10608.0 	
i70 +  .25    86     10608.0 
i70 +  .25    86     10608.0 
i70 +  .25    86     10608.0 	
i70 +  .25    86     10608.0 	
i70 +  .25    86     10608.0 
i70 +  .25    86     10608.0 
i70 +  .25    86     10608.0 	
i70 +  .25    86     10608.0 	
i70 +  .25    86     10608.0 
i70 +  .25    86     10608.0 
i70 +  .25    86     10608.0 	
i70 +  .25    86     10608.0 	
i70 +  .25    86     10608.0 
i70 +  .25    86     10608.0 
i70 +  .25    86     10608.0 	
i70 +  .25    86     10608.0 	
i70 +  .25    86     10608.0 
i70 +  .25    86     10608.0 

e
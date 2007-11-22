
#include"TUNING~2.TXT"	;tuning-related ftables
#include"MODEPR~2.TXT"	;mode-related ftables
#include"CHORDP~2.TXT"	;chord-related ftables
#include"OTHERF~1.TXT"	;other, synthesis-related ftables

;Here, I redefine the tuning and chords to suit me:

;tuning tables (5--9)---number of degrees, list of .oct values. 
;
;Rameau sharp (a well temperament)
f5  0 16    -2    12    0.00  .0775 .1608333    .2541667    .3216667    .4191667    .485  .5808333    .6666667    .7416667 .8391667 .9025 0

;Chords may be defined either in terms of scalar or modal degrees.
;In this demo, I use scalar definitions (see harmonyGeneratorDEMO.sco
;for an example of modal chord definition):

;scalar chord definitions (15--19) select chords from a scale
; index 0=number of types,
; a list of table positions pointing to the beginning of each chord,
; a list of chords, each consisting of:
; number of components in chord, a list of steps from the root
; e.g. 3 4 7 = major triad
;
;  basic diatonic triads and 7ths from 12
; 1=major triad, 2=minor triad, 3=diminished triad, 4=augmented triad
; 5=MM tetrad, 6=Mm tetrad, 7=mM tetrad, 8=mm tetrad
; 9=dim-M tetrad, 10=dim-m tetrad, 11=aug-M tetrad, 12=aug-m tetrad
f15 0 128   -2    12    13    16    19    22    25    29    33    37    41    45    49    53    3     4     7     3 3 7 3 3 6 3 4 8 4 4 7 11 4 4 7 10 4 3 7 11 4 3 7 10 4 3 6 10 4 3 6 9 4 4 8 12 4 4 8 11





t0      60   

i$Tuning      0      0      5    
i$Mode 0      0      20.00  30     0      0      4    

;8  chord proclaimer---proclaims the presiding chords, as directed 
;			 	by the score, onto "chord channels" in ftable 4.
;p4=chord code, p5=chord channel 1--3, p6=mode channel
;chord code:
;0 or +ve=natural (selection from mode) modal root.type (.0) (types 0..n)
;-ve= selection from scale: scalar root.type (.00)(types 1..n)
;trailing digit=chord definition table number-10(modal) or -15(scalar)
;so, the trailing digits may be (.00--.04)if modal and (.000--.004)if scalar

i8  1  1      -05.0200      1    
i8  +  1      -10.0800      1    
i8  +  1      -03.0800      1    
i8  +  1      -08.0200      1    

i8  +  1      -01.0100      1    
i8  +  1      -07.0600      1    
i8  +  2      -00.0100      1    

i8  +  1      -00.0200      1    
i8  +  1      -05.0800      1    
i8  +  1      -10.0600      1    
i8  +  1      -03.0200      1    

i8  +  1      -09.0100      1    
i8  +  1      -02.0600      1    
i8  +  2      -07.0100      1    

i8  +  1      -09.0100      1    
i8  +  1      -02.0600      1    
i8  +  2      -07.0700      1    

i8  +  1      -06.0800      1    
i8  +  1      -11.0600      1    
i8  +  1      -04.0100      1    
i8  +  1      -00.0900      1    

i8  +  1      -05.0200      1    
i8  +  1      -10.0800      1    
i8  +  1      -03.0800      1    
i8  +  1      -08.0100      1    

i8  +  1      -01.0100      1    
i8  +  1      -01.0200      1    
i8  +  1      -00.0200      1    
i8  +  1      -11.0300      1    

i8  +  1      -10.0700      1    
i8  +  1      -03.0600      1    
i8  +  1      -08.0100      1    
i8  +  .5     -07.0700      1    
i8  +  .5     -00.0600      1    


;an instrument which plays the chord active on chord channel p4
i60 1  1      1    
i60 +  1      1    
i60 +  1      1    
i60 +  1      1    

i60 +  1      1    
i60 +  1      1    
i60 +  2      1    

i60 +  1      1    
i60 +  1      1    
i60 +  1      1    
i60 +  1      1    

i60 +  1      1    
i60 +  1      1    
i60 +  2      1    

i60 +  1      1    
i60 +  1      1    
i60 +  2      1    

i60 +  1      1    
i60 +  1      1    
i60 +  1      1    
i60 +  1      1    


i60 +  1      1    
i60 +  1      1    
i60 +  1      1    
i60 +  1      1    

i60 +  1      1    
i60 +  1      1    
i60 +  1      1    
i60 +  1      1    

i60 +  1      1    
i60 +  1      1    
i60 +  1      1    
i60 +  .5     1   
i60 +  .5     1   

s
;the chord proclaimer again, with the same chords:
i8  1  1      -05.0200      1    
i8  +  1      -10.0800      1    
i8  +  1      -03.0800      1    
i8  +  1      -08.0200      1    
i8  +  1      -01.0100      1    
i8  +  1      -07.0600      1    
i8  +  2      -00.0100      1    
i8  +  1      -00.0200      1    
i8  +  1      -05.0800      1    
i8  +  1      -10.0600      1    
i8  +  1      -03.0200      1    
i8  +  1      -09.0100      1    
i8  +  1      -02.0600      1    
i8  +  2      -07.0100      1    
i8  +  1      -09.0100      1    
i8  +  1      -02.0600      1    
i8  +  2      -07.0700      1    
i8  +  1      -06.0800      1    
i8  +  1      -11.0600      1    
i8  +  1      -04.0100      1    
i8  +  1      -00.0900      1    
i8  +  1      -05.0200      1    
i8  +  1      -10.0800      1    
i8  +  1      -03.0800      1    
i8  +  1      -08.0100      1    
i8  +  1      -01.0100      1    
i8  +  1      -01.0200      1    
i8  +  1      -00.0200      1    
i8  +  1      -11.0300      1    
i8  +  1      -10.0700      1    
i8  +  1      -03.0600      1    
i8  +  1      -08.0100      1    
i8  +  .5     -07.0700      1    
i8  +  .5     -00.0600      1    

;A demonstration of chordal addressing:
;	Coo.c or CooOO.c where C=chord channel number {1, 2, 3}, 
;	oo=dictated 8ve number, 
;	ooOO= an acceptable range of 8ve numbers (inclusive) 	
;	(one will be chosen at random), and 
;	c=chord component number (1...6).
;	If c=0 or >6, one will be chosen at random. 

;first, play the root of the chord in octave 6.:
i70 1  1      106.1
i70 +  1      106.1
i70 +  1      106.1
i70 +  1      106.1
i70 +  1      106.1
i70 +  1      106.1
i70 +  2      106.1
i70 +  1      106.1
i70 +  1      106.1
i70 +  1      106.1
i70 +  1      106.1
i70 +  1      106.1
i70 +  1      106.1
i70 +  2      106.1
i70 +  1      106.1
i70 +  1      106.1
i70 +  2      106.1
i70 +  1      106.1
i70 +  1      106.1
i70 +  1      106.1
i70 +  1      106.1
i70 +  1      106.1
i70 +  1      106.1
i70 +  1      106.1
i70 +  1      106.1
i70 +  1      106.1
i70 +  1      106.1
i70 +  1      106.1
i70 +  1      106.1
i70 +  1      106.1
i70 +  1      106.1
i70 +  1      106.1
i70 +  .5     106.1
i70 +  .5     106.1


;for the first half of the progression, play this arpegio pattern
;in octave 7:
i70 1.2       .8     107.3              ;5ths
i70 2.2       .8     107.3
i70 3.2       .8     107.3
i70 4.2       .8     107.3
i70 5.2       .8     107.3
i70 6.2       .8     107.3
i70 7.2       1.8    107.3
i70 9.2       .8     107.3
i70 10.2      .8     107.3
i70 11.2      .8     107.3
i70 12.2      .8     107.3
i70 13.2      .8     107.3
i70 14.2      .8     107.3
i70 15.2      1.8    107.3
i70 17.2      .8     107.3
i70 18.2      .8     107.3

i70 1.4       .6     107.4              ;7ths
i70 2.4       .6     107.4
i70 3.4       .6     107.4
i70 4.4       .6     107.4
i70 5.4       .6     107.4
i70 6.4       .6     107.4
i70 7.4       1.6    107.4
i70 9.4       .6     107.4
i70 10.4      .6     107.4
i70 11.4      .6     107.4
i70 12.4      .6     107.4
i70 13.4      .6     107.4
i70 14.4      .6     107.4
i70 15.4      1.6    107.4
i70 17.4      .6     107.4
i70 18.4      .6     107.4

i70 1.8       .3     107.2              ;3rds
i70 2.8       .3     107.2
i70 3.8       .3     107.2
i70 4.8       .3     107.2
i70 5.8       .3     107.2
i70 6.8       .3     107.2
i70 7.8       1.3    107.2
i70 9.8       .3     107.2
i70 10.8      .3     107.2
i70 11.8      .3     107.2
i70 12.8      .3     107.2
i70 13.8      .3     107.2
i70 14.8      .3     107.2
i70 15.8      1.3    107.2
i70 17.8      .3     107.2
i70 18.8      .3     107.2

;for the second half, play a pattern of 
;random chord components in octaves 7 and 8.  

i70 19 2      10708.0
i70 21 1      10708.0
i70 22 1      10708.0
i70 23 1      10708.0
i70 24 1      10708.0
i70 25 1      10708.0
i70 26 1      10708.0
i70 27 1      10708.0
i70 28 1      10708.0
i70 29 1      10708.0
i70 30 1      10708.0
i70 31 1      10708.0
i70 32 1      10708.0
i70 33 1      10708.0
i70 34 1      10708.0
i70 35 1      10708.0
i70 36 .5     10708.0
i70 36.5      .5     10708.0

i70 19.25     1.75   10708.0
i70 21.25     .75    10708.0
i70 22.25     .75    10708.0
i70 23.25     .75    10708.0
i70 24.25     .75    10708.0
i70 25.25     .75    10708.0
i70 26.25     .75    10708.0
i70 27.25     .75    10708.0
i70 28.25     .75    10708.0
i70 29.25     .75    10708.0
i70 30.25     .75    10708.0
i70 31.25     .75    10708.0
i70 32.25     .75    10708.0
i70 33.25     .75    10708.0
i70 34.25     .75    10708.0
i70 35.25     .75    10708.0
i70 36.25     .25    10708.0
i70 36.75     .25    10708.0

i70 19.5      1.5    10708.0
i70 21.5      .5     10708.0
i70 22.5      .5     10708.0
i70 23.5      .5     10708.0
i70 24.5      .5     10708.0
i70 25.5      .5     10708.0
i70 26.5      .5     10708.0
i70 27.5      .5     10708.0
i70 28.5      .5     10708.0
i70 29.5      .5     10708.0
i70 30.5      .5     10708.0
i70 31.5      .5     10708.0
i70 32.5      .5     10708.0
i70 33.5      .5     10708.0
i70 34.5      .5     10708.0
i70 35.5      .5     10708.0

i70 19.75     1.25   10708.0
i70 20.00     1.00   10708.0
i70 20.25     .75    10708.0
i70 20.50     .5     10708.0
i70 20.75     .25    10708.0
i70 21.75     .25    10708.0
i70 22.75     .25    10708.0
i70 23.75     .25    10708.0
i70 24.75     .25    10708.0
i70 25.75     .25    10708.0
i70 26.75     .25    10708.0
i70 27.75     .25    10708.0
i70 28.75     .25    10708.0
i70 29.75     .25    10708.0
i70 30.75     .25    10708.0
i70 31.75     .25    10708.0
i70 32.75     .25    10708.0
i70 33.75     .25    10708.0
i70 34.75     .25    10708.0
i70 35.75     .25    10708.0

e
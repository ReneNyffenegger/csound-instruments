#include"ZAKINI~2.TXT"	;zak initializer definition
#include"TUNING~2.TXT"	;tuning-related ftables
#include"MODEPR~2.TXT"	;mode-related ftables
#include"CHORDP~2.TXT"	;chord-related ftables
#include"STRUMM~1.TXT"	;the strum performer material
#include"OTHERF~1.TXT"	;other, synthesis-related ftables


;Here, I redefine the tuning, etc., to suit me:

;tuning tables (5--9)---number of degrees, list of .oct values. 
;
;Rameau sharp (a well temperament)
f5  0 16    -2    12    0.00  .0775 .1608333    .2541667    .3216667    .4191667    .485  .5808333    .6666667    .7416667 .8391667 .9025 0

;the church modes "on C"---0=Ionian, 1=Dorian,       2=Phrygian,     3=Lydian,       4=Mixolydian,   5=Aeolian,      6=Locrian.
f20 0 64    -2    7     12    7     0     2     4     5     7     9     11    0     2     3     5     7     9     10 0 1 3 5 7 8 10 0 2 4 6 7 9 11 0 2 4 5 7 9 10 0 2 3 5 7 8 10 0 1 3 5 6 8 10 


;accordatura tables (~60--80): index 0=number of "strings", 
; subsequently, (8ve.SD)s
; std guitar:
f60 0 16    -2    6     6.04  6.09  7.02  7.07  7.11  8.04  0
;  bass guitar 
f61 0 16    -2    4     5.04  5.09  6.02  6.07  0 
;  neopolitan mandolin 
f62 0 16    -2    4     7.07  8.02  8.09  9.04  0 


t0      60   

;tuning proclaimer---
i$Tuning      0      0      5    

;mode proclaimer---
i$Mode 0      0      20.00  30     0      0      4 ;Ionian on "C"

;8  chord proclaimer---proclaims the presiding chords, as directed 
;			 	by the score, onto "chord channels" in ftable 4.

i8  1  1      7.0    1      0           ;a circle of fifths every 7 seconds
i8  +  1      3.0    1      0    
i8  +  1      6.0    1      0    
i8  +  1      2.0    1      0    
i8  +  1      5.0    1      0    
i8  +  1      1.0    1      0    
i8  +  1      4.0    1      0    
i8  +  1      0.0    1      0    
i$Mode 9      0      20.00  30     7      0      4 ;Ionian on "G"
i8  +  1      7.0    1      0           ;a circle of fifths every 7 seconds
i8  +  1      3.0    1      0    
i8  +  1      6.0    1      0    
i8  +  1      2.0    1      0    
i8  +  1      5.0    1      0    
i8  +  1      1.0    1      0    
i8  +  1      4.0    1      0    
i8  +  1      0.0    1      0    
i$Mode 16     0      20.00  30     5      0      4 ;Ionian on "F"
i8  +  1      7.0    1      0           ;a circle of fifths every 7 seconds
i8  +  1      3.0    1      0    
i8  +  1      6.0    1      0    
i8  +  1      2.0    1      0    
i8  +  1      5.0    1      0    
i8  +  1      1.0    1      0    
i8  +  1      4.0    1      0    
i8  +  1      0.0    1      0    
i$Mode 23     0      20.01  30     0      0      4 ;Dorian on "C"
i8  +  1      7.0    1      0           ;a circle of fifths every 7 seconds
i8  +  1      3.0    1      0    
i8  +  1      6.0    1      0    
i8  +  1      2.0    1      0    
i8  +  1      5.0    1      0    
i8  +  1      1.0    1      0    
i8  +  1      4.0    1      0    
i8  +  1      0.0    1      0    
i$Mode 30     0      20.01  30     7      0      4 ;Dorian on "G"
i8  +  1      7.0    1      0           ;a circle of fifths every 7 seconds
i8  +  1      3.0    1      0    
i8  +  1      6.0    1      0    
i8  +  1      2.0    1      0    
i8  +  1      5.0    1      0    
i8  +  1      1.0    1      0    
i8  +  1      4.0    1      0    
i8  +  1      0.0    1      0    
i$Mode 37     0      20.01  30     5      0      4 ;Dorian on "D"
i8  +  1      7.0    1      0           ;a circle of fifths every 7 seconds
i8  +  1      3.0    1      0    
i8  +  1      6.0    1      0    
i8  +  1      2.0    1      0    
i8  +  1      5.0    1      0    
i8  +  1      1.0    1      0    
i8  +  1      4.0    1      0    
i8  +  1      0.0    1      0    


;21 strummer---performs a strum (a series of overlapping, sustained notes)
;			on any other instrument given a chord channel, an
;			accordatura and other performance parameters.
;			Note: expects the destination instrument to take
;			p4=dB and p5=generalized pitch code.
;p1=21.xxyyy..., where xx.yyy... is the destination instrument.
;p3=sounding duration (of each note)
;p4=dB
;p5=chord channel number {1,2,3}
;p6=accordatura table number
;  +ve if strumming up, -ve is strumming down.
;p7=seconds in which to traverse fretboard
;p8=capo position (may be -ve)
;p9=tilt of plectrum effective on [-1,1],
;  -1=very bass-heavy, 1=very treble-heavy
;p10...-->p6... of destination instrument 
;  (the destination's p5's become assigned pitches)
;     dest st ntDur dB Cch AccTN stDur pos tilt    STD guitar accordatura:
i$strum..70   1      .7     80     1      60     .9     0      0 ;downward, increasingly fast
i$strum..70   2      .7     80     1      60     .75    0      0     	
i$strum..70   3      .7     80     1      60     .5     0      0     	
i$strum..70   4      .7     80     1      60     .3     0      0     	
i$strum..70   5      1      80     1      60     .2     0      0     	
i$strum..70   6      1      80     1      60     .1     0      0     	
i$strum..70   7      1      80     1      60     .05    0      0    
i$strum..70   8      1      80     1      -60    .05    0      0 ;upward, increasingly slow
i$strum..70   9      1      80     1      -60    .1     0      0     	
i$strum..70   10     1      80     1      -60    .2     0      0     	
i$strum..70   11     .7     80     1      -60    .3     0      0     	
i$strum..70   12     .7     80     1      -60    .5     0      0     	
i$strum..70   13     .7     80     1      -60    .75    0      0     	
i$strum..70   14     .7     80     1      -60    .9     0      0    
i$strum..70   15     .8     80     1      60     .2     0      0 ;downward, increasingly bass-heavy
i$strum..70   16     .8     80     1      60     .2     0      -.1  
i$strum..70   17     .8     80     1      60     .2     0      -.2  
i$strum..70   18     .8     80     1      60     .2     0      -.4  
i$strum..70   19     .8     80     1      60     .2     0      -.6  
i$strum..70   20     .8     80     1      60     .2     0      -.8  
i$strum..70   21     .8     80     1      60     .2     0      -1   
i$strum..70   22     .8     80     1      60     .2     0      0 ;downward, increasingly treble-heavy
i$strum..70   23     .8     80     1      60     .2     0      .1   
i$strum..70   24     .8     80     1      60     .2     0      .2   
i$strum..70   25     .8     80     1      60     .2     0      .4   
i$strum..70   26     .8     80     1      60     .2     0      .6   
i$strum..70   27     .8     80     1      60     .2     0      .8   
i$strum..70   28     .8     80     1      60     .2     0      1    
i$strum..70   29     .8     80     1      -60    .3     0      0 ;upward, increasingly high position
i$strum..70   30     .8     80     1      -60    .3     3      0    
i$strum..70   31     .8     80     1      -60    .3     6      0    
i$strum..70   32     .8     80     1      -60    .3     9      0    
i$strum..70   33     .8     80     1      -60    .3     12     0   
i$strum..70   34     .8     80     1      -60    .3     18     0   
i$strum..70   35     .8     80     1      -60    .3     24     0   
i$strum..70   36     .8     80     1      -60    .3     0      0 ;upward, increasingly low position
i$strum..70   37     .8     80     1      -60    .3     -3     0   
i$strum..70   38     .8     80     1      -60    .3     -6     0   
i$strum..70   39     .8     80     1      -60    .3     -9     0   
i$strum..70   40     .8     80     1      -60    .3     -12    0  
i$strum..70   41     .8     76     1      -60    .3     -18    0  
i$strum..70   42     .8     76     1      -60    .3     -24    0  

f0  44
s

i$Mode 0      0      20.02  30     0      0      4 ;Phrygian on "C"
i8  1  1      7.0    1      0           ;a circle of fifths every 7 seconds
i8  +  1      3.0    1      0    
i8  +  1      6.0    1      0    
i8  +  1      2.0    1      0    
i8  +  1      5.0    1      0    
i8  +  1      1.0    1      0    
i8  +  1      4.0    1      0    
i8  +  1      0.0    1      0    
i$Mode 9      0      20.02  30     7      0      4 ;Phrygian on "G"
i8  +  1      7.0    1      0           ;a circle of fifths every 7 seconds
i8  +  1      3.0    1      0    
i8  +  1      6.0    1      0    
i8  +  1      2.0    1      0    
i8  +  1      5.0    1      0    
i8  +  1      1.0    1      0    
i8  +  1      4.0    1      0    
i8  +  1      0.0    1      0    
i$Mode 16     0      20.02  30     5      0      4 ;Phrygian on "F"
i8  +  1      7.0    1      0           ;a circle of fifths every 7 seconds
i8  +  1      3.0    1      0    
i8  +  1      6.0    1      0    
i8  +  1      2.0    1      0    
i8  +  1      5.0    1      0    
i8  +  1      1.0    1      0    
i8  +  1      4.0    1      0    
i8  +  1      0.0    1      0    
i$Mode 23     0      20.03  30     0      0      4 ;Lydian on "C"
i8  +  1      7.0    1      0           ;a circle of fifths every 7 seconds
i8  +  1      3.0    1      0    
i8  +  1      6.0    1      0    
i8  +  1      2.0    1      0    
i8  +  1      5.0    1      0    
i8  +  1      1.0    1      0    
i8  +  1      4.0    1      0    
i8  +  1      0.0    1      0    
i$Mode 30     0      20.03  30     7      0      4 ;Lydian on "G"
i8  +  1      7.0    1      0           ;a circle of fifths every 7 seconds
i8  +  1      3.0    1      0    
i8  +  1      6.0    1      0    
i8  +  1      2.0    1      0    
i8  +  1      5.0    1      0    
i8  +  1      1.0    1      0    
i8  +  1      4.0    1      0    
i8  +  1      0.0    1      0    
i$Mode 37     0      20.03  30     5      0      4 ;Lydian on "D"
i8  +  1      7.0    1      0           ;a circle of fifths every 7 seconds
i8  +  1      3.0    1      0    
i8  +  1      6.0    1      0    
i8  +  1      2.0    1      0    
i8  +  1      5.0    1      0    
i8  +  1      1.0    1      0    
i8  +  1      4.0    1      0    
i8  +  1      0.0    1      0    

;as above, but with the accordatura of a neopolitan mandolin
i$strum..70   1      .7     80     1      62     .9     0      0 ;downward, increasingly fast
i$strum..70   2      .7     80     1      62     .75    0      0     	
i$strum..70   3      .7     80     1      62     .5     0      0     	
i$strum..70   4      .7     80     1      62     .3     0      0     	
i$strum..70   5      1      80     1      62     .2     0      0     	
i$strum..70   6      1      80     1      62     .1     0      0     	
i$strum..70   7      1      80     1      62     .05    0      0    
i$strum..70   8      1      80     1      -62    .05    0      0 ;upward, increasingly slow
i$strum..70   9      1      80     1      -62    .1     0      0     	
i$strum..70   10     1      80     1      -62    .2     0      0     	
i$strum..70   11     .7     80     1      -62    .3     0      0     	
i$strum..70   12     .7     80     1      -62    .5     0      0     	
i$strum..70   13     .7     80     1      -62    .75    0      0     	
i$strum..70   14     .7     80     1      -62    .9     0      0    
i$strum..70   15     .8     80     1      62     .03    0      0 ;downward, increasingly bass-heavy
i$strum..70   16     .8     80     1      62     .03    0      -.1  
i$strum..70   17     .8     80     1      62     .03    0      -.2  
i$strum..70   18     .8     80     1      62     .03    0      -.4  
i$strum..70   19     .8     80     1      62     .03    0      -.6  
i$strum..70   20     .8     80     1      62     .03    0      -.8  
i$strum..70   21     .8     80     1      62     .03    0      -1   
i$strum..70   22     .8     80     1      62     .03    0      0 ;downward, increasingly treble-heavy
i$strum..70   23     .8     80     1      62     .03    0      .1   
i$strum..70   24     .8     80     1      62     .03    0      .2   
i$strum..70   25     .8     80     1      62     .03    0      .4   
i$strum..70   26     .8     80     1      62     .03    0      .6   
i$strum..70   27     .8     80     1      62     .03    0      .8   
i$strum..70   28     .8     80     1      62     .03    0      1    
i$strum..70   29     .8     80     1      -62    .03    0      0 ;upward, increasingly high position
i$strum..70   30     .8     80     1      -62    .03    3      0    
i$strum..70   31     .8     80     1      -62    .03    6      0    
i$strum..70   32     .8     80     1      -62    .03    9      0    
i$strum..70   33     .8     80     1      -62    .03    12     0   
i$strum..70   34     .8     80     1      -62    .03    18     0   
i$strum..70   35     .8     80     1      -62    .03    24     0   
i$strum..70   36     .8     80     1      -62    .03    0      0 ;upward, increasingly low position
i$strum..70   37     .8     80     1      -62    .03    -3     0   
i$strum..70   38     .8     80     1      -62    .03    -6     0   
i$strum..70   39     .8     80     1      -62    .03    -9     0   
i$strum..70   40     .8     80     1      -62    .03    -12    0  
i$strum..70   41     .8     80     1      -62    .03    -18    0  
i$strum..70   42     .8     80     1      -62    .03    -24    0  

f0  44
s
;in this section, strumming on a French horn as if it were a guitar:

i$Zakinit     0      0      12     6      0      3    
# define monoOut #198 #
# define chClear #199 #
i$monoOut     0      -1     -1  
i$chClear     0      -1   

i$Mode 0      0      20.04  30     0      0      4 ;Mixolydian on "C"
i8  1  1      7.0    1      0           ;a circle of fifths every 7 seconds
i8  +  1      3.0    1      0    
i8  +  1      6.0    1      0    
i8  +  1      2.0    1      0    
i8  +  1      5.0    1      0    
i8  +  1      1.0    1      0    
i8  +  1      4.0    1      0    
i8  +  1      0.0    1      0    
i$Mode 9      0      20.04  30     7      0      4 ;Mixolydian on "G"
i8  +  1      7.0    1      0           ;a circle of fifths every 7 seconds
i8  +  1      3.0    1      0    
i8  +  1      6.0    1      0    
i8  +  1      2.0    1      0    
i8  +  1      5.0    1      0    
i8  +  1      1.0    1      0    
i8  +  1      4.0    1      0    
i8  +  1      0.0    1      0    
i$Mode 16     0      20.04  30     5      0      4 ;Mixolydian on "F"
i8  +  1      7.0    1      0           ;a circle of fifths every 7 seconds
i8  +  1      3.0    1      0    
i8  +  1      6.0    1      0    
i8  +  1      2.0    1      0    
i8  +  1      5.0    1      0    
i8  +  1      1.0    1      0    
i8  +  1      4.0    1      0    
i8  +  1      0.0    1      0    
i$Mode 23     0      20.05  30     0      0      4 ;Aeolian on "C"
i8  +  1      7.0    1      0           ;a circle of fifths every 7 seconds
i8  +  1      3.0    1      0    
i8  +  1      6.0    1      0    
i8  +  1      2.0    1      0    
i8  +  1      5.0    1      0    
i8  +  1      1.0    1      0    
i8  +  1      4.0    1      0    
i8  +  1      0.0    1      0    
i$Mode 30     0      20.05  30     7      0      4 ;Aeolian on "G"
i8  +  1      7.0    1      0           ;a circle of fifths every 7 seconds
i8  +  1      3.0    1      0    
i8  +  1      6.0    1      0    
i8  +  1      2.0    1      0    
i8  +  1      5.0    1      0    
i8  +  1      1.0    1      0    
i8  +  1      4.0    1      0    
i8  +  1      0.0    1      0    
i$Mode 37     0      20.05  30     5      0      4 ;Aeolian on "D"
i8  +  1      7.0    1      0           ;a circle of fifths every 7 seconds
i8  +  1      3.0    1      0    
i8  +  1      6.0    1      0    
i8  +  1      2.0    1      0    
i8  +  1      5.0    1      0    
i8  +  1      1.0    1      0    
i8  +  1      4.0    1      0    
i8  +  1      0.0    1      0    


;subFrenchHorn--
;tremolo depth is with vibrato if +ve, against it if -ve
;registers: reg0=6.05--8.06 (9.02)  registers are +/- perfect 5ths from this
;          ST   DUR   db  PCH   PCH   AMP PEAK PEAK  VD%  TREMD GLISS PREV  REGI-  OUT
;                               FROM  TO   AMP POINT       dB    TO   GLISS -STR   CH
;i$subFhorn +    0.5   92 -6.05  pp5    0    0  0.5    .5    .     0     .     0    0
;i$subFhorn +    0.5   92 -6.07  pp5    0    0  0.5    .5    .     0     .     0    0

;     dest st ntDur dB Cch AccTN stDur pos tilt    the remaining pfields for the French horn:
i$strum..71   1      .7     80     1      60     .9     0      0      -9.00  0      6      .2     .5     2      0 0 0 0
i$strum..71   2      .7     76     1      60     .75    0      0     	
i$strum..71   3      .7     76     1      60     .5     0      0 ;downward, increasingly fast	
i$strum..71   4      .7     76     1      60     .3     0      0     	
i$strum..71   5      1      76     1      60     .2     0      0     	
i$strum..71   6      1      73     1      60     .1     0      0     	
i$strum..71   7      1      73     1      60     .05    0      0    
i$strum..71   8      1      76     1      -60    .05    0      0 ;upward, increasingly slow
i$strum..71   9      1      76     1      -60    .1     0      0     	
i$strum..71   10     1      72     1      -60    .2     0      0     	
i$strum..71   11     .7     73     1      -60    .3     0      0     	
i$strum..71   12     .7     76     1      -60    .5     0      0     	
i$strum..71   13     .7     76     1      -60    .75    0      0     	
i$strum..71   14     .7     76     1      -60    .9     0      0    
i$strum..71   15     .6     76     1      60     .4     0      0 ;downward, increasingly bass-heavy
i$strum..71   16     .6     78     1      60     .4     0      -.1  
i$strum..71   17     .6     80     1      60     .4     0      -.2  
i$strum..71   18     .6     81     1      60     .4     0      -.4  
i$strum..71   19     .6     84     1      60     .4     0      -.6  
i$strum..71   20     .6     86     1      60     .4     0      -.8  
i$strum..71   21     .6     86     1      60     .4     0      -1   
i$strum..71   22     .6     76     1      60     .4     0      0 ;downward, increasingly treble-heavy
i$strum..71   23     .6     77     1      60     .4     0      .1   
i$strum..71   24     .6     78     1      60     .4     0      .2   
i$strum..71   25     .6     79     1      60     .4     0      .4   
i$strum..71   26     .6     80     1      60     .4     0      .6   
i$strum..71   27     .6     80     1      60     .4     0      .8   
i$strum..71   28     .6     80     1      60     .4     0      1    
i$strum..71   29     .6     76     1      -60    .4     0      0 ;upward, increasingly high position
i$strum..71   30     .6     76     1      -60    .4     3      0    
i$strum..71   31     .6     76     1      -60    .4     6      0    
i$strum..71   32     .6     76     1      -60    .4     9      0    
i$strum..71   33     .6     73     1      -60    .4     12     0   
i$strum..71   34     .6     72     1      -60    .4     18     0   
i$strum..71   35     .6     70     1      -60    .4     24     0   
i$strum..71   36     .6     76     1      -60    .4     0      0 ;upward, increasingly low position
i$strum..71   37     .6     76     1      -60    .4     -3     0   
i$strum..71   38     .6     76     1      -60    .4     -6     0   
i$strum..71   39     .6     76     1      -60    .4     -9     0   
i$strum..71   40     .6     76     1      -60    .4     -12    0  
i$strum..71   41     .6     78     1      -60    .4     -18    0  
i$strum..71   42     .6     80     1      -60    .4     -24    0  



f0  44
e
; Tempo = 72 beats/min
t00     72										
; Simple Sine Function
f01 0 512   10    1        						
; Ramp
f02 0 513   7     0     513   1   				
; Exponential rise
f03 0 513   5     .001  513   1   				
; Quarter Sine Wave in 128 locs + extended guard point
f04 0 129   9     .25   1     0     				
; Quarter Cosine
f05 0 129   9     .25   1     90    				
; Triangular Wave
f06 0 512   10    1     0     .111  0     .04   0     .02   0 
                        .012											
; Sawtooth Wave with 20 partials
f07 0 512   10    1     .5    .3    .25   .2    .167  .14   .125
                        .111    .1      .09     .083    .077    .071    .067    .063    .059    .055    .053    .05
; Square Wave
f08 0 512   10    1     0     .3    0     .2    0     .14   0 
                        .111											
; Narrow Pulse
f09 0 512   10    1     1     1     1     .7    .5    .3    .1 
; Exponential rise and decay
f10 0 513   5     .1    32    1     480   .01			
; Reverse pyramid
f11 0 513   7     1     256   0     256   1       		
;=================================================================;
;	Instr 1-4:  Portamento/Panning Instrument
;
; p4=amp	p5=pch	p6=portsize (oct)	p7=delay	p8=ofn	p9=p3 in beats 
; 
; N.B.: uses score variables np10/pp3 to copy p3 to p9.  (Used to convert beats to seconds
; in the instrument code by comparing the original value of p3 (still in p9) to the value 
; after tempo modifications.)  Unfortunately, CSound has no variable to copy a p-field on
; the  same line, but by using np10 to point to p10 of the next line, which in turn uses pp3
; to  point back to p3 of the current line, we can circumvent this strange omission by MIT. 
;=================================================================;
;p1	p2	p3	p4	p5	p6	p7	p8	p9	p10	p11	p12
i01 0  1      15000  8.00   .5     .5     6      np10   0		
i01 .5 .      .      .      -.5    .      .      1      pp3		
; Use an f0 card to make sure the current section lasts 2.5 beats.  Since the final note in the
; section ends at beat 1.5, the f0 will provide a 1 beat rest before the next section begins.
f0  2.5										
; start a new section now, after the last event in the previous section (here,  the f0 card).
s											
;=================================================================;
;	Instr 5-8:  Simple Gating Instrument with Chorus
;
; p4=amp	p5=pch1	p6=pch2	p7=risefac	p8=decfac	
;
; p9=ofn1	p10=ofn2	p11=gatefn	p12=beathz	p13=gatehz
; 
;=================================================================;
;p1	p2	p3	p4	p5	p6	p7	p8	p9	p10	p11	p12	p13
i05 0  2.5    15000  7.07   8.07   .02    .4     9      6      10     .3     0   
i05 3  4      .      8.01   8.01   .      .      7      1      11     0      1    
f0  8											
s												
;========================================================================================;
;	Instr9-12:  Basic FM Instrument with Variable Vibrato
;
;	p4=amp	p5=pch(fund)	p6=vibdel	p7=vibrate	p8=vibwth	p9=rise
;						
;	p10=decay	p11=max ndx	p12=car fac	p13=modfac	p14=ndxrise	p15=ndxdec

;			p16=ch1 fac	p17=orig p3	p18=orig p3 of previous i-card
;=========================================================================================;
;p1	p2	p3	p4	p5	p6	p7	p8	p9	p10	p11	p12
i09 0  4      25000  7.05   2      6      .01    1      1      4      1    
;	p13	p14	p15	p16	p17	p18					
                        1       0       0       0       np18						
i09 4  .      .      .      .      .      .      .      .      3      3    
       2      .      .      .      .      pp3        				
;The big Chowning FM bell...
i09 8  8      .      .      0      0      0      .01    7.9    10     1.4 
       1      .      .      .      8         
f0  18
s					
;functions for partial instrument:
f1  0 512   10    1     .2  
;use minus sign in front of gen number to skip rescaling:
f2  0 512   -10   0     .7    0     .5    0     .3    0     .2    0     .1  
f3  0 512   -10   0     0     0     0     .2    .3    .4 
f4  0 512   -10   0     0     0     0     0     0     0     0     .5    .6    .7 
i13 0  5      32000  7.00   .5     1   
e

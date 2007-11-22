; test .sco file for i-time fileload hrtfer

; -this score places two instruments at opposite ends of a given direction
; -i.e. 90 & -90 degrees azimuth, 0 & 180 degrees azimuth,  
;       and -40 & 90 degrees elevation (the elevation limits of MIT's HRTFs)

; remeber that csound will only hold upto 20 files in memory before it
; causes a segmentation fault.

f1  0 8192  10    1  

; -negative values specify positions on the left 
; -positive values specify positions on the right
; -0 degrees azimuth is infront, 180 is in back
; -HRTFs for elevation range from 40 degrees below (-40) to 90 degrees above (90) 
; -0 degrees azimuth/elevation specifies the posistion directly ahead of the listener
;  at a distance of 1.4 meters (the distance used in MIT's HRTFs)


;                   AZIMUTH        ELEVATION
i1  0  1.4    0      0    
i2  1.2       1.6    0      0    

;i1	3	1.4		  -90		0
;i2	4.2	1.6		   90		0

;i1	6	1.4		   0		   	90
;i2	7.2	1.6		   0		    -40

;i1	9	1.4		   0		   	0
;i2	10.2	1.6		   180		0

;i1	12	1.4		   180		0
;i2	13.2	1.6		   0		   	0


e

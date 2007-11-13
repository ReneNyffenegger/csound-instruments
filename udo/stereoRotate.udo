/*
stereoRotate - The proper way to do stereo 'panning'.

DESCRIPTION
Rotates a stereo image.  It uses M/S methods to create a natural-sounding way to rotate the stereo image, as if you were rotating a stand holding a stereo microphone.  

SYNTAX
al, ar stereoRotate ainl, ainr, kangle

INITIALIZATION
ainl, ainr -- input audio signal

kangle -- the angle of rotation in degrees, usually in the range of -45 to +45

PERFORMANCE
This opcode uses the stereoMS UDO.

CREDITS
Joseph Anderson and ma++, jan 2005
*/

opcode stereoRotate, aa, aak

	ainl, ainr, ktheta xin

	; constants
	ipi		=	3.1416
	iradfac	=	ipi/180

	;compute coeffs
	ktheta	=	iradfac*ktheta
	kstheta	=	sin(ktheta)
	kctheta	=	cos(ktheta)

	;Matrix L/R to M/S
	ainm, ains	stereoMS	ainl, ainr
	
	;Do Rotate
	aimagm	=	kctheta*ainm - kstheta*ains
	aimags	=	kstheta*ainm + kctheta*ains
	
	;Matrix	back	to	L/R
	aoutl, aoutr stereoMS	aimagm, aimags

	xout aoutl, aoutr

endop	
 

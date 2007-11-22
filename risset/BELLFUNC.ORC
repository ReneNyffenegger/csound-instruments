; bellfunc.orc
;
; Even though csound only provides a limited number of stock gen subroutines,
; it includes one (gen 1) which can read in an external file.  Hence, you
; can use a standalone program to generate functions that aren't standard.
; In fact, as this example shows, you can use csound itself to create them.
; You just have to remember to perf with the floating point option (-f)...
;
; This orchestra will generate a bell-shaped function with max amp of 1.0 --
; required by endless.orc for an amplitude control function.
; Say "perf -f bellfunc.orc bellfunc.sco" to run it, then rename the output
; test.sf file to soundin.10 so that endless.sco can read it in via Gen 1.  rp
;
sr		=		1					; N.B. WE'RE NOT GENERATING AUDIO HERE, JUST...
kr		=		1					; A BUNCH OF VALUES FOR AN ARRAY, SO THE...
ksmps	=		1					; sr AND kr DON'T REALLY MATTER.  HOWEVER,...
ksmps	=		1					; IT'S CONVENIENT TO MAKE THEM = 1, SO THAT...
nchnls	=		1					; p3 CAN BE USED TO SPECIFY THE NUMBER OF...
									; VALUES TO COMPUTE DIRECTLY.

		instr   1
ipi		=		3.14159
isize	=		p3-1					; SINCE sr=1, p3 HAS NUMBER OF LOCS TO GENERATE
kx		init		0
; RISSET'S FORMULA (FROM DODGE):  exp(-4.8283*(1-cos(2*ipi*(kx-1023.5)/2047)))
aval		=		exp(-4.8283*(1+cos(2*ipi*kx/isize)))        
kx		=		kx+1                
		out		aval
		endin

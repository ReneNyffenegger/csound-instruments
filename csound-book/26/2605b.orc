strset 9, "fox.aif"
strset 11, "hello.aif"
strset 12, "lowPass3kHz.con"
strset 13, "lowPass1kHz.con"
strset 14, "lowPass300Hz.con"
strset 15, "rimShot.con"
strset 16, "bassDrum.con"

   instr  3005  ;LOWPASS DEMOS
iscale = p4
iexcite	=	p5
irespond	= p6
aa soundin  iexcite
ab convolve aa, irespond ;Use cvanal to make
   out      ab*iscale
   endin

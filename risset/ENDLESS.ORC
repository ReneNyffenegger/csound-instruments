;==========================================================================;
;                 DODGE/RISSET ENDLESS GLISSANDO INSTRUMENT                ;
;                                                                          ;
; AN IMPLEMENTATION OF JEAN CLAUDE RISSET'S SYNTHESIS DESIGN FOR THE       ;
; "ENDLESS GLISSANDO," REPRINTED IN THE DODGE/JERSE TEXTBOOK.              ;
; NOTE: YOU MUST RUN THE BELLFUNC.ORC TO GENERATE SOUNDIN.10 (USED IN      ;
; ENDLESS.SCO) FIRST.                                                      ;
; RUSSELL PINKSTON                                                         ;
;==========================================================================;
        sr          =         44100
        kr          =         4410
        ksmps  =         10
        nchnls =         1

                instr   1
        ifreq   =       p5
                if      (ifreq >= 20) igoto continue        
        ifreq   =       cpspch(p5)              ;p5 must be in oct.pch
continue:
        kphase  phasor  1/p6
        kenvlp  linen   p4,1,p3,1

        kamp1   table   kphase,3,1,0,1 
        kcps1   tablei  kphase,4,1,0,1
        asig1   oscili  kamp1,kcps1*ifreq,1

        kamp2   table   kphase+.1,3,1,0,1 
        kcps2   tablei  kphase+.1,4,1,0,1
        asig2   oscili  kamp2,kcps2*ifreq,1

        kamp3   table   kphase+.2,3,1,0,1 
        kcps3   tablei  kphase+.2,4,1,0,1
        asig3   oscili  kamp3,kcps3*ifreq,1

        kamp4   table   kphase+.3,3,1,0,1 
        kcps4   tablei  kphase+.3,4,1,0,1
        asig4   oscili  kamp4,kcps4*ifreq,1

        kamp5   table   kphase+.4,3,1,0,1 
        kcps5   tablei  kphase+.4,4,1,0,1
        asig5   oscili  kamp5,kcps5*ifreq,1

        kamp6   table   kphase+.5,3,1,0,1 
        kcps6   tablei  kphase+.5,4,1,0,1
        asig6   oscili  kamp6,kcps6*ifreq,1

        kamp7   table   kphase+.6,3,1,0,1 
        kcps7   tablei  kphase+.6,4,1,0,1
        asig7   oscili  kamp7,kcps7*ifreq,1

        kamp8   table   kphase+.7,3,1,0,1 
        kcps8   tablei  kphase+.7,4,1,0,1
        asig8   oscili  kamp8,kcps8*ifreq,1

        kamp9   table   kphase+.8,3,1,0,1 
        kcps9   tablei  kphase+.8,4,1,0,1
        asig9   oscili  kamp9,kcps9*ifreq,1

        kamp10  table   kphase+.9,3,1,0,1 
        kcps10  tablei  kphase+.9,4,1,0,1
        asig10  oscili  kamp10,kcps10*ifreq,1

        asum    =       asig1+asig2+asig3+asig4+asig5+asig6+asig7+asig8+asig9+asig10
        
                out     asum*kenvlp

                endin

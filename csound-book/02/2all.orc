sr      =      	44100
kr    	=     	4410
ksmps  	=     	10
nchnls	=		1

	    instr 201
iskip   =       int(p5*sr)          ; STARTING SAMPLE IN SECONDS
ilast   =       int(sr*p3*p6)+iskip ; ENDING SAMPLE IN SECONDS
kenv    linseg  0, .05, p4, p3-.05, p4, .02, 0  ; ENV FUNCTION
aread   line    iskip, p3, ilast    ; a-rate TABLE INDEX
; aread line    ilast, p3, iskip    ; OPTIONAL: ilast TO iskip READS BACKWARD
asnd    tablei  aread, 30           ; SCANS F-TABLE 1
asig    =       asnd*kenv           ; IMPOSES ENVELOPE
        out     asig
        endin

                                    
        instr   202
kenv    linseg  0, .05, p4, p3-.1, p4*.8, .05, 0    ; ENVELOPE
aphase  phasor  p5                  ; PHASES 0-1 P5 TIMES/SECOND
ilength =       ftlen(p6)           ; DETERMINE LENGTH OF F-TABLE
aphase  =       aphase*ilength      ; STEP THROUGH ENTIRE TABLE
asig    tablei  aphase, p6          ; READ TABLE NUMBER FROM p6
        out     asig*kenv           ; IMPOSE ENVELOPE
        endin 
     
        instr   203
kenv    linseg  0, .05, p4, p3-.1, p4*.8, .05, 0    ; ENVELOPE
asig    oscili  kenv, p5, p6
        out     asig
        endin
    
        instr   204
ifrq    =       cpspch(p5)
kenv    linseg  0, .05, p4, p3-.1, p4*.8, .05, 0
asig    oscili  kenv, ifrq/21, 13
        out     asig
        endin
    
        instr   205
ksweep  linseg  0, p3*.5, .49, p3*.5, 0 ; INDEX SWEEP FUNCTION
aindex  oscili  ksweep, p5, 2   ;sound to waveshape
atable  tablei  aindex, 26, 1, .5   ;waveshape aindex
knorm   tablei  ksweep*2, 27, 1 ;make normalization fn
kenv    linen   p4, .01, p3, .02    ;amplitude envelope
    out atable*knorm*kenv   ;normalize and impose env
    endin

        instr 206       
iwshpfn =       p6  
inrmfn  =       p7  
kswp    linseg  0, p3*.5, .49, p3*.5, 0 ; INDEX SWEEP FUNCTION
aindex  oscili  kswp, p5, 2             ; SOUND TO WAVESHAPE
atable  tablei  aindex, iwshpfn, 1, .5  ; WAVESHAPE aindex
knrm    tablei  kswp*2, inrmfn, 1       ; MAKE NORMALIZATION FUNCTION
kenv    linen   p4, .01, p3, .02        ; AMPLITUDE ENVELOPE
        asig    =   (atable*knrm)*kenv  ; NORMALIZE AND IMPOSE ENV
        out     asig
        dispfft asig, .1, 1024
        endin       

        instr 207
idur    =           p3
iamp    =           p4
ifrq    =           cpspch(p5)          ; p5=DESIRED PITCH
iswp1   =           p6
iswp2   =           p7
kswp    line        iswp1, idur, iswp2  ; AMPLITUDE SWEEP VALUES
acosi   oscili      kswp*.5, ifrq, 2    ; f2=COSINE WAVE
asine   oscili      kswp, ifrq, 1       ; f1=SINE WAVE
atab1   tablei      acosi, 33, 1, .5    ; TABLES a1 TO GEN13
atab2   tablei      acosi, 34, 1, .5    ; TABLES a1 TO GEN14
knrm1   tablei      kswp, 35, 1         ; NORMALIZING f35
knrm2   tablei      kswp, 36, 1         ; NORMALIZING f36
anrm1   =           atab1*knrm1         ; NORMALIZE GEN13 SIGNAL
anrm2   =           atab2*knrm2*asine   ; NORMALIZE GEN14 SIGNAL
amix    =           anrm1+anrm2         ; MIX GEN13 AND GEN14
kenv    expseg      .001, idur*.1, iamp, idur*.1, iamp*.8, idur*.8, .001    
asig    =           amix*kenv   
        out         asig
        endin
        
    instr 208       
idur    =       p3  
iamp    =       p4  
icarfrq =       p5  
imodfrq =       p6          
aenv    expseg  .01, idur*.1, iamp, idur*.8, iamp*.75, idur*.1, .01
i1      =       p7*imodfrq          ; p7=MOD. INDEX START
i2      =       p8*imodfrq          ; p8=MOD. INDEX END
adev    line    i1, idur, i2        ; MODULATION FREQUENCY
aindex  line    p7, idur, p8        ; MODULATION INDEX
; r VALUE ENVELOPE: p9-p10 = EXP. PARTIAL STRENGTH PARAMETER START AND END
ar      linseg  1, .1, p9, p3-.2, p10, .1, 1
amp1    =       (aindex*(ar+(1/ar)))/2  
afmod   oscili  amp1, imodfrq, 1    ; FM MODULATOR (SINE)
atab    =       (aindex*(ar-(1/ar)))/2  ; INDEX TO TABLE
alook   tablei  atab, 37            ; TABLE LOOKUP TO GEN12
aamod   oscili  atab, imodfrq, 2    ; AM MODULATOR (COSINE)
aamod   =       (exp(alook+aamod))*aenv 
acar    oscili  aamod, afmod+icarfrq, 1 ; AFM (CARRIER) 
asig    balance acar, aenv
        out     asig    
        endin       

        instr 209       
idur    =       p3  
iamp    =       p4          
irow    =       12/idur             ; 12 NOTES PER NOTE DURATION
irowrep =       p5*irow             ; NUMBER OF TIMES TO REPEAT THE ROW
iseed   =       p6                  ; SEED 0-1, SAME SEED = SAME RANDOM SEQ
kenv    oscil   iamp, irowrep, 10   ; f10 = ENVELOPE FUNCTION
kcnt1   phasor  1/idur              ; COUNTS 0-1 OVER NOTE DURATION
kcnt2   =       kcnt1*12            ; COUNTS 0-12 OVER NOTE DURATION
kpc     table   kcnt2, 38           ; f38 = ROW
krn     randh   6, irowrep, iseed   ; DETERMINES RANDOM VALUE
koct    =       (abs(int(krn)))+5   ; CONVERTS TO RANDOM OCTAVE
kpch    =       koct+(kpc*.01)      ; FORMATS PC + RANDOM OCT TO PCH
kcps    =       cpspch(kpch)        ; CONVERTS PCH TO CPS
asig    oscil   kenv, kcps, 4       ; f4 = SQUARE WAVE
        out asig    
        endin       
    

        instr   210
kenv    linen   p4,.02,p3,.02       ; AMP ENVELOPE
                                    ; X INDEX VALUES FOLLOW
kxtrans line    p5,p3,p6            ; TRANSVERSE MOVEMENT IN X PLANE
kxamp   line    p7,p3,p8            ; INDEX OSCILLATOR AMPLITUDE
kxamp   =       kxamp*.5            ; NORMALIZES OSCIL AMP TO INDEX TABLE
kxfreq  line    p9,p3,p10           ; X PLANE INDEX OSCIL FREQUENCY
kxndx   oscili  kxamp,kxfreq,p11    ; p11=X INDEX FUNCTION
                                    ; TRY SINES, TRAINGLES, OR ASCENDING LINES FROM -1 TO +1 
                                    ; (PHASOR) ETC FOR INDEX FUNCTION
axndx   =       frac(kxndx+1000.5+kxtrans)  ; NEED FRACTIONAL VALUES
                                    ; TO GO FROM ONE TERRAIN BOUNDARY TO THE OTHER
                                    ; 1000.5 AVOIDS NEGATIVE VALUES AND SETS START POINT
                                    ; AT TABLE MIDPOINT
                                    ; Y INDEX VALUES FOLLOW
kytrans line    p12,p3,p13          ; TRANSVERSE MOVEMENT IN X PLANE
kyamp   line    p14,p3,p15          ; INDEX OSCILLATOR AMPLITUDE
kyamp   =       kyamp*.5            ; NORMALIZES OSCIL AMP TO INDEX TABLE
kyfreq  line    p16,p3,p17          ; X PLANE INDEX OSCIL FREQUENCY
kyndx   oscili  kyamp,kyfreq,p18    ; p11=X INDEX FUNCTION
                                    ; TRY SINES, TRAINGLES, OR ASCENDING LINES FROM -1 TO +1 
                                    ; (PHASOR) ETC FOR INDEX FUNCTION
ayndx   =       frac(kyndx+1000.5+kytrans)  ; NEED FRACTIONAL VALUES
                                    ; TO GO FROM ONE TERRAIN BOUNDARY TO THE OTHER
                                    ; 1000.5 AVOIDS NEGATIVE VALUES AND SETS START POINT
                                    ; AT TABLE MIDPOINT
ax      tablei  axndx,p19,1,0,0     ; NORMALIZED (-1 TO +1) AUDIO FOR X PLANE
ay      tablei  ayndx,p20,1,0,0     ; NORMALIZED (-1 TO +1) AUDIO FOR Y PLANE
az      =       (ax*ay)*kenv        ; TRACKS Z PLANE TO GENERATE TERRAIN WAVEFORM
        out     az
        endin       


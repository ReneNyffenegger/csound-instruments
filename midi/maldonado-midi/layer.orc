; "FOUR IN ONE" EXAMPLE OF USING MIDIC7 AS A SWITCH FOR SEVERAL INSTRUMENTS

instr          1
  icps      cpsmidi   
  iamp      ampmidi   4000

;/////////////////////////////////////////////////////////////////////
  ijump     midic7    1,0,4                       ;SWITCH FOUR INSTRUMENTS AT INIT TIME (RANGE 0-4)
                         ;    1=instr1 
                         ;    2=instr2 
                         ;    3=instr3
                         ;    4=instr4
;//////////////////////////////////////////////////////////////////////
  kctr1     midic7    12,0,1                      ;SCALES DIFFERENT INSTRUMENTS PARAMETERS (RANGE 0-1)
  kctr2     midic7    13,0,1                      ;SCALES DIFFERENT INSTRUMENTS PARAMETERS (RANGE 0-1)
;
if   ijump > 1      goto two                      ;IMIDIC7 DEPENDENT JUMP
;*******instrument 1 (simple oscillator plus amp envelope)
  kmp       linenr    iamp, .01, 1, .03           ; AMPENV
  a1        oscili    kmp, icps, 2                ; AUDIO OSCILLATOR
            goto      out
;***********************************
;
two:
if        ijump > 2      goto three
;*******iNSTRUMENT 2 (FM SYNTHESIS)
  kmp       linenr    iamp*5,.04,.2,.03           ; AMPENV
  kndx      oscil1i   0, 30, .6, 10               ; MOD INDEX CONTROL
  a1        foscili   kmp, icps*.25, 2, kctr1*4, kndx*kctr2, 1 
            goto      out
;***********************************
;
three:
if        ijump > 3      goto four
;*******iNSTRUMENT 3 (RING MODULATION AND CLIPPING SYNTHESIS)
  kmp       linenr    iamp*5,.04,.2,.03           ;AMPENV
  kamp2     oscili    iamp*.5,.25,11              ;CLIPPING CONTROL
  am1       oscili    kmp*.01,icps,1              ;CARRIER
  am2       oscili    kmp*kctr1*.1,icps*kctr2*2+.5,1 ;MODULATOR
  a1        =  am1*am2                            ;RING MODULATION
  a1        limit     a1,-kamp2,kamp2             ;CLIP MODULATION
  a1        =  a1*iamp/kamp2                      ;AMPLITUDE RESCALING
            goto      out
;***********************************
;
four:
;*******INSTRUMENT 4 (KARPLUS-STRONG SYNTHESIS)
  kmp       linenr    iamp*5,0,.2,.03             ;ampenv
  a1        pluck     kmp, icps, 10000, 5, 1
;***********************************
out:
            out       a1
endin





























































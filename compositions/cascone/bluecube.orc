;=============================================================================
;
;              *** BLUECUBE ***
;                Kim Cascone
;
;=============================================================================
;   -- bluecube.orc
;
; * an experimental ambient Csound piece for Richard Boulangers book on Csound...
; * this uses Rissets drum2 orc and replaces the inharmonic branch
;   with a RM pair of oscs
; * asig1 osc linen instead of linseg
; * osc asig2 uses the inharmonic wvfm from table f3
; * I added a noise band (instr2) which is fed to a filter (reson)
;
;===================================================================
;         **** DESIGN NOTES ****
;===================================================================
;
;***FIX*** global input delay instr
;
;***FIXED***global delay is parallel rather than series
;
;*check out some other reverb designs...does Whittles/Gogins version have a different RVB?
;
;*change all the panning functions to constant power pans per Roads book
;
;*change all the noise freq args to 20000Hz where appropriate
;
;*also check out some filter designs for a square=>swept filter fx
;
;*implement a saw/noise ==> reson instr
;    **use the bp instr I developed utilizing the dsipfft opcode
;
;Done_*implement a clicky sound (filtered noise) whose note event repeats but is fed 
;
; through a reson with a line controlled sweep which might also control the pan L<==R
;
;==============================================================================

sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2


;=====================================
; REVERB INITIALIZATION
;=====================================

garvbsig  init      0


;=====================================
; DELAY INITIALIZATION
;=====================================

gasig     init      0



;==================================
; INSTUMENT 1 - THREE BRANCH INSTR
;==================================

          instr 1

i1        =         p5*.3
i2        =         p4*.98
i3        =         1/p3
i4        =         p5*.6
i5        =         p4
kfreq1    =         p6
kfreq2    =         p7
kamp2     =         p8



;=============================================
; 1 - NOISE BRANCH
;=============================================
a1        randi     i4, p9                   ;i4 WAS p5
a1        oscil     a1, i3, 10
a1        oscil     a1, 3000, 11             ;a1 IS THE NOISE OUTPUT
                                        

;===========================================
; 2 - RM BRANCH
;===========================================
kamp1     linen     kamp2, p3*.2, p3, p3*.2
asig1     oscil     kamp1, kfreq1, 11        ; AMP IS CONTROLLED BY LINEN, FREQ IS CONTROLLED BY p6
asig2     oscil     kamp2, kfreq2, 3         ; AMP IS CONTROLLED BY p8, FREQ IS CONTROLLED BY p7
aosc2     =         asig1*asig2
a2        =         aosc2*.085               ; THE OUTPUT a2 IS SCALED


;================================
; 3 - LOW SINE BRANCH
;================================
k3        oscil     i4, i3, 8                ; f8 = EXP ENV
a3        oscil     k3, i5, 4                ; f4 = SINE WAVE (LO RES)

a3        =         a3*.5                    ; a3 PROVIDES THE LOW SINE TONE


; OUTPUT TO FILTER, REVERB AND PANNING
;=====================================
iamp      =         p8*.4
aout      =         a1+a2+a3
kcf       linseg    0,p3/2,850,p3/2,0        ; THIS CONTROLS THE FILTER FRQ
kpan      oscil     1,0.1,17                 ; TRIANGLE WITH OFFSET (0-1) CONTROLS PANNING
alp       butterlp  aout, kcf                ; THREE BRANCHES ARE MIXED & FED THROUGH BUTTERLP
kenv      linen     iamp,p3*.8,p3,p3*.2      ; THIS IS THE MAIN ENV ON THE OUTPUT

alpout    =         kenv*alp
     
          outs      alpout*kpan,alpout*(1-kpan) ; STEREO OUTS  

garvbsig  =         garvbsig+(alpout*.2)     ; SEND .2 OF THE SIG TO RVB

          endin




;=================================================
; INSTRUMENT 2 --- a noise band glissando
;=================================================

          instr 2

kfreq     =         p5
                                        
kramp     linseg    0,p3*.8,p4,p3*.2,0       ; THIS CONTROLS THE AMP OF RANDI
kenv1     linen     p4,0, p3,10              ; THIS CONTROLS THE FRQ OF RANDI
anoise    randi     kramp,kenv1
aosc      oscil     anoise,kfreq,11          ; ANOISE IS FED TO THE A INPUT OF AOSC
kpan      oscil     1,.09,1
aosc2     reson     aosc,kpan+100,100,2      ; KPAN+100 IS OFFSET FOR FILTER SWEEP INPUT
          outs      aosc2*kpan,aosc2*(1-kpan)

garvbsig  =         garvbsig+(aosc2*.2)


          endin


;===============================================
; INSTRUMENT 3 - a sinewave instrument
;===============================================

          instr 3
kpan      =         p6
i1        =         p5*3

k1        oscil     i1, 1/p3, 10             ; ADSR
a2        oscil     k1, p4, 11               ; SINE
    
          outs      a2*kpan,a2*(1-kpan)

garvbsig  =         garvbsig+(a2*.1)

          endin




;=================================================================
;   INSTRUMENT 4 - SAMPLE & HOLD
;=================================================================

          instr 4

krt       =         p6                       ; THIS IS THE FRQ OF THE RANDH OUTPUT & CLK OSC
isd       =         p4                       ; p4 HOLDS THE VALUE OF THE SEED OF RANDH UG
krn       randh     1000,krt,isd             ; NOISE INPUT TO S&H
kclk      oscil     100,krt,14               ; KCLK CLOCKS THE S&H -- f14 IS A DUTY CYCLE WAVE
ksh       samphold  krn, kclk ;S&H
a2        oscil     600, ksh,11              ; SINE OSC CONTROLLED BY S&H;;;amp=600
a3        oscil     a2,1/p3,10               ; f10=ADSR -- a3 IS THE OUTPUT
kpan      oscil     1,.04,17


asig1     =         a3*kpan
asig2     =         a3*(1-kpan)

          outs      asig1,asig2


garvbsig  =         garvbsig+(a3*.2)

          endin


;======================================================
;   INSTRUMENT 5 - FM W/REVERSE ENV
;
;======================================================
;    CHANGES TO INSTR 5
;____________________________________
; MAKE A ARG IN foscili = 10
; PUT FOSCILI OUT INTO OSC W/F18
; THE EFFECT I WANT IS A CASCADE OF SHORT B'WARDS FM SOUNDS THAT GO FROM
; RIGHT TO LEFT...SUBTLE YET PRESENT...LIKE A FLOCK OF METAL BIRDS
;========================================================================

          instr 5

kcps      =         p4
kcar      =         p5
kmod      =         p6
kpan      =         p7                       ; SCORE DETERMINES PAN POSITION
kndx      =         p8                      
kamp      =         p9
krvb      =         p10

; kcar    line      2,p3*.9,0
; kenv    oscil     3,1/p3,10

afm       foscili   kamp,kcps,kcar,kmod,kndx,11 ; f11 = HIRES SINE WAVE
afm1      oscil     afm,1/p3,18

afm2      =         afm1*400                 ; THIS INCERASES THE GAIN OF THE FOSCILI OUTx400

; krtl    =         sqrt(kpan)               ; SQRT PANNING TECHNIQUE
; krtr    =         sqrt(1-kpan)             ; pg 247,FIG.7.20 DODGE/JERSE BOOK


krtl      =         sqrt(2)/2*cos(kpan)+sin(kpan) ; CONSTANT POWER PANNING
krtr      =         sqrt(2)/2*cos(kpan)-sin(kpan) ; FROM C.ROADS "CM TUTORIAL" pp460

al        =         afm2*krtl
ar        =         afm2*krtr
     
          outs      al,ar


;         outs      afm2*kpan,afm2*(1-kpan)

garvbsig  =         garvbsig+(afm2*krvb)     ; SEND AMOUNT WAS .2

          endin

;==================================================
;
;    INSTRUMENT 6 - CLICKY FILTER SWEEP W/PAN
;
;
;    TAKE A NOISE SOURCE AND BP FILTER
;    PASS TO AMP => LP FILTER
;    THEN PAN ACROSS STEREO FIELD 
;    
;=================================================


          instr 6
                                             
aclk      =         p3*4.3                   ; THIS IS THE FRQ FOR THE FILTER AND ADSR
                                             ; [THIS COMMENT ABOVE DIDN'T HAVE A ";" BEFORE IT
                                             ; AND MIGHT HAVE NOT HAD AN EFFECT ON THE CODE] 2/16

;arnd     randi     7000, 5000               ; NOT USING THIS NOISE SOURCE::USING PULSE INSTEAD
apls      oscil     7000,aclk,2              ; THIS GENERATES A SMALL SPIKE SHAPED LIKE A EXP ENV f2
abp       butterbp  apls,2500,200            ; THIS FILTERS THE SPIKE SO ITS MORE CLICKY SOUNDING
abp       =         abp*3                    ; THIS BOOSTS THE LEVEL OF THE FILTER OUT
anoise    oscil     abp,aclk,8               ; THIS GIVES THE FILTERED SIGNAL THE SAME ENV AS THE WAVEFORM    
kswp      line      1800,p3,180              ; THIS CONTROLS THE RESON FILTER::STRT frq=1800, END frq=180
;kswp     expon     2600,p3,300
afilt     reson     anoise,kswp,20           ; RESON CREATES A FILTER SWEEP
;afilt    =         afilt*.4
afilt2    oscil     afilt,1/p3,10            ; THIS ENVELOPES THE FILTER OUTPUT
kpan      line      0,p3*.8,1                ; THIS IS USED FOR THE PANNING OF THE OUTPUT
afilt2    =         afilt2*.05               ; THIS SCALES THE OUTPUT OF THE FILTER       
     
          outs      afilt2*kpan,afilt2*(1-kpan)

garvbsig  =         garvbsig+(afilt2*.02)
     
gasig     =         gasig+(afilt2*.6)


          endin


;===================================================
;
;    INSTR 7 - NOISE BAND GLISSANDO (UNMODIFIED)
;    PAN ISN'T WORKING FOR SOME STRANGE REASON
;    FIND A GOOD COMBO OF OSCIL FREQ AND randi FR
;
;======================================================



;         instr 7

;;;       ampdb(p6)

; kamp    linen     10000,p3*.08,p3,p3*.02   ; THIS IS THE CONTROL FOR THE RANDH          
; arnd    randi     kamp,15                  ; THIS IS THE NOISE BAND
; kfr          linseg    p4,p3,p5                 ; THIS CONTROLS THE SWEEP FOR THE OSCIL
; kpan    oscil     20,.33,11                ; .5Hz SINEWAVE PANNING OSCIL
; agliss  oscil     arnd,kfr,11              ; THIS IS THE RM
; agliss  =         agliss*p6*.25
                                             
;;; krtl  =         sqrt(2)/2*cos(kpan)+sin(kpan) ; CONSTANT POWER PANNING
;;; krtr  =         sqrt(2)/2*cos(kpan)-sin(kpan) ; FROM C.ROADS "CM TUTORIAL" pp460

;;; al    =         agliss*krtl
;;; ar    =         agliss*krtr
;;;       outs      al,ar

;         outs      agliss*kpan,agliss*(1-kpan)

     
; garvbsig =        garvbsig+(agliss*.099)


     
;         endin


;======================================================
;
;    INSTR 8 -- CASCADE HARMONICS
;    [BORROWED INSTR FROM RISSET]
;
;======================================================

          instr 8


i1        =         p6                       ; INIT VALUES CORRESPOND TO FREQ.
i2        =         2*p6                     ; OFFSETS FOR OSCILLATORS BASED ON ORIGINAL p6
i3        =         3*p6
i4        =         4*p6
                                             
ampenv    linen     p5,30,p3,30              ; ENVELOPE

a1        oscili    ampenv,p4,20
a2        oscili    ampenv,p4+i1,20          ; NINE OSCILLATORS WITH THE SAME AMPENV
a3        oscili    ampenv,p4+i2,20          ; AND WAVEFORM, BUT SLIGHTLY DIFFERENT
a4        oscili    ampenv,p4+i3,20          ; FREQUENCIES TO CREATE THE BEATING EFFECT
a5        oscili    ampenv,p4+i4,20
a6        oscili    ampenv,p4-i1,20          ; p4 = fREQ OF FUNDAMENTAL (Hz)
a7        oscili    ampenv,p4-i2,20          ; p5 = AMP
a8        oscili    ampenv,p4-i3,20          ; p6 = INITIAL OFFSET OF FREQ - .03 Hz
a9        oscili    ampenv,p4-i4,20
      
asnd      =         (a1+a2+a3+a4+a5+a6+a7+a8+a9)/9

          ;outs     a1+a2+a3+a4,a5+a6+a7+a8+a9
          outs      a1+a3+a5+a7+a9,a2+a4+a6+a8


garvbsig  =         garvbsig+(asnd*.85)


          endin

;=================================================================
;   INSTRUMENT 9 -- WATER
;=================================================================

          instr 9
                                             
krt       =         p6                       ; THIS IS THE FRQ OF THE RANDH OUTPUT & CLK OSC
isd       =         p4                       ; p4 HOLDS THE VALUE OF THE SEED OF RANDH UG
krn       randh     10000,krt,isd            ; NOISE INPUT TO S&H
kclk      oscil     100,krt,14               ; KCLK CLOCKS THE S&H -- f14 IS A DUTY CYCLE WAVE
ksh       samphold  krn, kclk                ; S&H
a2        oscil     2, 100,11                ;; SINE OSC (11) CONTROLLED BY S&H;;;AMP=600
ksh       =         ksh*.50
a4        reson     a2,ksh,50                ; FILTER WITH S&H CONTROLING THE Fc
a3        oscil     a4,1/p3,10               ; f10=ADSR -- a3 IS THE OUTPUT
a3        =         a3*.15
kpan      oscil     1,.14,17


asig1     =         a3*kpan
asig2     =         a3*(1-kpan)

          outs      asig1,asig2


garvbsig  =         garvbsig+(a3*.4)         ; .2

          endin

;===================
; GLOBAL REVERB
;===================

          instr 99

a1        reverb2   garvbsig, p4, p5
          outs      a1,a1

garvbsig  =         0

          endin




;====================
;
; GLOBAL DELAY
;
;====================

          instr 98            ; THIS DELAY IS IN PARALLEL CONFIG
                                             
a1        delay     gasig,p4                 ; DELAY=1.25
a2        delay     gasig,p4*2               ; DELAY=2.50
          outs      a1,a2

gasig     =         0

          endin

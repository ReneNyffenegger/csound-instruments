; Howard Fredrics
; 4:02PM  2/13/1989
; mus329J

;====================================================================;
;                       Webern Orchestra                          
;====================================================================;
sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

;=========================================================================;
;                 Simple Gating Instrument with Chorus                    ;
;                                                                         ;
; p4=amp      p5=pch1       p6=pch2       p7=risefac      p8=decfac       ;
; p9=ofn1    p10=ofn2      p11=gatefn    p12=beathz      p13=gatehz       ;
;=========================================================================;
          instr     5,6,7,8

igatehz   =         (p13 == 0 ? 1/p3 : p13)  ; DEFAULT TO ONCE PER NOTE
ihalfamp  =         p4/2       ipitch1      =       cpspch(p5)
ipitch2   =         cpspch(p6)   ibeatfreq   =       p12
idetune2  =         ipitch2 + ibeatfreq

kgate     oscili    1,igatehz,p11            ; p11 HAS GATING CONTROL Fn#
kenvlp    linen     1,p3*p7,p3,p3*p8         ; p7,p8 ARE RISE, DECAY FACS

asig1     oscili    p4,ipitch1,p9            ; SOUND ONE
astraight2 oscili   ihalfamp,ipitch2,p10     ; STRAIGHT SOUND TWO
adetune2  oscili    ihalfamp,idetune2,p10    ; DETUNED SOUND TWO
asig2     =         astraight2 + adetune2    ; SOUND TWO
                                             
aout1     =         asig1 * kgate
aout2     =         asig2 * (1-kgate)
aoutsig   =         (aout1 + aout2) * kenvlp ; OUTPUT THE SUM
                
          outs      aoutsig,aoutsig
          endin
;==========================================================================;
;               Basic FM Instrument with Variable Vibrato                  ;
;                                                                          ;
;  p4=amp       p5=pch(fund)    p6=vibdel       p7=vibrate      p8=vibwth  ;
;  p9=rise      p10=decay       p11=max index   p12=car fac     p13=modfac ;
;  p14=index rise  p15=index decay  p16=left channl factor p17=original p3 ;
;  p18=vibfn       p20=irisefn      p21=inrisefn                           ;
;==========================================================================;
          instr   9,10
;------------------------------------------------; INITIALIZATION BLOCK:
kpitch    init cpspch (p5)
                                             
itempo    =         p3/p17                   ; RATIO SECONDS/BEATS
idelay    =         p6 * itempo              ; CONVERT BEATS TO SECS
irise     =         p9 * itempo
idecay    =         p10 * itempo
indxris   =         (p14 == 0 ? irise : p14 * itempo)
indxdec   =         (p15 == 0 ? idecay : p15 * itempo)
ivibfn    =         p18
irisefn   =         p20
inrisefn  =         (p21 == 0 ? irisefn : p21)
          if        (p16 != 0) igoto panning ; IF A PANFAC, USE IT, ELSE
ilfac     =         .707                     ; DEFAULT IS MONO (sqrt(.5))
irfac     =         .707
          igoto     perform
panning:
ilfac     =         sqrt(p16)
irfac     =         sqrt(1-p16)
;------------------------------------------------; PERFORMANCE BLOCK:
perform:
          if        (p7 == 0 || p8 == 0) goto continue
kontrol   oscil1    idelay,1,.2,2            ; VIB CONTROL
kvib      oscili    p8*kontrol,p7*kontrol,ivibfn ; VIBRATO UNIT
kpitch    =         cpsoct(octpch(p5)+kvib)  ; VARYING FUND PITCH IN Hz
continue:
kamp      envlpx    p4,irise,p3,idecay,irisefn,1,.01 ; irisefn FOR SHAPE OF CELLO
kindex    envlpx    p11,indxris,p3,indxdec,inrisefn,1,.01

asig      foscili   kamp/3,kpitch,p12,p13,kindex,1 ; p12=CARFAC,p13=MODFAC
          outs      asig*ilfac,asig*irfac
          endin       

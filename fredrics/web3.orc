;HOWARD FREDRICS
;4:02PM  2/13/1989
;MUS329J

;====================================================================;
;                       WEBERN ORCHESTRA                          
;====================================================================;
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2


;=========================================================================;
;                 SIMPLE GATING INSTRUMENT WITH CHORUS                    ;
;                                                                         ;
; P4=AMP      P5=PCH1       P6=PCH2       P7=RISEFAC      P8=DECFAC       ;
; P9=OFN1    P10=OFN2      P11=GATEFN    P12=BEATHZ      P13=GATEHZ       ;
;=========================================================================;
instr     5,6,7,8

  igatehz   =  (p13 == 0 ? 1/p3 : p13)            ;DEFAULT TO ONCE PER NOTE
  ihalfamp  =  p4/2  
  ipitch1   =  cpspch(p5)
  ipitch2   =  cpspch(p6)       
  ibeatfreq =  p12
  idetune2  =  ipitch2 + ibeatfreq

  kgate     oscili    1,igatehz,p11               ;P11 HAS GATING CONTROL FN#
  kenvlp    linen     1,p3*p7,p3,p3*p8            ;P7,P8 ARE RISE, DECAY FACS

  asig1     oscili    p4,ipitch1,p9               ;SOUND ONE
  astraight2   oscili   ihalfamp,ipitch2,p10      ;STRAIGHT SOUND TWO
  adetune2  oscili    ihalfamp,idetune2,p10       ;DETUNED SOUND TWO
  asig2     =  astraight2 + adetune2              ;SOUND TWO

  aout1     =  asig1 * kgate
  aout2     =  asig2 * (1-kgate)
  aoutsig   =  (aout1 + aout2) * kenvlp           ;OUTPUT THE SUM
                
            outs      aoutsig,aoutsig
endin
;==========================================================================;
;               BASIC FM INSTRUMENT WITH VARIABLE VIBRATO                  ;
;                                                                          ;
;  P4=AMP       P5=PCH(FUND)    P6=VIBDEL       P7=VIBRATE      P8=VIBWTH  ;
;  P9=RISE      P10=DECAY       P11=MAX INDEX   P12=CAR FAC     P13=MODFAC ;
;  P14=INDEX RISE  P15=INDEX DECAY  P16=LEFT CHANNL FACTOR P17=ORIGINAL P3 ;
;  P18=VIBFN       P20=IRISEFN      P21=INRISEFN                           ;
;==========================================================================;
instr     9,10
;------------------------------------------------;INITIALIZATION BLOCK:
  kpitch    init      cpspch (p5)

  itempo    =  p3/p17                             ;RATIO SECONDS/BEATS
  idelay    =  p6 * itempo                        ;CONVERT BEATS TO SECS
  irise     =  p9 * itempo
  idecay    =  p10 * itempo
  indxris   =  (p14 == 0 ? irise : p14 * itempo)
  indxdec   =  (p15 == 0 ? idecay : p15 * itempo)
  ivibfn    =  p18
  irisefn   =  p20
  inrisefn  =  (p21 == 0 ? irisefn : p21)
if       (p16 != 0) igoto panning                 ;IF A PANFAC, USE IT, ELSE
  ilfac     =  .707                               ;DEFAULT IS MONO (SQRT(.5))
  irfac     =  .707
            igoto     perform
panning:
  ilfac     =  sqrt(p16)
  irfac     =  sqrt(1-p16)
;------------------------------------------------     ;PERFORMANCE BLOCK:
perform:
if       (p7 == 0 || p8 == 0) goto continue
  kontrol   oscil1    idelay,1,.2,2               ;VIB CONTROL
  kvib      oscili    p8*kontrol,p7*kontrol,ivibfn ;VIBRATO UNIT
  kpitch    =  cpsoct(octpch(p5)+kvib)            ;VARYING FUND PITCH IN HZ
continue:
  kamp      envlpx    p4,irise,p3,idecay,irisefn,1,.01 ;IRISEFN FOR SHAPE OF CELLO
  kindex    envlpx    p11,indxris,p3,indxdec,inrisefn,1,.01

  asig      foscili   kamp/3,kpitch,p12,p13,kindex,1 ;P12=CARFAC,P13=MODFAC
            outs      asig*ilfac,asig*irfac
endin       

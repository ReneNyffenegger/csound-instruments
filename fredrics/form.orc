;HOWARD FREDRICS
;7:41PM  2/23/1989
;MUS329J
;
;====================================================================;
;                       FORMANT INSTRUMENT                          ;
;====================================================================;
;
;                               HEADER
;
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

;=========================================================================;
;                           PARAMETER FIELDS                         
;
;
; P1   =       INSTRUMENT #
; P2   =       START TIME
; P3   =       DURATION IN SECONDS     (IDUR)
; P4   =       MAX PEAK AMP OF NOTE    (IPKAMP)
; P5   =       FUNDAMENTAL FREQUENCY   (IFUND)
; P6   =       FORMANT FREQUENCY (CPS) (IWISHFORM)
; P7   =       MAX FREQ. MOD. INDEX    (INDEX)
; P8   =       FM M:C RATIO FOR FUND   (IRATIO)
; P9   =       ATTACK TIME IN SEC.     (ITAK)
; P10  =       DECAY TIME IN SEC.      (IDEC)
; P11  =       RELATIVE AMP OF FORMANT (IFORMAMP)
; P12  =       INITIAL P3 (TO BE USED IN CONVERTING ATT & DEC FROM BEATS TO SECS.
; P13  =       DUMMY P-FIELD
;=========================================================================;
;
;                              INITIALIZATION BLOCK
;
instr       1,2,3,4
  idummy    =  p13                                ;DUMMY P-FIELD TO SUPPRESS WARNING
  ioctmid   =  3+(p5/12)                          ;FUNDAMENTAL (P5) CONVERTED FROM MIDI NN TO OCT (YES, I LIKE MIDI NOTE NUMBERS...GETTING CAUGHT IN THE RAIN....(R.HOLMES)
  ifund     =  cpsoct(ioctmid)                    ;FUNDAMENTAL CONVERTED FROM OCT TO CPS
  iwishform =  p6                                 ;DESIRED FORMANT FREQUENCY IN CPS
  iactform  =  int((iwishform/ifund)+.5)*ifund    ;FORMANT FREQ. SHIFTED TO NEAREST INTEGER HARMONIC
  iratio    =  p8                                 ;M:C RATIO FOR FUND (WHERE FUND[CARRIER] RATIO ALWAYS = 1)
  imod      =  ifund*iratio                       ;FMOD IS A MULTIPLE OF THE FUND[CARRIER]
  index     =  p7*imod                            ;FMI FOR FUNDAMENTAL
  ifindex   =  p11*index                          ;FMI FOR FORMANT AS FUNCTION OF REL AMPLITUDE
  ifunfordex   =      index/ifindex               ;CAUSE FORMANT INDEX TO BE VARIED ALONG WITH FUND INDEX
  ipkamp    =  p4                                 ;PEAK AMP IS TO BE ENTERED IN VALS 0-1.  VAL LATER SCALED TO 16 BIT DAC
  iformamp  =  p11                                ;RELATIVE FORMANT WEIGHT IN VALS 0-1
  ifundamp  =  (1-p11)                            ;RELATIVE FUND WEIGHTING AS REMAINING FACTOR OF VAL BETWEEN 0-1
  idur      =  p3                                 ;DURATION IN SECS
  itempo    =  idur/p12                           ;RATIO OF SECS/BEATS
  itak      =  p9*itempo                          ;ATTACK TIME
  idec      =  p10*itempo                         ;DECAY TIME
  imodtak   =  itak*1.5                           ;ATTACK FOR MOD GATE
  imoddec   =  idec*.8                            ;DECAY FOR MOD GATE
;
;===========================================================================
;
;                              PERFORMANCE BLOCK
;
;
  kmgate    linen     1,imodtak,idur,imoddec      ;LINEAR ENVELOPE FOR MODULATOR
  amod      oscili    index*kmgate,imod,1         ;MODULATOR SIGNAL
  kgate     linen     ipkamp,itak,idur,idec       ;LINEAR ENVELOPE
  afund     oscili    kgate*ifundamp,ifund+amod,1 ;FUNDAMENTAL SIGNAL
  aform     oscili    kgate*iformamp,iactform+(ifunfordex*amod),1 ;FORMANT SIGNAL
            out       (afund+aform)*32767         ;SEND IT OUT SCALED TO 16 BIT DAC
endin
        

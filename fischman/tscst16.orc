; TSCST16.ORC    GRANULAR SYNTHESIS ENGINE
;                        (c) Rajmil Fischman, 1997
;----------------------------------------
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

instr 16
;-------------------------------------------; PARAMETER LIST
; p4 : MAXIMUM OVERALL AMPLITUDE
; p5 : OVERALL AMPLITUDE ENVELOPE FUNCTION TABLE
; p6 : MINIMUM GRAIN DURATION
; p7 : MAXIMUM GRAIN DURATION
; p8 : GRAIN DURATION FUNCTION
; p9 : GRAIN WAVEFORM FUNCTION TABLE
; p10: GRAIN ENVELOPE FUNCTION TABLE
; p11: LOWER BAND LIMIT MINIMUM FREQUENCY 
; p12: LOWER BAND LIMIT MAXIMUM FREQUENCY
; p13: LOWER BAND LIMIT SHAPE FUNCTION TABLE
; p14: UPPER BAND LIMIT MINIMUM FREQUENCY 
; p15: UPPER BAND LIMIT MAXIMUM FREQUENCY
; p16: LOWER BAND LIMIT SHAPE FUNCTION TABLE
; p17: MINIMUM C/M
; p18: MAXIMUM C/M
; p19: C/M FUNCTION
; p20: MINIMUM FM INDEX
; p21: MAXIMUM FM INDEX
; p22: FM INDEX FUNCTION
; p23: MAXIMUM PAN VALUES:
;                                       BEYOND LEFT SPEAKER < -1
;                                       LEFT SPEAKER = -1
;                                       BETWEEN SPEAKERS <1 AND > -1
;                                       RIGHT SPEAKER = 1
;                                       BEYOND RIGHT SPEAKER = -1
; p24: PAN FUNCTION
; P25: MAXIMUM SCATTER (1 COVERS FULL SPREAD BETWEEN SPEAKERS)
; p26: SCATTER FUNCTION
; p27: SEED FOR RANDOM NUMBER GENERATORS (0<p27<1)
;----------------------------------------       ; GENERAL INITIALIZATION
  idur      =  p3                                 ; DURATION
  iseed     =  p27                                ; RANDOM NUMBER SEED
;----------------------------------------       ; OVERALL AMPLITUDE
  imaxamp   =  p4                                 ; MAXIMUM AMPLITUDE
  iampfunc  =  p5                                 ; AMPLITUDE FUNCTION TABLE
  kenv      oscil1    0,imaxamp,idur,iampfunc     ; OVERALL ENVELOPE
;----------------------------------------       ; GRAIN DURATION and RATE
  imingd    =  p6/1000.0                          ; MINIMUM GRAIN DURATION
  imaxgd    =  p7/1000.0                          ; MAXIMUM GRAIN DURATION
  igddiff   =  imaxgd-imingd                      ; DIFFERENCE
  igdfunc   =  p8                                 ; GRAIN DURATION FUNCTION TABLE
  kgdur     oscil1    0,igddiff,idur,igdfunc      ; GRAIN DURATION FLUCTUATION
  kgdur     =  imingd+kgdur                       ; GRAIN DURATION
  kgrate    =  1.0/kgdur                          ; GRAIN RATE
;----------------------------------------       ; FREQUENCY BAND LOWER LIMIT
  ilfbmin   =  p11                                ; MINIMUM FREQUENCY OF LIMIT
  ilfbmax   =  p12                                ; MAXIMUM FREQUENCY OF LIMIT
  ilfbdiff  =  ilfbmax-ilfbmin                    ; DIFFERENCE
  ilbffunc  =  p13                                ; LOWER LIMIT FUNCTION
  klfb      oscil1    0,ilfbdiff,idur,ilbffunc    ; LOWER LIMIT FLUCTUATION        
  klfb      =  ilfbmin+klfb                       ; LOWER LIMIT
;----------------------------------------       ; FREQUENCY BAND UPPER LIMIT
  iufbmin   =  p14                                ; MINIMUM FREQUENCY OF LIMIT
  iufbmax   =  p15                                ; MAXIMUM FREQUENCY OF LIMIT
  iufbdiff  =  iufbmax-iufbmin                    ; DIFFERENCE
  iubffunc  =  p16                                ; UPPER LIMIT FUNCTION
  kufb      oscil1    0,iufbdiff,idur,iubffunc    ; UPPER LIMIT FLUCTUATION
  kufb      =  iufbmin+kufb                       ; UPPER LIMIT
;----------------------------------------       ; CARRIER TO MODULATOR RATIO
  icmrmin   =  p17                                ; MINIMUM C/M
  icmrmax   =  p18                                ; MAXIMUM C/M
  icmrdiff  =  icmrmax-icmrmin                    ; C/M DIFF
  icmrfunc  =  p19                                ; C/M FLUCTUATION FUNCTION
  kcmr      oscil1    0,icmrdiff,idur,icmrfunc    ; CARRIER TO MODULATOR RATIO FLUCTUATION
  kcmr      =  icmrmin+kcmr                       ; CARRIER TO MODULATOR RATIO
;----------------------------------------       ; INDEX
  iidxmin   =  p20                                ; MINIMUM INDEX
  iidxmax   =  p21                                ; MAXIMUM INDEX
  iidxdiff  =  iidxmax-iidxmin                    ; INDEX DIFF
  iidxfunc  =  p22                                ; INDEX FLUXTUATION FUNCTION
  kidx      oscil1    0,iidxdiff,idur,iidxfunc    ; INDEX FLUCTUATION
  kidx      =  iidxmin+kidx                       ; CARRIER TO MODULATOR RATIO
;----------------------------------------       ; SCATTER               
  imaxscat  =  p25                                ; MAXIMUM SCATTER
  isctfunc  =  p26                                ; SCATTER FUNCTION
  kscat     oscil1    0,imaxscat,idur,isctfunc    ; CURRENT MAXIMUM SCATTER
  kgscat    randh     kscat,kgrate,iseed/5        ; GRAIN RANDOM SCATTER
;----------------------------------------       ; PANNING
  isr2      =  sqrt(2.0)                          ; SQUARE ROOT OF 2
  isr2b2    =  isr2/2.0                           ; HALF OF SQUARE ROOT OF 2
  imaxpan   =  p23                                ; MAXIMUM POSSIBLE PAN
  ipanfunc  =  p24                                ; PAN FUNCTION
  kpan      oscil1    0,imaxpan,idur,ipanfunc     ; PAN WITHOUT SCATTER
  kpan      =  kpan+kgscat                        ; ADD GRAIN SCATTER                      
if              kpan<-1 kgoto beyondl             ; CHECK FOR PAN BEYOND LEFT SPEAKER
if              kpan>1 kgoto beyondr              ; CHECK FOR PAN BEYOND RIGHT SPEAKER
;----------------------------------------       ; PAN BETWEEN SPEAKERS
  ktemp     =  sqrt(1+kpan*kpan)
  kpleft    =  isr2b2*(1-kpan)/ktemp
  kpright   =  isr2b2*(1+kpan)/ktemp
            kgoto     donepan
beyondl:
                                                                ; PAN BEYOND LEFT SPEAKER
  kpleft    =  2.0/(1+kpan*kpan)
  kpright   =  0
            kgoto     donepan
beyondr:
                                                                ; PAN BEYOND RIGHT SPEAKER
  kpleft    =  0
  kpright   =  2.0/(1+kpan*kpan)
donepan:
;----------------------------------------       ; GRAIN ENVELOPE
  igefunc   =  p10                                ; GRAIN ENVELOPE FUNCTION TABLE
  kgenvf    =  kgrate                             ; GRAIN ENVELOPE FREQUENCY
  kgenv     oscili    1.0,kgenvf,igefunc          ; ENVELOPE
;----------------------------------------       ; GRAIN FREQUENCY
  kgband    =  kufb-klfb                          ; CURRENT FREQUENCY BAND
  kgfreq    randh     kgband/2,kgrate,iseed       ; GENERATE FREQUENCY
  kgfreq    =  klfb+kgfreq+kgband/2               ; FREQUENCY
;----------------------------------------       ; GRAIN AMPLITUDE SCALING FACTOR 
                                                                        ; (BETWEEN 0.5 AND 1)
  ihmaxfc   =  0.25                               ; HALF OF MAXIMUM AMPLITUDE DEVIATION
  kgafact   randh     ihmaxfc,kgfreq,iseed/3      ; -ihmaxfc < RANDOM NUMBER < +ihmaxfc
  kgafact   =  1.00-(ihmaxfc+kgafact)             ; 2*ihmaxfc < SCALING FACTOR < 1.00
;--------------------------------------------; GRAIN GENERATOR
  igfunc    =  p9                                 ; GRAIN WAVEFORM FUNCTION TABLE
  agrain    foscili   kgenv,kgfreq,1,kcmr,kidx,igfunc ;FM GENERATOR              
;----------------------------------------       ; GRAIN DELAY (UP TO ITS WHOLE DURATION)
  kgdel     randi     kgdur/2,kgrate,iseed/2      ; RANDOM SAMPLE DELAY
  kgdel     =  kgdel+kgdur/2                      ; MAKE IT POSITIVE
  adump     delayr    imaxgd                      ; DELAY LINE
  adelgr    deltapi   kgdel
            delayw    kgafact*agrain
;----------------------------------------       ; DOPPLER SHIFT (FROM CSOUND MANUAL)
  ihspeakd  =  5.0                                ; HALF OF THE DISTANCE BETWEEN SPEAKERS (M)
  isndsp    =  331.45                             ; SOUND SPEED IN AIR (M/SEC)
  impandel  =  (imaxpan+imaxscat)*ihspeakd/isndsp ; MAXIMUM PAN DELAY
  kpdel     =  kpan*ihspeakd/isndsp               ; FIND PAN DELAY
  adump     delayr    impandel                    ; SET MAXIMUM DOPPLER DELAY
  agdop     deltapi   abs(kpdel)                  ; TAP DELAY ACCORDING TO PAN VALUE
            delayw    adelgr                      ; DELAY SIGNAL
;----------------------------------------       ; OUTPUT
  aout      =  kenv*agdop
            outs      kpleft*aout,kpright*aout
endin

